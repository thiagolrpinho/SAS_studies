libname POC_TCU "/SASData/POC/TCU/TABELAS_ENTRADA" compress=yes;

/* Conta o número de capítulos diferentes do NCM */
proc sql;
	CREATE TABLE WORK.LABEL_CONTAGEM AS
	SELECT 
		area,
		COUNT(*) as quantidade_area
	FROM POC_TCU.TCU_PECAS_SAIDA
	GROUP BY area
	ORDER BY quantidade_area DESC;
quit;


/* Agrupa NCM mais representados no dataset e classifica o resto como "Outros " */
data WORK.LABELS_OUTROS(drop= quantidade_area );
	set WORK.LABEL_CONTAGEM;
	format grupo_area $CHAR23.;
	if quantidade_area GE 25 then 
		do;
			grupo_area = area;
		end;
	else 
		do;
			grupo_area = "OUTROS";
		end;
run;


/* Cruza  as tabelas com as áreas e o novo agrupamento de áreas*/
PROC SQL;
  CREATE TABLE WORK.AREAS_AGRUPADAS_COM_ID AS 
  SELECT t2.id_peca, 
      t1.grupo_area
    FROM WORK.MULTILABELS_TRANSPOSTO t2
        INNER JOIN WORK.LABELS_OUTROS t1 ON (t2.area = t1.area);

  DROP TABLE WORK.LABEL_CONTAGEM;
  DROP TABLE WORK.LABELS_OUTROS;
QUIT;

/* Cruza  as tabelas com as peças com descrições com as áreas já serem classificadas.*/
PROC SQL;
  CREATE TABLE POC_TCU.MINER_TCU_PECAS AS 
  SELECT t2.id_peca,
      t2.texto_peca,
      t1.grupo_area as area
    FROM POC_TCU.PECAS_IMPORTADAS_LINHAS t2
        INNER JOIN WORK.AREAS_AGRUPADAS_COM_ID t1 ON (t2.area = t1.area);

  DROP TABLE WORK.AREAS_AGRUPADAS_COM_ID;
QUIT;