proc sql;
	create table work.paginas_agrupadas as
	select id_peca
			,avg(P_subtema_amostraOUTROS) as acuracia_OUTROS
			,avg(P_subtema_amostraCONSELHO_DE_FIS) as acuracia_CONSELHO_DE_FIS
			,avg(P_subtema_amostraCERTIFICA____O) as acuracia_CERTIFICA____O
			,avg(P_subtema_amostraEXIG__NCIA) as acuracia_EXIG__NCIA
			,avg(P_subtema_amostraATESTADO_DE_CAP) as acuracia_ATESTADO_DE_CAP
	from TCU_SSM3.score_score
	group by id_peca;
quit;

data work.score_area_processo_sub;
	set work.paginas_agrupadas;

	classificacao_outros = 0;
	classificacao_conselho = 0;
	classificacao_certificacao  = 0;
	classificacao_exigencia  = 0;
	classificacao_atestado_de_cap  = 0;

	if acuracia_outros ge 0.20 then classificacao_outros = 1;
	if acuracia_CONSELHO_DE_FIS ge 0.20 then classificacao_conselho = 1;
	if acuracia_CERTIFICA____O ge 0.20 then classificacao_certificacao = 1;
	if acuracia_EXIG__NCIA ge 0.20 then classificacao_exigencia = 1;
	if acuracia_ATESTADO_DE_CAP ge 0.20 then classificacao_atestado_de_cap = 1;
run;


proc sql;
	drop table work.paginas_agrupadas;
quit;