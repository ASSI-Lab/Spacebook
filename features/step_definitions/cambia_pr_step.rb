Given('mi sono autenticato UpdateQkRes') do
    @utente = User.find(1)
    visit '/users/sign_in'
    fill_in 'email', with: 'fra.user@gmail.com'
    fill_in 'password', with: 'password'
    click_button 'Accedi'
end

And('vado alla pagina per effettuare una prenotazione UpdateQkRes') do
    visit '/make_reservation'
end

And('seleziono un dipartimento UpdateQkRes') do
    click_button 'Filtra dipartimento'
end

And('ho impostato uno spazio come prenotazione rapida UpdateQkRes') do
    check("QR15")
    click_button 'Conferma'
end

And('torno su effettua prenotazione UpdateQkRes') do
    visit '/make_reservation'
end

And('seleziono lo stesso dipartimento di prima UpdateQkRes') do
    @spazio = Space.find(16)
    click_button 'Filtra dipartimento'
end

When('seleziono la casella per sostituire la prenotazione rapida con lo spazio selezionato') do
    check("QR16")
end

And('confermo tramite l\'apposito bottone UpdateQkRes') do
    click_button 'Conferma'
end

And('vado alla home UpdateQkRes') do
    visit '/home'
end

Then('nella card della prenotazione rapida trovo i dati dello spazio appena selezionato') do
    expect(page).to have_text("Dipartimento:\n#{@spazio.dep_name}\nTipologia - Spazio:\n#{@spazio.typology} - #{@spazio.name}")
end