libname POC_TCU "/SASData/POC/TCU/TABELAS_ENTRADA" compress=yes;
/* Código para importação de múltiplos arquivos txts usando a linguagem SAS
  Autor: Thiago Russo 
  Editor: Thiago Luis Rodrigues Pinho
  Última edição feita em: 06/08/2019
 */

%let PATH_DADOS_RECEBIDOS = '/SASData/POC/TCU/DADOS_RECEBIDOS/*.txt';
%let PATH_DADOS_TESTE = '/SASData/POC/TCU/DADOS_RECEBIDOS/base_teste/*.txt';

%let TAMLINHA = 130; /* Esse tamanho foi medido após ler cada linha e ver o tamanho máximo 120 */
/*O Miner irá interpretar cada conjunto de IDs como um único input então indifere como quebramos isso. Para evitar 
redundância, pegaremos linha à linha */
%let TAMTITULO = 12;

data POC_TCU.pecas_importadas_linhas( compress = yes );
  length fname $80.;
  length id_peca $12.;

  infile &PATH_DADOS_RECEBIDOS. lrecl=&TAMLINHA. truncover filename=fname length=reclen;
  informat
    texto_peca $&TAMLINHA..;
  format 
    texto_peca $&TAMLINHA..;
  input 
    texto_peca $varying&TAMLINHA.. reclen;

  texto_peca = strip(texto_peca);
  id_peca = tranwrd(scan(fname, -1, '/'),'.txt', '');

  if strip(texto_peca) ne "" then
  output;


run;
