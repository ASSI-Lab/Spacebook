Given('dopo essermi autenticato come admin') do
    @utente = User.find(9)
    @target = User.find(1)
    @target.locked_at = Time.now
    @target.save
    visit '/users/sign_in'
    fill_in 'email', with: @utente.email
    fill_in 'password', with: 'password'
    click_button 'Accedi'
    expect(page).to have_text("Gestione sito")
end

And('mi trovo nella pagina di gestione') do
    visit '/management'
end

And('la tabella utenti è popolata') do
    expect(page).not_to have_text("Nessun utente")
end

And('cerco l\'utente che voglio sbloccare tramite mail') do
    @target = User.find(1)
end

And('lo trovo') do
    expect(page).to have_text("#{@target.email}")
end

When('clicco il bottone sblocca') do
    page.find('#'+@target.id.to_s+'Sblocca').click
end

Then('la pagina viene ricaricata dopo lo sblocco') do
    expect(page).to have_current_path('/management') 
end
  
Then('viene mostrato il messaggio dell\'avvenuto sblocco') do
    expect(page).to have_text("L\' account (\"#{@target.email}\") è stato sbloccato con successo!")
end
  
Then('viene inviata la mail relativa all\'avvenuto sblocco all\'utente interessato') do
    email = ActionMailer::Base.deliveries.last
    expect(email.from).to eq ["spacebook.adm@gmail.com"]
    expect(email.to).to eq [User.find(1).email]
    expect(email.subject).to eq "Your account has been unlocked"
end
  
Then('cerco di nuovo l\'utente sbloccato') do
    @target = User.find(1)
end

Then('ottengo di nuovo un risultato dopo sblocco') do
    expect(page).to have_text("#{@target.email}")
end

Then('viene mostrato un campo vuoto per il motivo del blocco') do
    expect(page).to have_no_text("#{@target.email} #{@target.role} Bloccato dall'amministratore")
end

Then('per l\'utente appena sbloccato compare il bottone per bloccarlo') do
    expect(page.find('#'+@target.id.to_s+'Blocca')).to be_truthy
end