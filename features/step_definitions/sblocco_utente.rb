Given('dopo essermi autenticato come admin') do
    @admin = FactoryBot.create(:user_admin)
    @target = FactoryBot.create(:user_user)
    @target.locked_at = Time.now
    @target.save
    visit '/users/sign_in'
    fill_in 'email', with: @admin.email
    fill_in 'password', with: @admin.password
    click_button 'Accedi'
end

And('mi trovo nella pagina di gestione') do
    visit '/management'
end


When('clicco il bottone sblocca') do
    page.find('#'+@target.id.to_s+'Sblocca').click
end

Then('viene mostrato il messaggio dell\'avvenuto sblocco') do
    expect(page).to have_text("L\' account (\"#{@target.email}\") è stato sbloccato con successo!")
end

And('cerco di nuovo l\'utente sbloccato') do
    @target = User.find(2)
end

And('viene inviata la mail relativa all\'avvenuto sblocco all\'utente interessato') do
    email = ActionMailer::Base.deliveries.last
    expect([ email.from, email.to, email.subject ]).to eq [["spacebook.adm@gmail.com"], [@target.email], "Your account has been unlocked"]
end

And('viene mostrato un campo vuoto per il motivo del blocco') do
    expect(page).to have_no_text("#{@target.email} #{@target.role} Bloccato dall'amministratore")
end

And('per l\'utente appena sbloccato compare il bottone per bloccarlo') do
    expect(page.find('#'+@target.id.to_s+'Blocca')).to be_truthy
end