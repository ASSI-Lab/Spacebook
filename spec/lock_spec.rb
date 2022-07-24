require 'rails_helper'

describe 'lock_user process', type: :feature do

    before(:each) do
        @admin = FactoryBot.create(:user_admin)
        @target = FactoryBot.create(:user_user)

        visit '/users/sign_in'
        fill_in 'email', with: @admin.email
        fill_in 'password', with: @admin.password
        click_button 'Accedi'

        visit '/management'
        page.find('#'+@target.id.to_s+'Blocca').click
    end

    context 'locking seen by the locking admin' do
        before(:each) do
            @target = User.find(2)
        end

        it "should have the locking_reason not null for the locked user" do
            expect(@target.locking_reason).to eq("Bloccato dall'amministratore")
        end

        it "should have sent an email to the right user with the locking_reason" do
            email = ActionMailer::Base.deliveries.first
            expect([email.from, email.to, email.subject]).to eq [["spacebook.adm@gmail.com"], [@target.email], "Your account has been blocked"]
        end

        it "should have changed the button of the locked user from 'Blocca' to 'Sblocca'" do
            expect(page.find('#'+@target.id.to_s+'Sblocca')).to be_truthy
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

        it "should display an expalanation alert" do
            expect(page).to have_text("Il tuo account è bloccato. Controlla la tua mail per sapere perchè è accaduto e per ripristinare il tuo account!")
        end

    end
end