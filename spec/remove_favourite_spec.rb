require 'rails_helper'

describe 'removem favourite space process', type: :feature do

    context 'removing favourite space from make reservation' do

        before(:each) do
            @manager = FactoryBot.create(:user_manager)

            visit '/users/sign_in'
            fill_in 'Email', with: @manager.email
            fill_in 'Password', with: @manager.password
            click_button 'Accedi'

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

            visit '/make_reservation'
            click_button 'Filtra dipartimento'

            @space = Space.all.first
            check((@space.id*(-1)).to_s)
            click_button 'Conferma'

            visit '/make_reservation'
            click_button 'Filtra dipartimento'

            check("-1")
            click_button 'Conferma'
        end

        it "should not contain the just removed space" do
            expect(FavouriteSpace.where(user_id: @manager.id, space_id: 1).count).to eq(0)
        end

    end

end