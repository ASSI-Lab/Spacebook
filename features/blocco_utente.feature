Feature: come admin voglio bloccare l'accesso di un utente

Background:
    Given mi sono autenticato come admin
    And vado nella pagina di gestione

Scenario: il blocco di un utente va a buon fine
    When clicco il bottone blocca
    Then viene mostrato il messaggio dell'avvenuto blocco
    And cerco di nuovo l'utente
    And viene inviata la mail relativa all'avvenuto blocco all'utente interessato
    And viene mostrato il motivo del blocco
    And per l'utente appena bloccato compare il bottone per sbloccarlo