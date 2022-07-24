Feature: imposta prenotazione rapida

Background:
    Given mi sono autenticato SetQkRes
    And è presente un dipartimento SetQkRes
    And vado alla pagina per effettuare una prenotazione SetQkRes
    And seleziono un dipartimento SetQkRes

Scenario: l'impostazione della prenotazione rapida è andata a buon fine
    When seleziono la casella per impostare uno spazio come prenotazione rapida
    And confermo tramite l'apposito bottone SetQkRes
    And vado alla home SetQkRes
    Then nella card della prenotazione rapida trovo i dati dello spazio appena impostato