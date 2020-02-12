/* Programa escrito com o intuito de separar dados repetidos de dados separados 
usando uma coluna como comparação.
Nesse caso em específico o objetivo é separar os sócios de empresas que estão com
o cpf ou o cnpj, que deveria ser um identificador único, repetidos.
A fim de não atrapalhar o fluxo do trabalho enquanto o desenvolvemos, separarei em 
duas tabelas assim podemos tratar os dados duplicados de forma que eles possam reuni-
dos no futuro com os não repetidos enquanto outra frente pode desenvolver o fluxo
sem atrasar a outra demanda.
Criador por: Thiago Luis 
Data da última edição: 14/10/2019
*/

data WORK.socio_unico WORK.socio_duplicado;
/* Dados de entrada já tratado para ter somente as colunas desejadas */
  set WORK.socio_tratado;
  /* Agrupamos as linhas por cpf_cnpj */
  by cpf_cnpj;     
  
  /* Agora, se a primeira instância com um dado cpf_cnpj for a mesma linha que a última
  então esse cpf/cnpj é único. 
  */
  if first.cpf_cnpj and last.cpf_cnpj
    then output WORK.socio_unico;     
  else output WORK.socio_duplicado;
run;