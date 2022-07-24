Given('mi sono autenticato MakeRes') do
    @manager = FactoryBot.create(:user_manager)

    visit '/users/sign_in'
    fill_in 'Email', with: @manager.email
    fill_in 'Password', with: @manager.password
    click_button 'Accedi'
end

And ('è presente un dipartimento MakeRes') do
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

And('vado alla pagina per effettuare una prenotazione MakeRes') do
    visit '/make_reservation'
end

When('seleziono un dipartimento MakeRes') do
    click_button 'Filtra dipartimento'
end

And('seleziono una casella di un posto da prenotare') do
    @seat = Seat.where(state: "Active").first
    @num_seat = @seat.position
    @space = Space.find(@seat.space_id)
    @department = Department.find(@space.department_id)
    check(@seat.id.to_s)
end

And('confermo tramite l\'apposito bottone MakeRes') do
    click_button 'Conferma'
end

Then('dovrei essere reindirizzato alla pagina di mie prenotazione') do
    expect(page).to have_current_path('/user_reservations')
end

And('nella tabella trovo i dati della prenotazione appena effettuata') do
    expect(page).to have_text("#{@department.name} #{@space.typology} #{@space.name} #{@space.floor} #{@num_seat} #{@seat.start_date.mday}-#{@seat.start_date.mon}-#{@seat.start_date.year} #{@seat.start_date.strftime('%H:%M')} - #{@seat.end_date.strftime('%H:%M')} Valida")
end