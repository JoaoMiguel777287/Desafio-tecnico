*** Settings ***
Documentation    Essa suíte testa o site da Kabum.com.br
Resource     kabum_resources.robot
Suite Setup    Abrir o navegador 
Suite Teardown    Close Browser



*** Variables ***

*** Test Cases ***
Buscar E Adicionar Produto No Carrinho
    [Documentation]    Este caso de teste realiza a busca de um "notebook", valida o frete, e adiciona o produto ao carrinho com garantia estendida.
    [Tags]    BDD    FluxoCompra
    Log To Console    Iniciando o teste...
    Given O usuário acessa o site Kabum
    Log To Console    Acesso realizado ao site da Kabum
    When O usuário busca por "notebook"
    Log To Console    Busca realizada
    And O usuário seleciona o primeiro produto da lista
    Log To Console    Item selecionado
    And O usuário verifica os fretes disponíveis
    Log To Console    fretes verificados
    And O usuário fecha a tela de opções de frete
    Log To Console    Saiu da tela de fretes
    And O usuário clica em "Comprar"
    Log To Console    Selecionado botão comprar
    And O usuário seleciona a garantia de +12 meses
    Log To Console    Selecionado garantia 12 meses
    And O usuário clica em "Ir para o carrinho"
    Log To Console    Entrou em carrinho de compras
    Then O produto é adicionado corretamente ao carrinho
    Log To Console   Produto adicionado no carrinho


