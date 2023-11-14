require 'rails_helper'

describe 'Host edit lodge' do
  it 'by homepage and see all options' do 
    user = User.create!(
      name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host'
    )
    user.create_lodge!(
      corporate_name: 'Pousada Sol Nascente LTDA', 
      brand_name: 'Pousada Sol Nascente', 
      registration_number: '01514184897000136', 
      full_address: 'Rua das Águas, 10', 
      city: 'São Paulo', 
      state: 'SP', 
      email: 'pousadasolnascente@contato.com', 
      zip_code: '01100036', 
      contact_number: '14998548758', 
      description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', 
      pets: 1, 
      terms_of_service: 'Proíbido som alto', 
      check_in: '11:30', 
      check_out: '12:00', 
      status: 1
    )

    login_as user
    visit root_path
    click_on 'Minha pousada'
    click_on 'Editar'

    expect(page).to have_content 'Nome da pousada'
    expect(page).to have_content 'Razão social'
    expect(page).to have_content 'CNPJ'
    expect(page).to have_content 'Telefone'
    expect(page).to have_content 'E-mail'
    expect(page).to have_content 'Endereço'
    expect(page).to have_content 'Cidade'
    expect(page).to have_content 'Estado'
    expect(page).to have_content 'CEP'
    expect(page).to have_content 'Descrição'
    expect(page).to have_content 'Check-in'
    expect(page).to have_content 'Check-out'
  end

  it 'and displays errors for invalid input' do
    user = User.create!(
      name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host'
    )
    lodge = user.create_lodge!(
      corporate_name: 'Pousada Sol Nascente LTDA', 
      brand_name: 'Pousada Sol Nascente', 
      registration_number: '01514184897000136', 
      full_address: 'Rua das Águas, 10', 
      city: 'São Paulo', 
      state: 'SP', 
      email: 'pousadasolnascente@contato.com', 
      zip_code: '01100036', 
      contact_number: '14998548758', 
      description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', 
      pets: 1, 
      terms_of_service: 'Proíbido som alto', 
      check_in: '11:30', 
      check_out: '12:00', 
      status: 1
    )

    login_as user
    visit edit_lodge_path(lodge)
    fill_in 'Telefone', with: ''
    fill_in 'CNPJ', with: ''
    click_on 'Atualizar Pousada'

    expect(page).to have_content 'Não foi possível editar a pousada.'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Telefone não pode ficar em branco'
  end

  it 'and prevents unauthorized access to edit page' do
    user = User.create!(
      name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host'
    )
    second_user = User.create!(
      name: 'João', 
      email: 'joao@email.com', 
      password: 'morestrongerpassword', 
      role: 'host'
    )

    lodge = user.create_lodge!(
      corporate_name: 'Pousada Sol Nascente LTDA', 
      brand_name: 'Pousada Sol Nascente', 
      registration_number: '01514184897000136', 
      full_address: 'Rua das Águas, 10', 
      city: 'São Paulo', 
      state: 'SP', 
      email: 'pousadasolnascente@contato.com', 
      zip_code: '01100036', 
      contact_number: '14998548758', 
      description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', 
      pets: 1, 
      terms_of_service: 'Proíbido som alto', 
      check_in: '11:30', 
      check_out: '12:00', 
      status: 1
    )
    second_lodge = second_user.create_lodge!(
      corporate_name: 'Pousada Charme da Montanha Ltda',
      brand_name: 'Charme da Montanha',
      registration_number: '03698521470812547',
      full_address: 'Avenida das Flores, 15',
      city: 'Monte Verde',
      state: 'MG',
      email: 'charmedamontanha@contato.com',
      zip_code: '04500236',
      contact_number: '11987456321',
      description: 'Encante-se com a beleza de Monte Verde na Pousada Charme da Montanha. Oferecemos quartos aconchegantes, café da manhã colonial e uma vista deslumbrante para as montanhas. Próximo a trilhas ecológicas e restaurantes típicos da região.',
      pets: 1,
      terms_of_service: 'Ambiente tranquilo, sem som alto',
      check_in: '14:00',
      check_out: '12:00',
      status: 1
    )

    

    login_as user
    visit lodge_path(second_lodge)

    expect(page).not_to have_content 'Editar'
  end

  it 'successfully' do 
    user = User.create!(
      name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host'
    )
    user.create_lodge!(
      corporate_name: 'Pousada Sol Nascente LTDA', 
      brand_name: 'Pousada Sol Nascente', 
      registration_number: '01514184897000136', 
      full_address: 'Rua das Águas, 10', 
      city: 'São Paulo', 
      state: 'SP', 
      email: 'pousadasolnascente@contato.com', 
      zip_code: '01100036', 
      contact_number: '14998548758', 
      description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', 
      pets: 1, 
      terms_of_service: 'Proíbido som alto', 
      check_in: '11:30', 
      check_out: '12:00', 
      status: 1
    )

    login_as user
    visit root_path
    click_on 'Minha pousada'
    click_on 'Editar'
    fill_in 'Telefone', with: '1433321758'
    fill_in 'Endereço', with: 'Rua das Flores, 100'
    choose(id: 'lodge_pets_nao', option: 'nao')
    click_on 'Atualizar Pousada'

    expect(page).to have_content 'Pousada editada com sucesso.'
    expect(page).to have_content 'Telefone para contato: 1433321758'
    expect(page).to have_content 'Endereço: Rua das Flores, 100'
    expect(page).to have_content 'Aceita pets: Nao'
  end
end