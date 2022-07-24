require 'rails_helper'

describe 'removem favourite space process', type: :feature do

    context 'removing favourite space from make reservation' do

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

            visit '/make_reservation'
            click_button 'Filtra dipartimento'

            check("-1")
            click_button 'Conferma'
        end

        it "should not contain the just removed space" do
            expect(FavouriteSpace.where(user_id: @user.id, space_id: 1).count).to eq(0)
        end

    end

end