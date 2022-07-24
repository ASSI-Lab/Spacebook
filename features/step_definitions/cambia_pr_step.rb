Given('mi sono autenticato UpdateQkRes') do
    @manager = FactoryBot.create(:user_manager)

    visit '/users/sign_in'
    fill_in 'Email', with: @manager.email
    fill_in 'Password', with: @manager.password
    click_button 'Accedi'
end

And ('è presente un dipartimento UpdateQkRes') do
    @temp_dep = FactoryBot.create(:temp_dep)

    @temp_week_day_lunedi = FactoryBot.create(:temp_week_day_lunedi)
    @temp_week_day_martedi = FactoryBot.create(:temp_week_day_martedi)
    @temp_week_day_mercoledi = FactoryBot.create(:temp_week_day_mercoledi)
    @temp_week_day_giovedi = FactoryBot.create(:temp_week_day_giovedi)
    @temp_week_day_venerdi = FactoryBot.create(:temp_week_day_venerdi)
    @temp_week_day_sabato = FactoryBot.create(:temp_week_day_sabato)
    @temp_week_day_domenica = FactoryBot.create(:temp_week_day_domenica)

    @temp_sp_1 = FactoryBot.create(:temp_sp_1)
    @temp_sp_2 = FactoryBot.create(:temp_sp_2)

    visit '/manager_department'
end

And('vado alla pagina per effettuare una prenotazione UpdateQkRes') do
    visit '/make_reservation'
end

And('seleziono un dipartimento UpdateQkRes') do
    click_button 'Filtra dipartimento'
end

And('ho impostato uno spazio come prenotazione rapida UpdateQkRes') do
    check("QR1")
    click_button 'Conferma'
end

And('torno su effettua prenotazione UpdateQkRes') do
    visit '/make_reservation'
end

And('seleziono lo stesso dipartimento di prima UpdateQkRes') do
    click_button 'Filtra dipartimento'
end

When('seleziono la casella per sostituire la prenotazione rapida con lo spazio selezionato') do
    @seat = Space.find(2)
    check("QR2")
end

And('confermo tramite l\'apposito bottone UpdateQkRes') do
    click_button 'Conferma'
end

And('vado alla home UpdateQkRes') do
    visit '/home'
end

Then('nella card della prenotazione rapida trovo i dati dello spazio appena selezionato') do
    expect(page).to have_text("Dipartimento:\n#{@seat.dep_name}\nTipologia - Spazio:\n#{@seat.typology} - #{@seat.name}")
end