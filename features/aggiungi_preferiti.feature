Feature: aggiungi lo spazio selezionato ai preferiti

Background:
    Given mi sono autenticato AddFavSp
    And vado alla pagina per effettuare una prenotazione AddFavSp
    And seleziono un dipartimento AddFavSp

Scenario: l'aggiunta dello spazio ai preferiti è andata a buon fine
    When seleziono la casella per aggiungere ai preferiti uno spazio
    And confermo tramite l'apposito bottone AddFavSp
    And apro la lista dei preferiti AddFavSp
    Then nella tabella trovo i dati dello spazio appena aggiunto