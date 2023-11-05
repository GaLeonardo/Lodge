require 'rails_helper'

describe 'Host edit lodge' do
  it 'successfully' do 
    user = User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
    PaymentMethod.create!(name: 'Pix')
    LodgeHouse.create!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1, user_id: 1, payment_methods_id: 1)

    login_as(user)
    visit root_path
    click_on 'Minha pousada'
    click_on 'Editar'
    fill_in 'Telefone', with: '1433321758'
    fill_in 'Endereço', with: 'Rua das Flores, 100'
    choose(id: 'lodge_house_pets_nao', option: 'nao')
    click_on 'Salvar'

    expect(page).to have_content 'Pousada editada com sucesso!'
    expect(page).to have_content 'Telefone para contato: 1433321758'
    expect(page).to have_content 'Endereço: Rua das Flores, 100'
    expect(page).to have_content 'Aceita pets? nao'
  end
end