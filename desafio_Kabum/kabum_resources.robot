*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.kabum.com.br
${CEP}    01010-010  # Substitua pelo CEP desejado



*** Keywords ***
 
Abrir o navegador
    [Documentation]    Abre o site Kabum.
    Open Browser    ${URL}    chrome
    Maximize Browser Window  
    Set Log Level    TRACE
    

O usuário acessa o site Kabum
    [Documentation]    Verifica que a página principal foi carregada.
    Title Should Be    KaBuM! | Aperte o K e evolua com as maiores ofertas em Tech e Gamer!  #Valida se o acesso ao site da kabum foi realizado com sucesso pelo title da pagina.

O usuário busca por "notebook"
    [Documentation]    Realiza a busca pelo termo "notebook".
    Input Text    id=input-busca    notebook  #Insere o termo notebook no campo de pesquisa.
    Press Keys    id=input-busca    RETURN     #Simula o botão Enter no campo de pesquisa.
    Sleep         3s                           

O usuário seleciona o primeiro produto da lista
    Click Button    xpath=//*[@id="onetrust-accept-btn-handler"]     #Remove da tela a mensagem de consentimento de cookies
    Execute JavaScript    window.scrollBy(0, 500);    #Utilizado para que o elemento fique visível para o click.
    Wait Until Element Is Visible    xpath=//div[@id='listing']//article[1]    5s     
    Click Element    xpath=//div[@id='listing']//article[1]                           #Aqui utilizo xpath //div[@id='listing']//article[1] para garantir que o primeiro item da lista seja selecionado.
    Sleep    3s

O usuário verifica os fretes disponíveis
    [Documentation]    Digita o CEP e verifica os valores dos fretes disponíveis.
    Input Text    id=inputCalcularFrete    ${CEP}
    Execute JavaScript    window.scrollBy(0, 300);    #Utilizado para que o elemento fique visível para o click.
    Click Element    xpath=//button[contains(.,'OK')]  #Clique para calcular o frete
    Wait Until Element Is Visible    xpath=//h2[contains(.,'Frete e Prazo')]    #Verifica se a tela de frete foi carregada.

O usuário fecha a tela de opções de frete
    [Documentation]    Fecha a tela de opções de frete.
    Press Keys    NONE    ESC      #Utilizado para simular o tecla ESC

O usuário clica em "Comprar"
    [Documentation]    Clica no botão de comprar.
    Click Element    xpath=//button[@class='sc-8b813326-0 bLjOez'][contains(.,'COMPRAR')]
    Sleep         3s

O usuário seleciona a garantia de +12 meses
    [Documentation]    Seleciona a opção de garantia estendida de +12 meses.
    Click Element    xpath=//span[@class='text-xs font-semibold text-black-800'][contains(.,'12 Meses de garantia')]
O usuário clica em "Ir para o carrinho"
    [Documentation]    Clica no botão de "Ir para o carrinho".
    Click Element    xpath=//span[contains(.,'Adicionar serviços')]
    Sleep         3s

O produto é adicionado corretamente ao carrinho
    [Documentation]    Valida que o produto foi adicionado ao carrinho.
    Page Should Contain    Carrinho de Compras - KaBuM!    #Valida que estamos no fluxo do carrinho que garante que o produto foi adicionado.
