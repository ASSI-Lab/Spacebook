require 'rails_helper'

describe 'sign in process', type: :feature do

    context 'signs in test' do

        before(:each) do
            @user = FactoryBot.create(:user_user)

            visit '/users/sign_in'
            fill_in 'Email', with: @user.email
            fill_in 'Password', with: @user.password
            click_button 'Accedi'
        end

        it "should have his sign_in_count = 1" do
            expect(User.find(@user.id).sign_in_count).to eq(1)
        end
    end

end