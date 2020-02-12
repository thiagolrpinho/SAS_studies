
/* Cruza  as tabelas com as peças com descrições com as áreas já classificadas.*/
PROC SQL;
  CREATE TABLE POC_TCU.TCU_MINER_PECAS_LABELS_AREAS AS 
  SELECT t2.id_peca,
      t2.pagina,
      t1.grupo_area as area
    FROM POC_TCU.PECAS_PAGINAS t2
        INNER JOIN WORK.AREAS_AGRUPADAS_COM_ID t1 ON (t2.id_peca = t1.id_peca);
QUIT;


/* Cruza  as tabelas com as peças com descrições com os t-emas já classificados.*/
PROC SQL;
  CREATE TABLE POC_TCU.TCU_MINER_PECAS_LABELS_TEMAS AS 
  SELECT t2.id_peca,
      t2.pagina,
      t1.grupo_tema as tema
    FROM POC_TCU.PECAS_PAGINAS t2
        INNER JOIN WORK.TEMAS_AGRUPADAS_COM_ID t1 ON (t2.id_peca = t1.id_peca);
QUIT;



/* Cruza  as tabelas com as peças com descrições com os subtemas já classificados.*/
PROC SQL;
  CREATE TABLE POC_TCU.TCU_MINER_PECAS_LABELS_SUBTEMAS AS 
  SELECT t2.id_peca,
      t2.pagina,
      t1.grupo_subtema as subtema
    FROM POC_TCU.PECAS_PAGINAS t2
        INNER JOIN WORK.SUBTEMAS_AGRUPADAS_COM_ID t1 ON (t2.id_peca = t1.id_peca);
QUIT;


data POC_TCU.TCU_MINER_PECAS (compress=yes drop= AREA);
    set TCU_MINER_PECAS_LABELS_AREAS;
run;

