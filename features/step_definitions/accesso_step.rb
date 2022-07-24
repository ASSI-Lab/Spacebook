Given('mi sono già registrato come utente') do
    @user = FactoryBot.create(:user_user)
end

And('mi trovo nella pagina di login') do
    visit '/users/sign_in'
end

When('inserisco email e password') do
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
end

And('clicco sul bottone accedi va a buon fine') do
    click_button 'Accedi'
end

Then('dovrei essere reindirizzato alla home') do
    expect(page).to have_current_path('/') 
    expect(page).to have_text('Accesso effettuato con successo.')
end


When('inserisco email e\/o password errata') do
    fill_in 'email', with: @user.email
    fill_in 'password', with: 'passwordErrata'
end

And('clicco sul bottone accedi non va a buon fine') do
    click_button 'Accedi'
end

Then('dovrei essere reindirizzato alla pagina di login') do
    expect(page).to have_current_path('/users/sign_in')
end

And('dovrei ricevere un messaggio di errore nel box') do
    expect(page).to have_text('Email o password non validi.')
end