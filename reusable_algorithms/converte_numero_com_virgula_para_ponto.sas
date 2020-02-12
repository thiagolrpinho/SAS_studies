/* Código deenvolvido a fim de converter os campos numéricos em strings. 
	Autores: Thiago Luis Rodrigues Pinho e Lucas da Silva Moutinho
	Data: 21/08/2019
*/

PROC SQL;
   CREATE TABLE PGESS_O.PGESS_VA_SCORE_DISTINCT AS 
   SELECT t1.id_peticao, 
          t1.assunto, 
          t1.EM_CLASSIFICATION, 
          t1.EM_PROBABILITY, 
           (TRANWRD(put(t1.P_assuntoRADIOTERAPIA,  BEST12.),'.',',')) LABEL="Probabilidade de ser Radioterapia" AS probabilidade_radioterapia, 
           (TRANWRD(put(t1.P_assuntoQUIMIOTERAPIA,  BEST12.),'.',',')) LABEL="Probabilidade de ser Quimioterapia" AS probabilidade_quimioterapia, 
           (TRANWRD(put(t1.P_assuntoTFD,  BEST12.),'.',',')) LABEL="Probabilidade de ser TFD" AS probabilidade_tfd, 
           (TRANWRD(put(t1.P_assuntoOXIG__HIPERBARICA,  BEST12.),'.',',')) LABEL="Probabilidade de ser Hiperbarica" AS probabilidade_hiperbarica, 
           (TRANWRD(put(t1.P_assuntoOUTROS, BEST12.),'.',',')) LABEL="Probabilidade de ser Outros" AS probabilidade_outros,
          (TRANWRD(put(t1.P_assuntoTHERASUIT, BEST12.),'.',',')) LABEL="Probabilidade de ser Therasuit" AS probabilidade_therasuit, 
          t1.label_frequency, 
          (TRANWRD(put(t1.avg_probability, BEST12.),'.',',')) LABEL="Probabilidade Média" AS probababilidade_media
      FROM WORK.CLASSIFICACAO_AGRUPADA_6_LABELS t1;
QUIT;

