Feature: come admin voglio sbloccare l'accesso di un utente

Background:
    Given dopo essermi autenticato come admin
    And sono nella pagina di gestione
    And la tabella utenti è popolata
    And cerco l'utente che voglio sbloccare tramite mail
    And lo trovo

Scenario: lo sblocco di un utente precedentemente bloccato va a buon fine
    When clicco il bottone sblocca
    Then la pagina viene ricaricata dopo lo sblocco
    And viene mostrato il messaggio dell'avvenuto sblocco
    And viene inviata la mail relativa all'avvenuto sblocco all'utente interessato
    And cerco di nuovo l'utente sbloccato
    And ottengo di nuovo un risultato dopo sblocco
    And viene mostrato un campo vuoto per il motivo del blocco
    And per l'utente appena sbloccato compare il bottone per bloccarlo