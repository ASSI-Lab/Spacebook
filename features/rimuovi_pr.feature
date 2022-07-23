Feature: rimuovi prenotazione rapida

Background:
    Given mi sono autenticato RmQkRes
    And vado alla pagina per effettuare una prenotazione RmQkRes
    And seleziono un dipartimento RmQkRes
    And ho impostato uno spazio come prenotazione rapida RmQkRes
    And torno su effettua prenotazione RmQkRes
    And seleziono lo stesso dipartimento di prima RmQkRes

Scenario: la rimozione dello spazio della prenotazione rapida è andata a buon fine
    When seleziono la casella per rimuovere uno spazio dalla prenotazione rapida
    And confermo tramite l'apposito bottone RmQkRes
    And vado alla home RmQkRes
    Then nella card della prenotazione rapida trovo non impostata