require "rails_helper.rb"

require_relative "../app/controllers/reservations_controller.rb"

RSpec.describe ReservationsController, :type => :controller do

    before(:all) do
        @curr_user = User.create!(email: "fra.test@gmail.com", password: "password", role: "user", confirmed_at: Time.now)
    end
    after(:all) do
        @curr_user.destroy
    end

    it "Effettua prenotazione dello spazio selezionato" do
        sign_in @curr_user
        params = { :"743" => "MakeRes" }
        post :make_actions, :params=> params
        jcr = Reservation.where(user_id: @curr_user.id)
        expect(jcr.count).to eq(1)
    end

end