/* Código desenvolvido com a função de agrupar subtemas das representações do TCU 
com menos do que um número mínimo na categoria "Outros".
Criadores: Lucas Moutinho, Thiago Luis Pinho e Victor Ciurlini
Data: 16/09/2019
*/

/* Conta o número de subtemas dentro da amostra*/
proc sql;
	create table work.subtema_contagem as
	select subtema_amostra, count(*) as count
	from POC_TCU.TCU_MINER_TRAIN_SUBTEMA
	group by subtema_amostra
	order by count desc;
quit;

/* MAIOR TEMA LÁ*/

/* Parte responsável por classificar subtemas com menos do que 500 elementos em "Outros"*/
data WORK.subtema_marcado_outros (drop=count);
	set WORK.subtema_contagem;
	IF count GE 500 then
	DO;
		subtema = subtema_amostra;
	END;
	else
	do;
		subtema = "OUTROS";
	end;
RUN;

/* Cruza  as tabelas com as áreas e o novo agrupamento de áreas*/
PROC SQL;
  CREATE  TABLE WORK.subtema_amostra_com_id AS 
  SELECT DISTINCT t2.id_peca, 
      t1.subtema as subtema
    FROM POC_TCU.TCU_MINER_TRAIN_SUBTEMA t2
        INNER JOIN WORK.subtema_marcado_outros t1 ON (t2.subtema_amostra = t1.subtema);
QUIT;


/* Remove  as tabelas  intermediárias */
PROC SQL;
	DROP TABLE WORK.subtema_marcado_outros;
	DROP TABLE WORK.subtema_contagem;
QUIT;
