Feature: rimuovi lo spazio selezionato dai preferiti

Background:
    Given mi sono autenticato RmFavSp
    And vado alla pagina per effettuare una prenotazione RmFavSp
    And seleziono un dipartimento RmFavSp
    And ho aggiunto uno spazio ai preferiti
    And torno su effettua prenotazione RmFavSp
    And seleziono lo stesso dipartimento di prima RmFavSp

Scenario: la rimozione dello spazio dai preferiti è andata a buon fine
    When seleziono la casella per rimuovere dai preferiti uno spazio
    And confermo tramite l'apposito bottone RmFavSp
    And apro la lista dei preferiti RmFavSp
    Then nella tabella non trovo i dati dello spazio appena rimosso