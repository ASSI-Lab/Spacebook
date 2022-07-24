Feature: accesso locale come utente

Background:
    Given mi sono già registrato come utente
    And mi trovo nella pagina di login

Scenario: l'accesso va a buon fine
    When inserisco email e password
    And clicco sul bottone accedi va a buon fine
    Then dovrei essere reindirizzato alla home

Scenario: l'accesso non va a buon fine
    When inserisco email e/o password errata
    And clicco sul bottone accedi non va a buon fine
    Then dovrei essere reindirizzato alla pagina di login
    And dovrei ricevere un messaggio di errore nel box