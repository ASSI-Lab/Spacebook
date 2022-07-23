Given('mi sono autenticato RmQkRes') do
    @utente = User.find(1)
    visit '/users/sign_in'
    fill_in 'email', with: 'fra.user@gmail.com'
    fill_in 'password', with: 'password'
    click_button 'Accedi'
end

And('vado alla pagina per effettuare una prenotazione RmQkRes') do
    visit '/make_reservation'
end

And('seleziono un dipartimento RmQkRes') do
    click_button 'Filtra dipartimento'
end

And('ho impostato uno spazio come prenotazione rapida RmQkRes') do
    check("QR15")
    click_button 'Conferma'
end

And('torno su effettua prenotazione RmQkRes') do
    visit '/make_reservation'
end

And('seleziono lo stesso dipartimento di prima RmQkRes') do
    click_button 'Filtra dipartimento'
end

When('seleziono la casella per rimuovere uno spazio dalla prenotazione rapida') do
    check("QR15")
end

And('confermo tramite l\'apposito bottone RmQkRes') do
    click_button 'Conferma'
end

And('vado alla home RmQkRes') do
    visit '/home'
end

Then('nella card della prenotazione rapida trovo non impostata') do
    expect(page).to have_text("Non impostata")
end