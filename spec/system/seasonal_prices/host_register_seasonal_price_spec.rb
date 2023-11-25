require 'rails_helper'

describe 'Host create price by season' do
  it 'if is authenticated' do
    user = User.create!(first_name: 'José', last_name: 'Almeida', personal_id: '66444882414', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)
    room = lodge.rooms.create!(name: 'Quarto Duplo de Luxo', description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', area: '18', max_capacity: '2', standard_price: '150')
    room.create_service(has_bathroom: true, has_balcony: true, has_air_conditioner: true, has_tv: true, has_closet: true, has_vault: true, is_accessible: true)

    visit new_lodge_room_seasonal_price_path(lodge.id, room.id)
      
    expect(page).to have_current_path new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'if that doesnt overlap another existent seasonal price' do
    user = User.create!(first_name: 'José', last_name: 'Almeida', personal_id: '66444882414', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)
    room = lodge.rooms.create!(name: 'Quarto Duplo de Luxo', description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', area: '18', max_capacity: '2', standard_price: '150')
    room.create_service(has_bathroom: true, has_balcony: true, has_air_conditioner: true, has_tv: true, has_closet: true, has_vault: true, is_accessible: true)
    seasonal = room.seasonal_prices.create!(name: 'Verão', start_date: Date.today + 5.days, end_date: Date.today + 15.days, price: '29999')

    login_as(user)
    visit root_path
    click_on 'Minha pousada'
    click_on 'Quarto Duplo de Luxo'
    click_on 'Adicionar valor por período'
    fill_in 'Nome', with: 'Outono'
    fill_in 'Data de início', with: Date.today + 10.days
    fill_in 'Data de término', with: Date.today + 20.days
    fill_in 'Valor da diária', with: '20000'
    click_on 'Criar Preço de temporada'

    expect(page).to have_content 'Não foi possível adicionar preço de temporada.'
    expect(page).to have_content 'Preço de temporada não pode ter conflito com outros períodos.'
  end

  it 'Succesfully' do
    user = User.create!(first_name: 'José', last_name: 'Almeida', personal_id: '66444882414', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)
    room = lodge.rooms.create!(name: 'Quarto Duplo de Luxo', description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', area: '18', max_capacity: '2', standard_price: '15000')
    room.create_service(has_bathroom: true, has_balcony: true, has_air_conditioner: true, has_tv: true, has_closet: true, has_vault: true, is_accessible: true)

    login_as(user)
    visit root_path
    click_on 'Minha pousada'
    click_on 'Quarto Duplo de Luxo'
    click_on 'Adicionar valor por período'
    fill_in 'Nome', with: 'Verão'
    fill_in 'Data de início', with: Date.today + 5.days
    fill_in 'Data de término', with: Date.today + 25.days
    fill_in 'Valor da diária', with: '20000'
    click_on 'Criar Preço de temporada'

    expect(page).to have_content 'Preço de temporada adicionado com sucesso.'
    expect(page).to have_content 'Períodos programados'
    expect(page).to have_content 'Verão'
    expect(page).to have_content Date.today + 5.days
    expect(page).to have_content Date.today + 25.days
    expect(page).to have_content '200.0'
  end
end