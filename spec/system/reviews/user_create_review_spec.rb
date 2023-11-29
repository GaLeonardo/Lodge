require 'rails_helper'

describe 'User write a review for room that he reserved' do
  include ActiveSupport::Testing::TimeHelpers
  
  it 'sucessfully' do
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
    reservation.check_in_reservation
    travel 15.days
    reservation.check_out_reservation('bank_transfer', reservation)

    login_as second_user
    visit my_reservations_path
    click_on reservation.code
    click_on 'Escrever comentário'
    fill_in 'Comentário', with: 'Muito bom, nota 2'
    select '2', from: 'Nota'
    click_on 'Criar Review'


    expect(page).to have_content 'Comentário realizado com sucesso.'
    expect(page).to have_content "Comentário:"
    expect(page).to have_content 'Muito bom, nota 2'
    expect(page).to have_content 'Nota: 2'
  end
end