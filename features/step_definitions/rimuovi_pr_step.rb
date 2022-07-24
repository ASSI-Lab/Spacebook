Given('mi sono autenticato RmQkRes') do
    @manager = FactoryBot.create(:user_manager)

    visit '/users/sign_in'
    fill_in 'Email', with: @manager.email
    fill_in 'Password', with: @manager.password
    click_button 'Accedi'
end

And ('è presente un dipartimento RmQkRes') do
    @temp_dep = FactoryBot.create(:temp_dep)

    @temp_week_day_lunedi = FactoryBot.create(:temp_week_day_lunedi)
    @temp_week_day_martedi = FactoryBot.create(:temp_week_day_martedi)
    @temp_week_day_mercoledi = FactoryBot.create(:temp_week_day_mercoledi)
    @temp_week_day_giovedi = FactoryBot.create(:temp_week_day_giovedi)
    @temp_week_day_venerdi = FactoryBot.create(:temp_week_day_venerdi)
    @temp_week_day_sabato = FactoryBot.create(:temp_week_day_sabato)
    @temp_week_day_domenica = FactoryBot.create(:temp_week_day_domenica)

    @temp_sp_1 = FactoryBot.create(:temp_sp_1)

    visit '/manager_department'
end

And('vado alla pagina per effettuare una prenotazione RmQkRes') do
    visit '/make_reservation'
end

And('seleziono un dipartimento RmQkRes') do
    click_button 'Filtra dipartimento'
end

And('ho impostato uno spazio come prenotazione rapida RmQkRes') do
    check("QR1")
    click_button 'Conferma'
end

And('torno su effettua prenotazione RmQkRes') do
    visit '/make_reservation'
end

And('seleziono lo stesso dipartimento di prima RmQkRes') do
    click_button 'Filtra dipartimento'
end

When('seleziono la casella per rimuovere uno spazio dalla prenotazione rapida') do
    check("QR1")
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