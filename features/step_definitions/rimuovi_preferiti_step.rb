Given('mi sono autenticato RmFavSp') do
    @utente = User.find(1)
    visit '/users/sign_in'
    fill_in 'email', with: 'fra.user@gmail.com'
    fill_in 'password', with: 'password'
    click_button 'Accedi'
end

And('vado alla pagina per effettuare una prenotazione RmFavSp') do
    visit '/make_reservation'
end

And('seleziono un dipartimento RmFavSp') do
    click_button 'Filtra dipartimento'
end

And('ho aggiunto uno spazio ai preferiti') do
    check("-15")
    click_button 'Conferma'
end

And('torno su effettua prenotazione RmFavSp') do
    visit '/make_reservation'
end

And('seleziono lo stesso dipartimento di prima RmFavSp') do
    @spazio_preferito = FavouriteSpace.find(1)
    click_button 'Filtra dipartimento'
end

When('seleziono la casella per rimuovere dai preferiti uno spazio') do
    check("-1")
end

And('confermo tramite l\'apposito bottone RmFavSp') do
    click_button 'Conferma'
end

And('apro la lista dei preferiti RmFavSp') do
    visit '/favourite_spaces'
end

Then('nella tabella non trovo i dati dello spazio appena rimosso') do
    expect(page).not_to have_text("#{@spazio_preferito.dep_name} #{@spazio_preferito.typology} #{@spazio_preferito.space_name}")
end