Given('mi sono autenticato') do
    @utente = User.find(1)
    visit '/users/sign_in'
    fill_in 'email', with: 'fra.user@gmail.com'
    fill_in 'password', with: 'password'
    click_button 'Accedi'
end
  
And('sono nella pagina per effettuare una prenotazione') do
    visit '/make_reservation'
end
  
When('seleziono un dipartimento tra i dipartimenti dal menu a tendina') do
    @posto = Seat.find(743)
    @num_posto = @posto.position
    @spazio = Space.find(@posto.space_id)
    @dipartimento = Department.find(@spazio.department_id)
end

And('clicco il bottone per filtrare il dipartimento') do
    click_button 'Filtra dipartimento'
end

And('seleziono una casella di un posto dello spazio') do
    check(@posto.id)
end
  
And('confermo tramite l\'apposito bottone') do
    click_button 'Conferma'
end
  
Then('dovrei essere reindirizzato alla pagina di mie prenotazione') do
    expect(page).to have_current_path('/user_reservations') 
end

And('nella tabella trovo i dati della prenotazione appena effettuata') do
    expect(page).to have_text("#{@dipartimento.name} #{@spazio.typology} #{@spazio.name} #{@spazio.floor} #{@num_posto} #{@posto.start_date.mday}-#{@posto.start_date.mon}-#{@posto.start_date.year} #{@posto.start_date.strftime('%H:%M')} - #{@posto.end_date.strftime('%H:%M')} Valida")
end