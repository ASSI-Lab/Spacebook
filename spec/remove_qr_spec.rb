require 'rails_helper'

describe 'remove quick reservation process', type: :feature do

    context 'remove quick reservation' do

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

            check("QR1")
            click_button 'Conferma'
        end

        it "should not contain the quick reservation anymore" do
            expect(QuickReservation.where(user_id: @user.id).count).to eq(0)
        end

    end
end