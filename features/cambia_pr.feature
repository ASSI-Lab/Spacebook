Feature: sostituisci lo spazio della prenotazione rapida

Background:
    Given mi sono autenticato UpdateQkRes
    And vado alla pagina per effettuare una prenotazione UpdateQkRes
    And seleziono un dipartimento UpdateQkRes
    And ho impostato uno spazio come prenotazione rapida UpdateQkRes
    And torno su effettua prenotazione UpdateQkRes
    And seleziono lo stesso dipartimento di prima UpdateQkRes

Scenario: la sostituzione dello spazio della prenotazione rapida è andata a buon fine
    When seleziono la casella per sostituire la prenotazione rapida con lo spazio selezionato
    And confermo tramite l'apposito bottone UpdateQkRes
    And vado alla home UpdateQkRes
    Then nella card della prenotazione rapida trovo i dati dello spazio appena selezionato