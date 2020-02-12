'''Módulo responsável por importar textos em formato .txts e exportá-los em outros formatos'''

import os.path
import re
import pandas as pd
from pandas import DataFrame

DIRETORIO_DOS_ARQUIVOS_PADRÃO = 'base_dados/'
NOME_ARQUIVO_PLANILHA_PADRÃO = 'referencia_russo.xlsx'

def abre_documento(nome_documento, nome_pasta = DIRETORIO_DOS_ARQUIVOS_PADRÃO):
  ''' Função que abre documentos txts em uma pasta específica e retorna uma única string
  com todo o corpo do documento'''

  # previne que o método interprete uma pastas como um documento válido
  if not os.path.isfile(nome_pasta + nome_documento):
    return []

  with open(nome_pasta + nome_documento, mode="r", encoding="utf8") as text_file:
      conteudo_completo_texto = text_file.read()
  
  return conteudo_completo_texto

def imprime_planilha(texto, colunas, nome_documento = NOME_ARQUIVO_PLANILHA_PADRÃO):
  ''' Função recebe uma lista de linhas e  uma lista com os nomes das colunas 
  e imprime uma planilha em formato .xlsx'''
  df_documentos = pd.DataFrame(texto, columns=colunas)
  df_documentos.to_excel(nome_documento)

