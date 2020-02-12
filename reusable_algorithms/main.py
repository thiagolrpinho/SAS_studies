from importa_e_trata_txts import abre_documento, imprime_planilha
import re
''' Algorítmo usado para a main temporária de códigos reutilizáveis '''

lista_titulos_links = []
corpo_documento = abre_documento('links.txt')
linhas_documentos = re.findall(r'^([A-Z](?:\S{1,}|\s{1,2})+?)\n*(http(?:\S{1,}|\n)+)\n', corpo_documento, flags=re.MULTILINE)
linhas_documentos_lista = []
for tupla in linhas_documentos:
  linha = list(tupla)
  linhas_documentos_lista.append(linha)
print(linhas_documentos_lista)
imprime_planilha(linhas_documentos_lista, ['Referências', 'Links'])