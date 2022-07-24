require 'rails_helper'

describe 'update quick reservation process', type: :feature do

    context 'update quick reservation' do

        before(:each) do
            @user = User.find(1)

            visit '/users/sign_in'
            fill_in 'email', with: @user.email
            fill_in 'password', with: 'password'
            click_button 'Accedi'

            visit '/make_reservation'
            click_button 'Filtra dipartimento'

            check("QR15")
            click_button 'Conferma'

            visit '/make_reservation'
            click_button 'Filtra dipartimento'

            check("QR16")
            click_button 'Conferma'
        end

        it "should have changed the space for the quick reservation" do
            expect(QuickReservation.where(user_id: @user.id).first.space_id).to eq(16)
        end
    end
end