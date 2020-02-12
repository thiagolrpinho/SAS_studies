proc sql;
	create table work.paginas_agrupadas as
	select id_peca
			,avg(P_area_amostraOUTROS) as acuracia_OUTROS
			,avg(P_area_amostraRESPONSABILIDADE) as acuracia_RESPONSABILIDADE
			,avg(P_area_amostraCONTRATO_ADMINISTR) as acuracia_CONTRATO_ADMINISTR
			,avg(P_area_amostraCOMPET__NCIA_DO_TC) as acuracia_COMPET__NCIA_DO_TC
			,avg(P_area_amostraDIREITO_PROCESSUAL) as acuracia_DIREITO_PROCESSUAL
			,avg(P_area_amostraLICITA____O) as acuracia_LICITA____O
	from TCU_SSM1.score_score
	group by id_peca;
quit;

data work.score_area_processo;
	set work.paginas_agrupadas;

	classificacao_outros = 0;
	classificacao_responsabilidade  = 0;
	classificacao_contrato  = 0;
	classificacao_competencia  = 0;
	classificacao_direito  = 0;
	classificacao_licitacao  = 0;

	if acuracia_outros ge 0.33 then classificacao_outros = 1;
	if acuracia_responsabilidade ge 0.33 then classificacao_responsabilidade = 1;
	if acuracia_contrato_administr ge 0.33 then classificacao_contrato = 1;
	if acuracia_compet__ncia_do_tc ge 0.33 then classificacao_competencia = 1;
	if acuracia_direito_processual ge 0.33 then classificacao_direito = 1;
	if acuracia_licita____o ge 0.33 then classificacao_licitacao = 1;
run;


proc sql;
	drop table work.paginas_agrupadas;
quit;