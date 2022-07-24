require 'rails_helper'

describe 'sign_in process', type: :feature do
    it 'signs in test' do
        @user = FactoryBot.create(:user_user)
        @sign_in_count = @user.sign_in_count

        visit '/users/sign_in'
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: 'password'
        click_button 'Accedi'
        @temp_dep = FactoryBot.create(:temp_dep)
        puts(@temp_dep.name)
        @temp_sp= FactoryBot.create(:temp_sp_1)
        puts(@temp_sp.description)
        @temp_week_day_lun = FactoryBot.create(:temp_week_day_lunedi)
        puts(@temp_week_day_lun.day)
        puts(TempWeekDay.where(temp_dep_id: @temp_dep.id).first.day)

        expect(User.where(email: @user.email ).first.sign_in_count).to eq(@sign_in_count + 1)
    end
end