libname POC_TCU "/SASData/POC/TCU/TABELAS_ENTRADA" compress=yes;
/* Concatena os registros de um mesmo processo e folha em uma peca
  Autor: Thiago Russo 
  Editor: Thiago Luis Rodrigues Pinho
  Última edição feita em: 05/08/2019
 */

%let TAMPAGINA = 29000; /* Validammos que a maior peça não ultrapassa 29000 bytes*/
data POC_TCU.PECAS_PAGINAS (compress=yes drop= texto_peca);
 /* Concatena os registros de um mesmo processo e folha em uma peca */
    length pagina $&TAMPAGINA..;
    do until (last.id_peca);
        set WORK.PECAS_IMPORTADAS_LINHAS;
    by id_peca notsorted;
        pagina = catx(' ', pagina, upcase(COMPBL(texto_peca)));
		if FIND(texto_peca, '0C'x) ne 0 then
		 do;
			output;
			pagina = '';
		 end;

    end; 
run;

data POC_TCU.miner_poc_tcu_score (compress=yes drop= texto_peca);
 /* Concatena os registros de um mesmo processo e folha em uma peca */
    length pagina $&TAMPAGINA..;
    do until (last.id_peca);
        set WORK.PECAS_COM_LABELS(drop= area);
    by id_peca notsorted;
        pagina = catx(' ', pagina, upcase(COMPBL(texto_peca)));
		if FIND(texto_peca, '0C'x) ne 0 then
		 do;
			output;
			pagina = '';
		 end;

    end; 
run;



