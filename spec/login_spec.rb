require 'rails_helper'

describe 'sign_in process', type: :feature do
    it 'signs in test' do
        @user = User.find(1)
        @sign_in_count = @user.sign_in_count

        visit '/users/sign_in'
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: 'password'
        click_button 'Accedi'

        expect(User.find(1).sign_in_count).to eq(@sign_in_count + 1)
    end
end