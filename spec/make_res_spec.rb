require 'rails_helper'

describe 'make reservation process', type: :feature do

    context 'make reservation' do

        before(:each) do
            @user = User.find(1)
            @seat = Seat.find(743)

            visit '/users/sign_in'
            fill_in 'Email', with: @user.email
            fill_in 'Password', with: 'password'
            click_button 'Accedi'

            visit '/make_reservation'
            click_button 'Filtra dipartimento'

            check(@seat.id)
            click_button 'Conferma'
        end

        it "should contain the selected reservation" do
            expect(Reservation.where(user_id: 1, seat_id: 743).count).to eq(1)
        end
    end
end