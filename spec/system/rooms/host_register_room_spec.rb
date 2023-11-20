require 'rails_helper'

describe 'Host create lodge room' do
  it 'if is authenticated' do
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

    visit new_lodge_room_path(lodge)

    expect(page).to have_current_path new_user_session_path
  end
  
  it 'from the homepage' do
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
    visit root_path
    click_on 'Cadastrar quarto'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Dimensão (m²)'
    expect(page).to have_field 'Quantidade de pessoas permitida'
    expect(page).to have_field 'Valor diário padrão'
    expect(page).to have_unchecked_field 'Banheiro'
    expect(page).to have_unchecked_field 'Varanda'
    expect(page).to have_unchecked_field 'Ar-condicionado'
    expect(page).to have_unchecked_field 'TV'
    expect(page).to have_unchecked_field 'Guarda-roupas'
    expect(page).to have_unchecked_field 'Cofre'
    expect(page).to have_unchecked_field 'Acessível para pessoas com deficiência'
    expect(page).to have_button 'Criar Quarto'
  end

  it 'displays errors for invalid inputs' do
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
    visit new_lodge_room_path(lodge)
    click_on 'Criar Quarto'

    expect(page).to have_content 'Não foi possível cadastrar o quarto.'
    expect(page).to have_content 'Nome do quarto não pode ficar em branco'
    expect(page).to have_content 'Descrição do quarto não pode ficar em branco'
    expect(page).to have_content 'Área não pode ficar em branco'
    expect(page).to have_content 'Quantidade de pessoas permitida não pode ficar em branco'
    expect(page).to have_content 'Valor diário padrão não pode ficar em branco'
  end

  it 'prevents creation of room with duplicate name' do
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
    room = lodge.rooms.create!(
      name: 'Quarto Duplo de Luxo', 
      description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', 
      area: '18', 
      max_capacity: '2', 
      standard_price: '150'
    )

    login_as user
    visit new_lodge_room_path(lodge)
    fill_in 'Nome', with: 'Quarto Duplo de Luxo'
    click_on 'Criar Quarto'

    expect(page).to have_content 'Não foi possível cadastrar o quarto.'
    expect(page).to have_content 'Nome do quarto já está em uso'
  end

  it 'sucessfully' do
    user = User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)

    login_as user
    visit root_path
    click_on 'Cadastrar quarto'
    fill_in 'Nome', with: 'Quarto Duplo de Luxo'
    fill_in 'Descrição', with: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.'
    fill_in 'Dimensão (m²)', with: '18'
    fill_in 'Quantidade de pessoas permitida', with: '2'
    fill_in 'Valor diário padrão' , with: '150'
    check 'Banheiro'
    check 'Varanda'
    check 'Ar-condicionado'
    check 'TV'
    check 'Guarda-roupas'
    check 'Cofre'
    check 'Acessível para pessoas com deficiência'
    click_on 'Criar Quarto'

    expect(page).to have_content 'Quarto cadastrado com sucesso.'
    expect(page).to have_content 'Quarto Duplo de Luxo'
    expect(page).to have_content 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.'
    expect(page).to have_content 'Área: 18 m²'
    expect(page).to have_content 'Quantidade de pessoas permitida: 2'
    expect(page).to have_content 'Valor Diária: R$ 150'
    expect(page).to have_content 'Banheiro'
    expect(page).to have_content 'Varanda'
    expect(page).to have_content 'Ar-condicionado'
    expect(page).to have_content 'TV'
    expect(page).to have_content 'Guarda-roupas'
    expect(page).to have_content 'Cofre'
    expect(page).to have_content 'Acessível para pessoas com deficiência'
  end
end