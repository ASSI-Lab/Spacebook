require 'rails_helper'

describe 'unlock_user process', type: :feature do

    before(:each) do
        @user = User.find(9)
        @target = User.find(1)
        @target.locked_at = Time.now
        @target.save

        visit '/users/sign_in'
        fill_in 'email', with: @user.email
        fill_in 'password', with: 'password'
        click_button 'Accedi'

        visit '/management'
        page.find('#'+@target.id.to_s+'Sblocca').click
    end

    context 'unlocking seen by the locking admin' do

        it "should have the locking_reason null for the just unlocked user" do
            expect(User.find(1).locking_reason).to eq(nil)
        end

        it "should have sent an email to the right user with the unlock notification" do
            email = ActionMailer::Base.deliveries.last
            expect([email.from, email.to, email.subject]).to eq [["spacebook.adm@gmail.com"], [@target.email], "Your account has been unlocked"]
        end

        it "should have changed the button of the locked user from 'Sblocca' to 'Blocca'" do
            @target = User.find(1)
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