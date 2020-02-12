proc sql;
	create table work.paginas_agrupadas as
	select id_peca
			,avg(P_subtema_amostraOUTROS) as acuracia_OUTROS
			,avg(P_subtema_amostraCONSELHO_DE_FIS) as acuracia_CONSELHO
			,avg(P_subtema_amostraCERTIFICA____O) as acuracia_CERTIFICACAO
			,avg(P_subtema_amostraEXIG__NCIA) as acuracia_EXIGENCIA
			,avg(P_subtema_amostraATESTADO_DE_CAP) as acuracia_ATESTADO
	from TCU_SSM3.score_score
	group by id_peca;
quit;

data work.score_subtema_processo_sub;
	set work.paginas_agrupadas;

	LABEL_OUTROS = 0;
	LABEL_CONSELHO = 0;
	LABEL_CERTIFICACAO  = 0;
	LABEL_EXIGENCIA  = 0;
	LABEL_ATESTADO  = 0;

	if acuracia_OUTROS ge 0.50 then LABEL_OUTROS = 1;
	if acuracia_CONSELHO ge 0.50 then LABEL_CONSELHO = 1;
	if acuracia_CERTIFICACAO ge 0.50 then LABEL_CERTIFICACAO = 1;
	if acuracia_EXIGENCIA ge 0.50 then LABEL_EXIGENCIA = 1;
	if acuracia_ATESTADO ge 0.50 then LABEL_ATESTADO = 1;
run;


proc sql;
	drop table work.paginas_agrupadas;
quit;