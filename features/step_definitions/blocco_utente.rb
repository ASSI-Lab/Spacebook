Given('mi sono autenticato come admin') do
    @admin = FactoryBot.create(:user_admin)
    @target = FactoryBot.create(:user_user)
    visit '/users/sign_in'
    fill_in 'email', with: @admin.email
    fill_in 'password', with: @admin.password
    click_button 'Accedi'
end

And('vado nella pagina di gestione') do
    visit '/management'
end


When('clicco il bottone blocca') do
    page.find('#'+@target.id.to_s+'Blocca').click
end

Then('viene mostrato il messaggio dell\'avvenuto blocco') do
    expect(page).to have_text("L\' account (\"#{@target.email}\") è stato bloccato con successo!")
end

And('cerco di nuovo l\'utente') do
    @target = User.find(2)
end

And('viene inviata la mail relativa all\'avvenuto blocco all\'utente interessato') do
    email = ActionMailer::Base.deliveries.first
    expect([ email.from, email.to, email.subject]).to eq [ ["spacebook.adm@gmail.com"], [@target.email], "Your account has been blocked" ]
end

And('viene mostrato il motivo del blocco') do
    expect(page).to have_text("#{@target.email} #{@target.role} Bloccato dall'amministratore")
end

And('per l\'utente appena bloccato compare il bottone per sbloccarlo') do
    expect(page.find('#'+@target.id.to_s+'Sblocca')).to be_truthy
end