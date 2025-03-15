*** Settings ***

Library    RequestsLibrary
Library    Collections
Library    BuiltIn
Library    json
Library    JSONLibrary
Library    SeleniumLibrary


*** Variables ***

${VIA_CEP_URL}    https://viacep.com.br/ws/
${CEP_VALIDO}     01001000     # CEP válido
${CEP_INVALIDO}   00000000     # CEP inexistente
${CEP_FORMATO_INCORRETO}     1234    # CEP menor que 8 dígitos
${CEP_LONGO}     123456789          # CEP maior que 8 dígitos
${CEP_CARACTERES_ESPECIAIS}     01A01-010  # CEP com letras e caracteres especiais
${dados}     

*** Keywords ***

Criar Relatório de Execução
    Log    Iniciando os testes da API ViaCEP...
    Set Log Level    TRACE
Preparar Variáveis
    Log    Preparando variáveis para os testes

Finalizar Teste
    Log    Teste concluído.

Consultar CEP
    [Arguments]    ${cep}
   ${response}=     GET     ${VIA_CEP_URL}${cep}/json/
    [Return]    ${response}
    

Consultar CEP invalido
    [Arguments]    ${cep}
   ${response}=   Run Keyword And Ignore Error    GET     ${VIA_CEP_URL}${cep}/json/
    [Return]    ${response}
    
Dado que eu tenho um CEP válido
    Set Test Variable    ${CEP_TESTADO}    ${CEP_VALIDO}

Dado que eu tenho um CEP inválido
    Set Test Variable    ${CEP_TESTADO}    ${CEP_INVALIDO}

Dado que eu tenho um CEP com formato incorreto
    Set Test Variable    ${CEP_TESTADO}    ${CEP_FORMATO_INCORRETO}

Dado que eu tenho um CEP maior que o padrão
    Set Test Variable    ${CEP_TESTADO}    ${CEP_LONGO}

Dado que eu tenho um CEP contendo caracteres especiais
    Set Test Variable    ${CEP_TESTADO}    ${CEP_CARACTERES_ESPECIAIS}

Quando eu faço uma requisição para a API do ViaCEP
    ${response}=    Consultar CEP    ${CEP_TESTADO}
    Set Test Variable    ${RESPONSE}    ${response}

Quando eu faço uma requisição para a API do ViaCEP com formato incorreto ou caracteres a menos    
    ${response}=    Consultar CEP invalido    ${CEP_TESTADO}
    Set Test Variable    ${RESPONSE}    ${response}

Então a resposta deve conter os dados corretos do CEP
    [Documentation]    Verifica se a resposta contém o CEP correto

    # Exibe o conteúdo da resposta para depuração
    Log    Response Status: ${RESPONSE.status_code}
    Log    Response Text: ${RESPONSE.text}

    # Verifica se a resposta da API é válida antes de tentar converter

    # Converte a resposta JSON para um dicionário
    ${dados}=    Convert To Dictionary    ${RESPONSE.json()}

 ${status_code}=    Get From Dictionary    ${RESPONSE}    status_code
    Should Be Equal As Numbers    ${status_code}    200    
    # Valida se a chave 'cep' está presente no JSON retornado
    ${keys}=    Get Dictionary Keys    ${dados}
    Should Contain    ${keys}    cep

    # Valida se o CEP retornado é o esperado
    Should Be Equal As Strings    ${dados['cep']}    ${CEP_VALIDO}

Então a resposta deve indicar erro
    [Documentation]    Verifica se a API retorna um erro ao consultar um CEP inválido
    ${dados}=    Convert To Dictionary    ${RESPONSE.json()}
    Should Be Equal As Strings     ${dados}    {'erro': 'true'}

Então a resposta deve indicar erro de formato
 # Exibe a resposta para depuração
    ${RES_BODDY}     Convert Json To String    ${response}
    Log    Response body: ${RES_BODDY}    INFO
    # O teste PASSA se a resposta for 400 (Bad Request)
   
    Should Contain    ${RES_BODDY}    400