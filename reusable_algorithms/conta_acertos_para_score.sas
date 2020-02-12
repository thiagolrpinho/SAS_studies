data POC_TCU.TCU_VA_acertos_subtema;
	set work.label_classificadas;
	acertou_classificacao = 0;

	if label_classificacao eq label_original then acertou_classificacao = 1;
run;