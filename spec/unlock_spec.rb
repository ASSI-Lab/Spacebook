require 'rails_helper'

describe 'unlock_user process', type: :feature do

    before(:each) do
        @admin = FactoryBot.create(:user_admin)
        @target = FactoryBot.create(:user_user)
        @target.locked_at = Time.now
        @target.save

        visit '/users/sign_in'
        fill_in 'email', with: @admin.email
        fill_in 'password', with: @admin.password
        click_button 'Accedi'

        visit '/management'
        page.find('#'+@target.id.to_s+'Sblocca').click
    end

    context 'unlocking seen by the locking admin' do
        before(:each) do
            @target = User.find(2)
        end

        it "should have the locking_reason null for the just unlocked user" do
            expect(@target.locking_reason).to eq(nil)
        end

        it "should have sent an email to the right user with the unlock notification" do
            email = ActionMailer::Base.deliveries.last
            expect([email.from, email.to, email.subject]).to eq [["spacebook.adm@gmail.com"], [@target.email], "Your account has been unlocked"]
        end

        it "should have changed the button of the locked user from 'Sblocca' to 'Blocca'" do
            expect(page.find('#'+@target.id.to_s+'Blocca')).to be_truthy
        end

    end

    context 'locking seen by the locked user' do
        before(:each) do
            page.find('#Esci').click

            visit '/users/sign_in'
            fill_in 'email', with: @target.email
            fill_in 'password', with: 'password'
            click_button 'Accedi'
        end

        it "should sign in succesfully" do
            expect(page).to have_text("Accesso effettuato con successo.")
        end

    end

end