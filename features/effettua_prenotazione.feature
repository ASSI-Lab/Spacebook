
Feature: effettua una nuova prenotazione

Background:  
    Given mi sono autenticato
    And sono nella pagina per effettuare una prenotazione
    
Scenario: la selezione di un dipartimento va a buon fine
    When seleziono un dipartimento tra i dipartimenti dal menu a tendina
    And clicco il bottone per filtrare il dipartimento
    And seleziono una casella di un posto dello spazio
    And confermo tramite l'apposito bottone
    Then dovrei essere reindirizzato alla pagina di mie prenotazione
    And nella tabella trovo i dati della prenotazione appena effettuata