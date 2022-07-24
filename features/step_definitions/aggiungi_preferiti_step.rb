Given('mi sono autenticato AddFavSp') do
    @manager = FactoryBot.create(:user_manager)

    visit '/users/sign_in'
    fill_in 'Email', with: @manager.email
    fill_in 'Password', with: @manager.password
    click_button 'Accedi'
end

And ('è presente un dipartimento AddFavSp') do
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

And('vado alla pagina per effettuare una prenotazione AddFavSp') do
    visit '/make_reservation'
end

And('seleziono un dipartimento AddFavSp') do
    click_button 'Filtra dipartimento'
end

When('seleziono la casella per aggiungere ai preferiti uno spazio') do
    @space = Space.find(1)
    check("-1")
end

And('confermo tramite l\'apposito bottone AddFavSp') do
    click_button 'Conferma'
end

And('apro la lista dei preferiti AddFavSp') do
    visit '/favourite_spaces'
end

Then('nella tabella trovo i dati dello spazio appena aggiunto') do
    expect(page).to have_text("#{@space.dep_name} #{@space.typology} #{@space.name}")
end