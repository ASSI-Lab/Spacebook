Feature: come admin voglio sbloccare l'accesso di un utente

Background:
    Given dopo essermi autenticato come admin
    And mi trovo nella pagina di gestione

Scenario: lo sblocco di un utente precedentemente bloccato va a buon fine
    When clicco il bottone sblocca
    Then viene mostrato il messaggio dell'avvenuto sblocco
    And cerco di nuovo l'utente sbloccato
    And viene inviata la mail relativa all'avvenuto sblocco all'utente interessato
    And viene mostrato un campo vuoto per il motivo del blocco
    And per l'utente appena sbloccato compare il bottone per bloccarlo