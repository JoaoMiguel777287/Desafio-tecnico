*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    BuiltIn
Library    json
Resource   api_viaCep_resources.robot

Suite Setup    Criar Relatório de Execução
Suite Teardown    Finalizar Teste
Test Setup    Preparar Variáveis


*** Variables ***


*** Test Cases ***     Set log level     TRACE
Cenário: Consultar CEP válido
    Dado que eu tenho um CEP válido
    Quando eu faço uma requisição para a API do ViaCEP
    Então a resposta deve conter os dados corretos do CEP

Cenário: Consultar CEP inválido
    Dado que eu tenho um CEP inválido
    Quando eu faço uma requisição para a API do ViaCEP
    Então a resposta deve indicar erro

Cenário: Consultar CEP com formato incorreto (menos de 8 dígitos)
    Dado que eu tenho um CEP com formato incorreto
    Quando eu faço uma requisição para a API do ViaCEP com formato incorreto ou caracteres a menos
    Então a resposta deve indicar erro de formato

Cenário: Consultar CEP com mais de 8 dígitos
    Dado que eu tenho um CEP maior que o padrão
    Quando eu faço uma requisição para a API do ViaCEP com formato incorreto ou caracteres a menos
    Então a resposta deve indicar erro de formato

Cenário: Consultar CEP com caracteres especiais
    Dado que eu tenho um CEP contendo caracteres especiais
    Quando eu faço uma requisição para a API do ViaCEP com formato incorreto ou caracteres a menos
    Então a resposta deve indicar erro de formato
