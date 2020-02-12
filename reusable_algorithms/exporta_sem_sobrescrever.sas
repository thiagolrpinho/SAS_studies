/* Código feito com o propósito de carregar 
uma tabela a partir de um banco postgresql
somente se ela não tiver sido carregada
anteriormente.
Criador por: Thiago Luis e Thiago Russo
Última alteração em: 17/10/2019
*/
%let libname_destino = PGE_JC_P.;
%let libname_origem = PGE_JC_S.;
%let tabela_destino = empresa_bruto;
%let tabela_origem = tb_empresas;

%macro sql;
  %if not %sysfunc(exist(&libname_destino..&tabela_destino.)) %then %do;
    proc sql;
      create table &libname_destino.&tabela_destino. as
      select *
      from &libname_origem.&tabela_origem.;
    quit;
  %end;
%mend sql;

%sql;