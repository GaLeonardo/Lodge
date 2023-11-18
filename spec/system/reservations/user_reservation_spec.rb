require 'rails_helper'

describe 'User reserve a room' do
  it 'successfully' do
    user = User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)
    room = lodge.rooms.create!(name: 'Quarto Duplo de Luxo', description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', area: '18', max_people: '2', standard_price: '150')
    room.create_service(has_bathroom: true, has_balcony: true, has_air_conditioner: true, has_tv: true, has_closet: true, has_vault: true, is_accessible: true)

    visit root_path
    click_on 'Pousada Sol Nascente'
    click_on 'Quarto Duplo de Luxo'
    click_on 'Escolher Datas'

    fill_in 'Data de check-in', with: 3.days.from_now
    fill_in 'Data de check-out', with: 10.days.from_now
    fill_in 'Número de hóspedes', with: '2'
    click_on 'Criar Reserva'

    expect(page).to have_content 'Pré-Reserva'
    expect(page).to have_content "Check-in:"
    expect(page).to have_content "#{I18n.localize 3.days.from_now.to_date}"
    expect(page).to have_content "Check-out:"
    expect(page).to have_content "#{I18n.localize 10.days.from_now.to_date}"
    expect(page).to have_content 'Número de hóspedes: 2'
    expect(page).to have_content 'Valor total das diárias:'
    expect(page).to have_content 'R$ 1050,00'
  end
end