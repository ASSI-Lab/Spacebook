Given('mi sono autenticato come admin') do
    @utente = User.find(9)
    visit '/users/sign_in'
    fill_in 'email', with: @utente.email
    fill_in 'password', with: 'password'
    click_button 'Accedi'
    expect(page).to have_text("Gestione sito")
end

And('sono nella pagina di gestione') do
    visit '/management'
end

And('la tabella utenti non è vuota') do
    expect(page).not_to have_text("Nessun utente")
end

And('cerco l\'utente che voglio gestire tramite mail') do
    @target = User.find(1)
end

And('ottengo un risultato') do
    expect(page).to have_text("#{@target.email}")
end

When('clicco il bottone blocca') do
    page.find('#'+@target.id.to_s+'Blocca').click
end

Then('la pagina viene ricaricata') do
    expect(page).to have_current_path('/management') 
end

And('viene mostrato il messaggio dell\'avvenuto blocco') do
    expect(page).to have_text("L\' account (\"#{@target.email}\") è stato bloccato con successo!")
end

And('viene inviata la mail relativa all\'avvenuto blocco all\'utente interessato') do
    email = ActionMailer::Base.deliveries.first
    expect(email.from).to eq ["spacebook.adm@gmail.com"]
    expect(email.to).to eq [User.find(1).email]
    expect(email.subject).to eq "Your account has been blocked"
end

And('cerco di nuovo l\'utente') do
    @target = User.find(1)
end

And('ottengo di nuovo un risultato') do
    expect(page).to have_text("#{@target.email}")
end

And('viene mostrato il motivo del blocco') do
    expect(page).to have_text("Bloccato dall'amministratore")
end

And('per l\'utente appena bloccato compare il bottone per sbloccarlo') do
    expect(page.find('#'+@target.id.to_s+'Sblocca')).to be_truthy
end