/* Código gerado com o intuito de evitar redundâncias no diagrama de redes do Visual Investigator.
O objetivo é retirar da ponte todas as licitações que temos um contrato referente já que o contrato
servirá de ponte no diagrama
Criado por: Thiago Luis e Thiago Guimarães 
Data: 10/10/2019
*/


proc sql;
  create table work.licitacao_sem_contrato as
  Select t1.id LABEL="Id Licitacao" AS id_licitacao 
  from   TCESAIDA.licitacao t1
  left join TCESAIDA.contrato t2
	      on t1.id = t2.id_licitacao
  where t2.id_licitacao is null;
quit;