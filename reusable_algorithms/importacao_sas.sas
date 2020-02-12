libname POCTCU "/SASData/POC/TCU/TABELAS_ENTRADA" compress=yes;
/* Código para importação de múltiplos arquivos txts usando a linguagem SAS
  Autor: Thiago Russo 
  Editor: Thiago Luis Rodrigues Pinho
  Última edição feita em: 02/08/2019
 */



%let TAMLINHA = 30000; 
/*O Miner irá interpretar cada conjunto de IDs como um único input então indifere como quebramos isso. Para evitar 
redundância, pegaremos blocos de 30k bytes*/

data POCTCU.pecas_importadas_linhas( compress = yes);
length fname $80.;
infile '/SASData/POC/TCU/DADOS_RECEBIDOS/*.txt' lrecl=&TAMLINHA. truncover filename=fname length=reclen;
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
