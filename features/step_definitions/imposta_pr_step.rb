Given('mi sono autenticato SetQkRes') do
    @utente = User.find(1)
    visit '/users/sign_in'
    fill_in 'email', with: 'fra.user@gmail.com'
    fill_in 'password', with: 'password'
    click_button 'Accedi'
end

And('vado alla pagina per effettuare una prenotazione SetQkRes') do
    visit '/make_reservation'
end

And('seleziono un dipartimento SetQkRes') do
    @spazio = Space.find(15)
    click_button 'Filtra dipartimento'
end

When('seleziono la casella per impostare uno spazio come prenotazione rapida') do
    check("QR15")
end

And('confermo tramite l\'apposito bottone SetQkRes') do
    click_button 'Conferma'
end

And('vado alla home SetQkRes') do
    visit '/home'
end

Then('nella card della prenotazione rapida trovo i dati dello spazio appena impostato') do
    expect(page).to have_text("Dipartimento:\n#{@spazio.dep_name}\nTipologia - Spazio:\n#{@spazio.typology} - #{@spazio.name}")
end