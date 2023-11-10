require 'rails_helper'

describe 'Host create price by season' do
  it 'Succesfully' do
    user = User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    user_lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)
    user_room = user_lodge.rooms.create!(name: 'Quarto Duplo de Luxo', description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', area: '18', max_people: '2', standard_price: '150')
    user_room.create_service(has_bathroom: true, has_balcony: true, has_air_conditioner: true, has_tv: true, has_closet: true, has_vault: true, is_accessible: true)

    login_as(user)
    visit root_path
    click_on 'Minha pousada'
    click_on 'Quarto Duplo de Luxo'
    click_on 'Adicionar valor por período'
    fill_in 'Nome', with: 'Verão'
    fill_in 'Data de início', with: '11/06/2023'
    fill_in 'Data de término', with: '11/07/2023'
    fill_in 'Valor da diária', with: '200'
    click_on 'Criar Preço de temporada'

    expect(page).to have_content 'Preço de temporada adicionado com sucesso.'
    expect(page).to have_content 'Períodos programados'
    expect(page).to have_content 'Verão'
    expect(page).to have_content '2023-06-11'
    expect(page).to have_content '2023-07-11'
    expect(page).to have_content '200'
  end
end