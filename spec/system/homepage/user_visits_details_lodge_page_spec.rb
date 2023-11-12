require 'rails_helper'

describe 'User visit details lodge' do
  it 'from the homepage' do
    user = User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)
    
    visit root_path
    click_on 'Pousada Sol Nascente'

    expect(page).to have_content 'Pousada Sol Nascente'
    expect(page).to have_content 'Uma pousada com maravilhas do campo e vistas inimagináveis'
    expect(page).to have_content 'Aceita pets: Sim'
    expect(page).to have_content 'Endereço: Rua das Águas, 10, São Paulo, SP - 01100036'
    expect(page).to have_content 'Telefone para contato: 14998548758'
    expect(page).to have_content 'Email para contato: pousadasolnascente@contato.com'
    expect(page).to have_content 'Politicas de uso: Proíbido som alto'
    expect(page).to have_content 'Check-in: 11:30'
    expect(page).to have_content 'Check-out: 12:00'
  end
end