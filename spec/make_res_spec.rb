require 'rails_helper'

describe 'the make reservation process', type: :feature do
 before :each do
   User.create(email: 'user1@gmail.com', password: 'password', confirmed_at: Time.now, role:'user')
 end
 it 'makes reservation' do
   visit '/users/sign_in'
   fill_in 'Email', with: 'user1@gmail.com'
   fill_in 'Password', with: 'password'
   click_button 'Accedi'
  expect(current_path).to eq(root_path)
  expect(page).to have_text('Accesso effettuato con successo.')
  visit '/make_reservation'
  expect(page).to have_text('Seleziona il dipartimento')
  click_button 'Filtra dipartimento'
  @posto = Seat.find(743)
  @num_posto = @posto.position
  @spazio = Space.find(@posto.space_id)
  @dipartimento = Department.find(@spazio.department_id)
  check(@posto.id)
  click_button 'Conferma'
  expect(page).to have_current_path('/user_reservations')
  expect(page).to have_text("#{@dipartimento.name} #{@spazio.typology} #{@spazio.name} #{@spazio.floor} #{@num_posto} #{@posto.start_date.mday}-#{@posto.start_date.mon}-#{@posto.start_date.year} #{@posto.start_date.strftime('%H:%M')} - #{@posto.end_date.strftime('%H:%M')} Valida")
 end
 
end