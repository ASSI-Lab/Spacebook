require 'rails_helper'

describe 'add favourite space process', type: :feature do

    context 'add favourite space' do

        before(:each) do
            @user = User.find(1)

            visit '/users/sign_in'
            fill_in 'email', with: @user.email
            fill_in 'password', with: 'password'
            click_button 'Accedi'

            visit '/make_reservation'
            click_button 'Filtra dipartimento'

            check("-15")
            click_button 'Conferma'
        end

        it "should contain the selected space" do
            expect(FavouriteSpace.where(user_id: @user.id, space_id: 15).count).to eq(1)
        end

    end

end