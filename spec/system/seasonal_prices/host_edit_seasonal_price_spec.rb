require 'rails_helper'

describe 'Host edit seasonal price' do
  it 'successfully' do
    user = User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)
    room = lodge.rooms.create!(name: 'Quarto Duplo de Luxo', description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', area: '18', max_people: '2', standard_price: '150')
    room.create_service(has_bathroom: true, has_balcony: true, has_air_conditioner: true, has_tv: true, has_closet: true, has_vault: true, is_accessible: true)
    seasonal = room.seasonal_prices.create!(name: 'Verão', start_date: Date.today + 5.days, end_date: Date.today + 15.days, price: '29999')
    
    login_as user
    visit lodge_room_path(lodge.id, room.id)
    click_on 'Editar período'
    fill_in 'Nome', with: 'Outono'
    fill_in 'Data de início', with: Date.today + 30.days
    fill_in 'Data de término', with: Date.today + 60.days
    fill_in 'Valor da diária', with: '15999'
    click_on 'Atualizar Preço de temporada'

    expect(page).to have_content 'Preço de temporada editado com sucesso.'
    expect(page).to have_content 'Períodos programados'
    expect(page).to have_content 'Outono'
    expect(page).to have_content Date.today + 30.days
    expect(page).to have_content Date.today + 60.days
    expect(page).to have_content '159.99'
  end
end