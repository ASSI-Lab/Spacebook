Given('mi sono autenticato AddFavSp') do
    @utente = User.find(1)
    visit '/users/sign_in'
    fill_in 'email', with: 'fra.user@gmail.com'
    fill_in 'password', with: 'password'
    click_button 'Accedi'
end

And('vado alla pagina per effettuare una prenotazione AddFavSp') do
    visit '/make_reservation'
end

And('seleziono un dipartimento AddFavSp') do
    @spazio = Space.find(15)
    click_button 'Filtra dipartimento'
end

When('seleziono la casella per aggiungere ai preferiti uno spazio') do
    check("-15")
end

And('confermo tramite l\'apposito bottone AddFavSp') do
    click_button 'Conferma'
end

And('apro la lista dei preferiti AddFavSp') do
    visit '/favourite_spaces'
end

Then('nella tabella trovo i dati dello spazio appena aggiunto') do
    expect(page).to have_text("#{@spazio.dep_name} #{@spazio.typology} #{@spazio.name}")
end