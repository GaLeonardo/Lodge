require 'rails_helper'

describe 'User view a review' do
  include ActiveSupport::Testing::TimeHelpers
  
  it 'rating from the homepage' do
    user = User.create!(first_name: 'José', last_name: 'Almeida', personal_id: '66444882414', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    second_user = User.create!(
      first_name: 'João',
      last_name: 'Silva',
      personal_id: '12345678901',
      email: 'joao@email.com',
      password: 'morestrongerpassword',
    )

    lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis.', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)
    room = lodge.rooms.create!(name: 'Quarto Duplo de Luxo', description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', area: '18', max_capacity: '2', standard_price: '150')
    room.create_service(has_bathroom: true, has_balcony: true, has_air_conditioner: true, has_tv: true, has_closet: true, has_vault: true, is_accessible: true)
    reservation = room.reservations.create!(start_date: Date.today, end_date: 15.days.from_now, status: 1, number_guests: 2, user_id: 2)
    reservation.check_in_reservation
    travel 15.days
    reservation.check_out_reservation('debit_card', reservation)
    review = reservation.build_review(rating: '5', commentary: 'Pousada incrível, muito hospitaleiros!').save

    login_as second_user
    visit root_path

    expect(page).to have_content 'Pousada Sol Nascente'
    expect(page).to have_content 'Nota: 5.0'
    expect(page).to have_content 'São Paulo'
    expect(page).to have_content 'SP'
    expect(page).to have_content 'Uma pousada com maravilhas do campo e vistas inimagináveis.'
  end

  it 'last three comments from the details lodge page' do
    user = User.create!(first_name: 'José', last_name: 'Almeida', personal_id: '66444882414', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    second_user = User.create!(
      first_name: 'João',
      last_name: 'Silva',
      personal_id: '12345678901',
      email: 'joao@email.com',
      password: 'morestrongerpassword',
    )

    lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis.', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)
    room = lodge.rooms.create!(name: 'Quarto Duplo de Luxo', description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', area: '18', max_capacity: '2', standard_price: '150')
    room.create_service(has_bathroom: true, has_balcony: true, has_air_conditioner: true, has_tv: true, has_closet: true, has_vault: true, is_accessible: true)
    reservation = room.reservations.create!(start_date: Date.today, end_date: 2.days.from_now, status: 1, number_guests: 2, user_id: 2)
    reservation.check_in_reservation
    travel 2.days
    reservation.check_out_reservation('deposit', reservation)
    reservation.create_review(rating: '5', commentary: 'Pousada incrível, muito hospitaleiros!')

    second_reservation = room.reservations.create!(start_date: Date.today, end_date: 2.days.from_now, status: 1, number_guests: 2, user_id: 2)
    second_reservation.check_in_reservation
    travel 2.days
    second_reservation.check_out_reservation('cash', reservation)
    second_reservation.create_review(rating: '3', commentary: 'Vista maravilhosa, quartos excelentes mas atendimento péssimo!')

    third_reservation = room.reservations.create!(start_date: Date.today, end_date: 2.days.from_now, status: 1, number_guests: 2, user_id: 2)
    third_reservation.check_in_reservation
    travel 2.days
    third_reservation.check_out_reservation('debit_card', reservation)
    third_reservation.create_review(rating: '4', commentary: 'Pousada boa')


    login_as second_user
    visit root_path
    click_on 'Pousada Sol Nascente'

    expect(page).to have_content 'Comentários'
    expect(page).to have_content 'Nota: 5.0'
    expect(page).to have_content 'Pousada incrível, muito hospitaleiros!'

    expect(page).to have_content 'Nota: 3.0'
    expect(page).to have_content 'Vista maravilhosa, quartos excelentes mas atendimento péssimo!'

    expect(page).to have_content 'Nota: 4.0'
    expect(page).to have_content 'Pousada boa'
  end

  it 'all comments from the review page from lodge' do
    user = User.create!(first_name: 'José', last_name: 'Almeida', personal_id: '66444882414', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    second_user = User.create!(
      first_name: 'João',
      last_name: 'Silva',
      personal_id: '12345678901',
      email: 'joao@email.com',
      password: 'morestrongerpassword',
    )

    lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis.', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)
    room = lodge.rooms.create!(name: 'Quarto Duplo de Luxo', description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', area: '18', max_capacity: '2', standard_price: '150')
    room.create_service(has_bathroom: true, has_balcony: true, has_air_conditioner: true, has_tv: true, has_closet: true, has_vault: true, is_accessible: true)
    reservation = room.reservations.create!(start_date: Date.today, end_date: 2.days.from_now, status: 1, number_guests: 2, user_id: 2)
    reservation.check_in_reservation
    travel 2.days
    reservation.check_out_reservation('deposit', reservation)
    reservation.create_review(rating: '5', commentary: 'Pousada incrível, muito hospitaleiros!')

    second_reservation = room.reservations.create!(start_date: Date.today, end_date: 2.days.from_now, status: 1, number_guests: 2, user_id: 2)
    second_reservation.check_in_reservation
    travel 2.days
    second_reservation.check_out_reservation('cash', reservation)
    second_reservation.create_review(rating: '3', commentary: 'Vista maravilhosa, quartos excelentes mas atendimento péssimo!')

    third_reservation = room.reservations.create!(start_date: Date.today, end_date: 2.days.from_now, status: 1, number_guests: 2, user_id: 2)
    third_reservation.check_in_reservation
    travel 2.days
    third_reservation.check_out_reservation('debit_card', reservation)
    third_reservation.create_review(rating: '4', commentary: 'Pousada boa')


    login_as second_user
    visit root_path
    click_on 'Pousada Sol Nascente'
    within('#reviews') do
      click_on 'Avaliações'
    end

    expect(page).to have_content 'Avaliações de Pousada Sol Nascente'
    expect(page).to have_content 'Nota: 5.0'
    expect(page).to have_content 'Pousada incrível, muito hospitaleiros!'

    expect(page).to have_content 'Nota: 3.0'
    expect(page).to have_content 'Vista maravilhosa, quartos excelentes mas atendimento péssimo!'

    expect(page).to have_content 'Nota: 4.0'
    expect(page).to have_content 'Pousada boa'
  end
end