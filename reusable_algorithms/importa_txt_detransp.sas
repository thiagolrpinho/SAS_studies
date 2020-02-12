libname DETRANSP "/SASData/POC/DETRANSP/TABELAS_ENTRADA" compress=yes;

/* Carrega o txt sem quebrar os campos obs=2000000 */
data DETRANSP.BINCODS;
  infile '/SASData/POC/DETRANSP/DADOS_RECEBIDOS/ARQUIVOS_TXT/BINCODS.TXT'  dsd truncover;
  length registro $740;
  input registro ;
  /*tamanho = length(registro);*/

data DETRANSP.CNHBLOQUEIODS;
  infile '/SASData/POC/DETRANSP/DADOS_RECEBIDOS/ARQUIVOS_TXT/CNH-BLOQUEIODS.TXT'  dsd truncover;
  length registro $320;
  input registro ;

data DETRANSP.CNHDESBLOQUEIODS;
  infile '/SASData/POC/DETRANSP/DADOS_RECEBIDOS/ARQUIVOS_TXT/CNH-DESBLOQUEIODS.TXT'  dsd truncover;
  length registro $540;
  input registro ;

data DETRANSP.PRONTDS;
  infile '/SASData/POC/DETRANSP/DADOS_RECEBIDOS/ARQUIVOS_TXT/PRONTDS.TXT'  dsd truncover;
  length registro $460;
  input registro ;

run;

/*

data _null_;
  infile '/sasdata/POC-DETRANSP-TXT/BINCODS.TXT' obs=10;
  input;
  list;
run;

*/