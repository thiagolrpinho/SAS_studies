/* Código feito com o propósito de carregar 
uma tabela a partir de um banco postgresql
somente se ela não tiver sido carregada
anteriormente.
Criador por: Thiago Luis e Thiago Russo
Última alteração em: 02/10/2019
*/
%let libname_destino = tceentra.;
%let libname_origem = investi.;
%let tabela_carregada_sas = empresa_bruto;
%let tabela_origem_postgreesql = tb_empresas;

%macro sql;
  %if not %sysfunc(exist(&libname_destino..&tabela_carregada_sas.)) %then %do;
    proc sql;
      create table &libname_destino.&tabela_carregada_sas. as
      select *
      from &libname_origem.&tabela_origem_postgreesql.;
    quit;
  %end;
%mend sql;
%sql;