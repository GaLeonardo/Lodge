require 'rails_helper'

describe 'Host views checkin page' do
  it 'if is authenticated' do
    visit lodge_reservations_path

    expect(page).to have_current_path new_user_session_path
  end

  it 'from the homepage' do
    user = User.create!(first_name: 'José', last_name: 'Almeida', personal_id: '66444882414', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    second_user = User.create!(
      first_name: 'João',
      last_name: 'Silva',
      personal_id: '12345678901',
      email: 'joao@email.com',
      password: 'morestrongerpassword',
    )

    lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)
    room = lodge.rooms.create!(name: 'Quarto Duplo de Luxo', description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', area: '18', max_capacity: '2', standard_price: '150')
    room.create_service(has_bathroom: true, has_balcony: true, has_air_conditioner: true, has_tv: true, has_closet: true, has_vault: true, is_accessible: true)
    reservation = room.reservations.create!(start_date: 5.days.from_now, end_date: 15.days.from_now, status: 1, number_guests: 2, user_id: 2)

    login_as user
    visit root_path
    click_on 'Reservas'

    expect(page).to have_content 'Reservas Pousada Sol Nascente'
    expect(page).to have_content 'Quarto Duplo de Luxo'
    expect(page).to have_content "Check-in:"
    expect(page).to have_content "#{I18n.localize 5.days.from_now.to_date}"
    expect(page).to have_content "Check-out:"
    expect(page).to have_content "#{I18n.localize 15.days.from_now.to_date}"
    expect(page).to have_content 'Número de hóspedes: 2'
    expect(page).to have_content 'Valor total das diárias:'
    expect(page).to have_content reservation.total_price
    expect(page).to have_content 'Status da reserva: Confirmado'
  end

  context 'check-in' do
    it 'and fails due start_date isnt today' do
      user = User.create!(first_name: 'José', last_name: 'Almeida', personal_id: '66444882414', email: 'jose@email.com', password: 'strongpassword', role: 'host')
      second_user = User.create!(
        first_name: 'João',
        last_name: 'Silva',
        personal_id: '12345678901',
        email: 'joao@email.com',
        password: 'morestrongerpassword',
      )

      lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)
      room = lodge.rooms.create!(name: 'Quarto Duplo de Luxo', description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', area: '18', max_capacity: '2', standard_price: '150')
      room.create_service(has_bathroom: true, has_balcony: true, has_air_conditioner: true, has_tv: true, has_closet: true, has_vault: true, is_accessible: true)
      reservation = room.reservations.create!(start_date: 5.days.from_now, end_date: 15.days.from_now, status: 1, number_guests: 2, user_id: 2)
      
      login_as user
      visit lodge_reservations_path
      click_on reservation.code
      click_on 'Registrar Check-in'

      expect(page).to have_content 'Não foi possível realizar o check-in.'
      expect(page).to have_content 'Status da reserva: Confirmado'
    end

    it 'successfully' do
      user = User.create!(first_name: 'José', last_name: 'Almeida', personal_id: '66444882414', email: 'jose@email.com', password: 'strongpassword', role: 'host')
      second_user = User.create!(
        first_name: 'João',
        last_name: 'Silva',
        personal_id: '12345678901',
        email: 'joao@email.com',
        password: 'morestrongerpassword',
      )

      lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)
      room = lodge.rooms.create!(name: 'Quarto Duplo de Luxo', description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', area: '18', max_capacity: '2', standard_price: '150')
      room.create_service(has_bathroom: true, has_balcony: true, has_air_conditioner: true, has_tv: true, has_closet: true, has_vault: true, is_accessible: true)
      reservation = room.reservations.create!(start_date: Date.today, end_date: 15.days.from_now, status: 1, number_guests: 2, user_id: 2)
      
      login_as user
      visit lodge_reservations_path
      click_on reservation.code
      click_on 'Registrar Check-in'

      expect(page).to have_content 'Check-in realizado com sucesso.'
      expect(page).to have_content 'Status da reserva: Ativo'
      expect(page).not_to have_button 'Registrar Check-in'
    end
  end

  context 'cancel' do
    it 'successfully' do
      user = User.create!(first_name: 'José', last_name: 'Almeida', personal_id: '66444882414', email: 'jose@email.com', password: 'strongpassword', role: 'host')
      second_user = User.create!(
        first_name: 'João',
        last_name: 'Silva',
        personal_id: '12345678901',
        email: 'joao@email.com',
        password: 'morestrongerpassword',
      )

      lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)
      room = lodge.rooms.create!(name: 'Quarto Duplo de Luxo', description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', area: '18', max_capacity: '2', standard_price: '150')
      room.create_service(has_bathroom: true, has_balcony: true, has_air_conditioner: true, has_tv: true, has_closet: true, has_vault: true, is_accessible: true)
      reservation = room.reservations.create!(start_date: 3.days.ago, end_date: 15.days.from_now, status: 1, number_guests: 2, user_id: 2)
      reservation.check_in
      
      login_as user
      visit lodge_actives_path
      click_on reservation.code
      click_on 'Cancelar Reserva'

      expect(page).to have_content 'Reserva cancelada.'
      expect(page).to have_content 'Status da reserva: Cancelado'
      expect(page).not_to have_button 'Registrar Check-in'
      expect(page).not_to have_button 'Cancelar Reserva'
    end
  end
end