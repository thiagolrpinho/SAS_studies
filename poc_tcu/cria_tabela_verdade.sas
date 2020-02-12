/* Código tem como objetivo comparar duas tabelas e verificar aquelas que aparecem em ambos os casos. 
Autor: Lucas da Silva Moutinho
Editores: Thiago Luis Rodrigues Pinho e Victor Cirulini 
Última edição feita em 16/09/2019
*/


data label_original_marcada_sub;
	set SUBTEMA_DISTINTO;
	by id_peca;

	LABEL_ATESTADO = 0;
	LABEL_CERTIFICACAO  = 0;
	LABEL_CONSELHO = 0;
	LABEL_OUTROS = 0;
	LABEL_EXIGENCIA = 0;

	IF SUBTEMA = "ATESTADO DE CAPACIDADE TÉCNICA" THEN LABEL_ATESTADO = 1;
	IF SUBTEMA = "CERTIFICAÇÃO" THEN LABEL_CERTIFICACAO = 1;
	IF SUBTEMA = "CONSELHO DE FISCALIZAÇÃO PROFISSIONAL" THEN LABEL_CONSELHO = 1;
	IF SUBTEMA = "OUTROS" THEN LABEL_OUTROS  = 1;
	IF SUBTEMA = "EXIGÊNCIA" THEN LABEL_EXIGENCIA  = 1;
run;

proc sql;
	create table label_original_tabela_verd_sub as
	select id_peca
			,sum(LABEL_ATESTADO) as LABEL_ATESTADO
			,sum(LABEL_CERTIFICACAO) as LABEL_CERTIFICACAO
			,sum(LABEL_CONSELHO) as LABEL_CONSELHO
			,sum(LABEL_OUTROS) as LABEL_OUTROS
			,sum(LABEL_EXIGENCIA) as LABEL_EXIGENCIA
	from WORK.label_original_marcada_sub
	group by id_peca;
quit;

PROC SQL;
	drop table work.label_original_marcada_sub;
QUIT;