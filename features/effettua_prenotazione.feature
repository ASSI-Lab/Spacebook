Feature: effettua una nuova prenotazione

Background:
    Given mi sono autenticato MakeRes
    And è presente un dipartimento MakeRes
    And vado alla pagina per effettuare una prenotazione MakeRes

Scenario: la prenotazione è stata effettuata correttamente
    When seleziono un dipartimento MakeRes
    And seleziono una casella di un posto da prenotare
    And confermo tramite l'apposito bottone MakeRes
    Then vado alla pagina delle mie prenotazione
    And nella tabella trovo i dati della prenotazione appena effettuata