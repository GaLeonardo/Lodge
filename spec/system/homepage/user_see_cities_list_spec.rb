require 'rails_helper'

describe 'User see cities list from homepage' do
  it 'and can click to see more details' do
    user = User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)

    visit root_path
    within('div#cities') do
      click_on 'São Paulo'
    end

    expect(page).to have_content 'Pousadas em São Paulo'
    expect(page).to have_content 'Pousada Sol Nascente'
    expect(page).to have_content 'São Paulo'
    expect(page).to have_content 'SP'
    expect(page).to have_content 'Uma pousada com maravilhas do campo e vistas inimagináveis'
  end

  it '' do
    
  end
end