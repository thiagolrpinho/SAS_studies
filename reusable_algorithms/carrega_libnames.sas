/* Esse programa deve ser executado antes de qualquer outro no fluxo. 
Ele criar atalhos para as conexões listadas.
*/


LIBNAME projtce POSTGRES SCHEMA=proj_tce SERVER='192.168.8.23' DATABASE='postgres' PORT='5432' user=tce_postgres password='Vert@2019';
/* Schema final do banco postgreeSQL, somente devem ser enviadas para este esquema as tabelas já tratadas e que serão
usadas no Visual Investigator */

LIBNAME investi POSTGRES SCHEMA=investigator SERVER='192.168.8.23' DATABASE='postgres' PORT='5432' user=tce_postgres password='Vert@2019';
/* Schema fonte do banco postgreeSql, não devem ser enviadas tabelas para cá nem alteradas as que existem lá.
*/
LIBNAME  tceentra "/SASData/POC/TCE/TABELAS_ENTRADAS" compress=yes;
/* Caminho para a pasta reservada no ambiente SAS para armazenamento das tabelas recém carregadas do PostgreeSQL
 */

LIBNAME  tcesaida "/SASData/POC/TCE/TABELA_RESULTADOS" compress=yes;
/* Caminho para a pasta reserva para armazenamento das tabaelas que já sofreram alteração, 
mas não necessariamente serão enviadas para o PostgreeSQL
 */


/* Código feito com o propósito de mover tabelas entre 
LIBNAMES. Basta especificar a libname origem e a de destino
e os nomes da tabela existente e o desejado para o destino.
Caso uma tabela com o mesmo nome já exista no destino, 
o código não alterará a tabela existente.
Para usar, basta escrever:
%let libname_destino = LIBNAME_DESTINO.;
%let libname_origem = LIBNAME_ORIGEM.;
%let tabela_destino = NOME_TABELA_DESTINO;
%let tabela_origem = NOME_TABELA_ORIGEM;
%%copy_table;

Criador por: Thiago Luis e Thiago Russo
Editado por: Gabriel Vasconcelos
Última alteração em: 02/10/2019
*/
%let SOBRESCREVE = True;

%macro copy_table;
  %if not  %sysfunc(exist(&libname_destino.&tabela_destino.)) %then %do;
    proc sql;
      create table &libname_destino.&tabela_destino. as
      select *
      from &libname_origem.&tabela_origem.;
    quit;
  %end;
%mend copy_table;
