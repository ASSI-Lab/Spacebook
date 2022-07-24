Feature: come admin voglio bloccare l'accesso di un utente

Background:
    Given mi sono autenticato come admin
    And sono nella pagina di gestione
    And la tabella utenti non è vuota
    And cerco l'utente che voglio gestire tramite mail
    And ottengo un risultato

Scenario: il blocco di un utente va a buon fine
    When clicco il bottone blocca
    Then la pagina viene ricaricata
    And viene mostrato il messaggio dell'avvenuto blocco
    And viene inviata la mail relativa all'avvenuto blocco all'utente interessato
    And cerco di nuovo l'utente
    And ottengo di nuovo un risultato
    And viene mostrato il motivo del blocco
    And per l'utente appena bloccato compare il bottone per sbloccarlo