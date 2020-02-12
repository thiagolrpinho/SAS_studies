/*Código desenvolido a fim de selecionar o modelo com maior probabilidade média na escolha. 
Criado por: Thiago Luis Rodrigues Pinho, Thiago Guimarães Barros, Gabriel Vasconcelos e Lucas da Silva Moutinho
Data: 22/08/2019 
*/

libname PGESCORE "/SASData/POC/PGE_ES/SECRETARIA_SAUDE/PGE_MINER/Workspaces/EMWS1" compress=yes access=readonly;
libname PGESS_O "/SASData/POC/PGE_ES/SECRETARIA_SAUDE/TABELAS_RESULTADO" compress=yes;

/* Função responsável por determinar quais classificações estão abaixo da probabilidade de corte, diminuindo seu peso drasticamente 
seleção*/
DATA WORK.PONTO_DE_CORTE_6_LABELS;
	SET WORK.SCORE_TRATADO_6_LABELS;
	if EM_probability GT 0.8 then 
	do;
		ponto_de_corte = 1;
	end;
	else
	do;
		ponto_de_corte = 0.01;
	end;
run;


/* 	Agrupa as páginas que foram classificadas com o mesmo label e calcula sua contagem e média */
PROC SQL;
	CREATE TABLE WORK.MEDIA_DAS_PROBABILIDADES AS
	SELECT id_peticao,
			assunto,
			EM_classification,
			COUNT(*) as label_frequency,
			AVG(em_probability) as avg_probability,
			AVG(ponto_de_corte) as avg_ponto_de_corte,
			COUNT(*) * AVG(em_probability) * AVG(ponto_de_corte) AS score
	FROM WORK.PONTO_DE_CORTE_6_LABELS
	GROUP BY id_peticao, assunto, EM_classification
	ORDER BY id_peticao, score DESC;

	/*DROP TABLE WORK.PONTO_DE_CORTE_6_LABELS;*/
QUIT;


/* Código responsável por reconhecer duas classificações ou mais para um mesmo ID e selecionar por voto de maioria
 o correto */

DATA WORK.TEMPORARY_LABELS_REPETITIVE_ID(drop= temp_last_id temp_last_avg_probability temp_score temp_em_classification temp_assunto label_frequency);
	length temp_last_id $20.;
	length temp_last_avg_probability 4.;
	length temp_em_classification $32.;
	length temp_assunto $32.;
	length temp_score 4.;
	retain temp_last_id;
	
	do until(last.id_peticao);
		SET WORK.MEDIA_DAS_PROBABILIDADES(drop= avg_ponto_de_corte);
	by id_peticao notsorted;
	IF temp_last_id eq id_peticao then
		do; 
		   IF temp_score ge score then
		   	do;
			   	id_peticao = temp_last_id;
				avg_probability = temp_last_avg_probability;
				EM_CLASSIFICATION = temp_em_classification;
				assunto = temp_assunto;
				score = temp_score;
		   	end;
		end;
	ELSE
		DO;
			temp_last_id = id_peticao;
			temp_last_avg_probability = avg_probability;
			temp_em_classification = EM_CLASSIFICATION;
			temp_assunto = assunto;
			temp_score = score;
		end;
	output;
	end;
run;	

PROC SQL;
	CREATE TABLE WORK.LABEL_CLASSIFIED_DINTINCT_ID AS
	SELECT DISTINCT *
	FROM WORK.TEMPORARY_LABELS_REPETITIVE_ID
	ORDER BY id_peticao;


QUIT;



/* Parte responsável por adicionar uma coluna de acertos à tabela*/
PROC SQL;
   CREATE TABLE WORK.SCORE_DISTINCT AS 
   SELECT *,
          /* acerto */
            (IFN(t1.EM_CLASSIFICATION  eq t1.assunto, 1, 0, 0)) FORMAT=BEST1. LENGTH=3 LABEL="Acerto" AS acerto
      FROM WORK.LABEL_CLASSIFIED_DINTINCT_ID t1;
QUIT;




/* 
	Une as tabelas com um inner join e adiciona as probabilidades rejeitadas às escolhidas pelo modelo
*/


%_eg_conditional_dropds(PGESS_O.PGESS_VA_SCORE_PETICOES_PROB);
PROC SQL;
   CREATE TABLE PGESS_O.PGESS_VA_SCORE_PETICOES_PROB AS 
   SELECT t1.id_peticao, 
          t1.assunto, 
          t1.EM_CLASSIFICATION, 
          t1.avg_probability, 
          t1.score, 
          t1.acerto, 
          t2.P_assuntoRADIOTERAPIA_Mean LABEL="RADIOTERAPIA" AS P_assuntoRADIOTERAPIA_Mean, 
          t2.P_assuntoQUIMIOTERAPIA_Mean LABEL="QUIMIOTERAPIA" AS P_assuntoQUIMIOTERAPIA_Mean, 
          t2.P_assuntoTFD_Mean LABEL="TFD" AS P_assuntoTFD_Mean, 
          t2.P_assuntoOXIG__HIPERBARIC_Mean LABEL="OXIG_HIPERBARIC" AS P_assuntoOXIG__HIPERBARIC_Mean, 
          t2.P_assuntoOUTROS_Mean LABEL="OUTROS" AS P_assuntoOUTROS_Mean, 
          t2.P_assuntoTHERASUIT_Mean LABEL="THERASUIT" AS P_assuntoTHERASUIT_Mean
      FROM WORK.SCORE_DISTINCT t1
           INNER JOIN WORK.MEANSUMMARYSTATS_PAGINAS_PROBS t2 ON (t1.id_peticao = t2.id_peticao);
QUIT;


PROC SQL;
    DROP TABLE WORK.LABEL_CLASSIFIED_DINTINCT_ID;
    DROP TABLE WORK.PONTO_DE_CORTE_6_LABELS;
    DROP TABLE WORK.SCORE_DISTINCT;
    DROP TABLE WORK.MEDIA_DAS_PROBABILIDADES;
QUIT;