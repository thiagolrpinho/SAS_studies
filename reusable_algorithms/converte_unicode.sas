/*
Código criado para limpar caracteres especiais, acentos e outros símbolos não presentes em unicode. 
Criado por: Thiago Luis Rodrigues Pinho e Thiago Guimarães Barros 
Data: 20/08/2019
*/

DATA WORK.TODOS_LABELS_POR_ID_UNICODE(drop=assunto);
	do until (last.id_peticao);
        set WORK.IDENTIFICA_PETICOES_DISTINTAS;
		assunto_tratado = TRANWRD(assunto,"É","E");
		assunto_tratado = TRANWRD(assunto_tratado,"Ê","E");
		assunto_tratado = TRANWRD(assunto_tratado,"Ç","C");
		assunto_tratado = TRANWRD(assunto_tratado,"Ã","A");
		assunto_tratado = TRANWRD(assunto_tratado,"Á","A");
		assunto_tratado = TRANWRD(assunto_tratado,"Ô","O");

		output;
    end;
   run;