
/* Código desenvolvido para converter multi-labels em um várias linhas com um label único 
     para os subtemas da peças.
     Criador por: Thiago Luis Rodrigues Pinho
     Data: 23/08/2019
 */

data WORK.SINGLELABELS_SUBTEMAS(keep= id_peca subtema);
	set WORK.labels_id_corrigido;
	array vars{*} subtema1 subtema2 subtema3 subtema4 subtema5 subtema6 subtema7;
	do i = 1 to dim(vars);
		subtema = strip(upcase(vars[i]));
		if subtema ne '' then
			output;
	end;
run;

/* Conta o número de capítulos diferentes do NCM */
proc sql;
	CREATE TABLE WORK.LABEL_CONTAGEM AS
	SELECT 
		subtema,
		COUNT(*) as quantidade_subtema
	FROM WORK.SINGLELABELS_SUBTEMAS
	GROUP BY subtema
	ORDER BY quantidade_subtema DESC;
	
quit;


/* Agrupa NCM mais representados no dataset e classifica o resto como "Outros " */
data WORK.LABELS_OUTROS(drop= quantidade_subtema );
  set WORK.LABEL_CONTAGEM;
  format grupo_subtema $CHAR23.;
  if quantidade_subtema GE 25 then 
    do;
      grupo_subtema = subtema;
    end;
  else 
    do;
      grupo_subtema = "OUTROS";
    end;
run;

/* Cruza  as tabelas com as áreas e o novo agrupamento de áreas*/
PROC SQL;
  CREATE TABLE WORK.SUBTEMAS_AGRUPADAS_COM_ID AS 
  SELECT t2.id_peca, 
      t1.grupo_subtema
    FROM WORK.SINGLELABELS_SUBTEMAS t2
        INNER JOIN WORK.LABELS_OUTROS t1 ON (t2.subtema = t1.subtema);
QUIT;


/* Remove  as tabelas  intermediárias */
PROC SQL;
	DROP TABLE WORK.LABELS_OUTROS;
	DROP TABLE WORK.LABEL_CONTAGEM;
QUIT;