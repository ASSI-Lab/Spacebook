Given('mi sono autenticato RmFavSp') do
    @manager = FactoryBot.create(:user_manager)

    visit '/users/sign_in'
    fill_in 'Email', with: @manager.email
    fill_in 'Password', with: @manager.password
    click_button 'Accedi'
end

And ('è presente un dipartimento RmFavSp') do
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

And('vado alla pagina per effettuare una prenotazione RmFavSp') do
    visit '/make_reservation'
end

And('seleziono un dipartimento RmFavSp') do
    click_button 'Filtra dipartimento'
end

And('ho aggiunto uno spazio ai preferiti') do
    check("-1")
    click_button 'Conferma'
end

And('torno su effettua prenotazione RmFavSp') do
    visit '/make_reservation'
end

And('seleziono lo stesso dipartimento di prima RmFavSp') do
    click_button 'Filtra dipartimento'
end

When('seleziono la casella per rimuovere dai preferiti uno spazio') do
    @fav_sp = FavouriteSpace.find(1)
    check("-1")
end

And('confermo tramite l\'apposito bottone RmFavSp') do
    click_button 'Conferma'
end

And('apro la lista dei preferiti RmFavSp') do
    visit '/favourite_spaces'
end

Then('nella tabella non trovo i dati dello spazio appena rimosso') do
    expect(page).not_to have_text("#{@fav_sp.dep_name} #{@fav_sp.typology} #{@fav_sp.space_name}")
end