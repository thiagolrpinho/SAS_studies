/* Código desenvolvido a fim de enumerar as páginas de documentos de acordo com seus ids. Resetando quando o ID mudar.
  Autor: Thiago Russo e Thiago Luis Rodrigues Pinho
  Data: 21/08/2019 
 */
DATA WORK.TESTE_contagem_paginas(drop=);
	SET WORK.SORTSORTED;
	by id_peticao;
	retain numero_pagina;
	if first.id_peticao then
		do;
			numero_pagina = 1;
		end;
	else
		do;
			numero_pagina = numero_pagina + 1;
		end;
RUN;