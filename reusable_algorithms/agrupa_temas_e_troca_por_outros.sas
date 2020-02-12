
/* Código desenvolvido para converter multi-labels em um várias linhas com um label único 
     para os temas da peças.
     Criador por: Thiago Luis Rodrigues Pinho
     Data: 23/08/2019
 */

data WORK.SINGLELABELS_TEMAS(keep= id_peca tema);
	set WORK.labels_id_corrigido;
	array vars{*} tema1 tema2 tema3 tema4 tema5 tema6 tema7;
	do i = 1 to dim(vars);
		tema = strip(upcase(vars[i]));
		if tema ne '' then
			output;
	end;
run;

/* Conta o número de capítulos diferentes do NCM */
proc sql;
	CREATE TABLE WORK.LABEL_CONTAGEM AS
	SELECT 
		tema,
		COUNT(*) as quantidade_tema
	FROM WORK.SINGLELABELS_TEMAS
	GROUP BY tema
	ORDER BY quantidade_tema DESC;
	
quit;


/* Agrupa NCM mais representados no dataset e classifica o resto como "Outros " */
data WORK.LABELS_OUTROS(drop= quantidade_tema );
  set WORK.LABEL_CONTAGEM;
  format grupo_tema $CHAR23.;
  if quantidade_tema GE 25 then 
    do;
      grupo_tema = tema;
    end;
  else 
    do;
      grupo_tema = "OUTROS";
    end;
run;

/* Cruza  as tabelas com as áreas e o novo agrupamento de áreas*/
PROC SQL;
  CREATE TABLE WORK.TEMAS_AGRUPADAS_COM_ID AS 
  SELECT t2.id_peca, 
      t1.grupo_tema
    FROM WORK.SINGLELABELS_TEMAS t2
        INNER JOIN WORK.LABELS_OUTROS t1 ON (t2.tema = t1.tema);
QUIT;

/* Cruza  as tabelas com as peças com descrições com as áreas já serem classificadas.*/
PROC SQL;
  CREATE TABLE WORK.PECAS_COM_LABELS_TEMAS AS 
  SELECT t2.id_peca,
      t2.texto_peca,
      t1.grupo_tema as tema
    FROM POC_TCU.PECAS_IMPORTADAS_LINHAS t2
        INNER JOIN WORK.TEMAS_AGRUPADAS_COM_ID t1 ON (t2.id_peca = t1.id_peca);
QUIT;

/* Remove  as tabelas  intermediárias */
PROC SQL;
	DROP TABLE WORK.LABELS_OUTROS;
	DROP TABLE WORK.LABEL_CONTAGEM;
QUIT;
