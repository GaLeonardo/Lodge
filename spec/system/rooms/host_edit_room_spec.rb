require 'rails_helper'

describe 'Host edit room' do
  it 'if is authenticated' do
    user = User.create!(
      name: 'José', 
      email: 'jose@email.com', 
      password: 'strongpassword', 
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
    room = lodge.rooms.create!(
      name: 'Quarto Duplo de Luxo', 
      description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', 
      area: '18', 
      max_capacity: '2', 
      standard_price: '150'
    )
    room.create_service(
      has_bathroom: true, 
      has_balcony: true, 
      has_air_conditioner: true, 
      has_tv: true, 
      has_closet: true, 
      has_vault: true, 
      is_accessible: true
    )

    visit edit_lodge_room_path(lodge, room)

    expect(page).to have_current_path new_user_session_path
  end

  it 'from the homepage' do
    user = User.create!(
      name: 'José', 
      email: 'jose@email.com', 
      password: 'strongpassword', 
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
    room = lodge.rooms.create!(
      name: 'Quarto Duplo de Luxo', 
      description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', 
      area: '18', 
      max_capacity: '2', 
      standard_price: '150'
    )
    room.create_service(
      has_bathroom: true, 
      has_balcony: true, 
      has_air_conditioner: true, 
      has_tv: true, 
      has_closet: false, 
      has_vault: true, 
      is_accessible: false
    )

    login_as user
    visit root_path
    click_on 'Minha pousada'
    click_on 'Quarto Duplo de Luxo'
    click_on 'Editar quarto'

    expect(page).to have_field('Nome do quarto', with: 'Quarto Duplo de Luxo')
    expect(page).to have_field('Descrição do quarto', with: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.')
    expect(page).to have_field('Dimensão (m²)', with: '18')
    expect(page).to have_field('Quantidade de pessoas permitida', with: '2')
    expect(page).to have_field('Valor diário padrão', with: '150')
    expect(page).to have_checked_field('Banheiro')
    expect(page).to have_checked_field('Varanda')
    expect(page).to have_checked_field('Ar-condicionado')
    expect(page).to have_checked_field('TV')
    expect(page).to have_unchecked_field('Guarda-roupas')
    expect(page).to have_checked_field('Cofre')
    expect(page).to have_unchecked_field('Acessível para pessoas com deficiência')
  end

  it 'displays errors for invalid inputs' do
    user = User.create!(
      name: 'José', 
      email: 'jose@email.com', 
      password: 'strongpassword', 
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
    room = lodge.rooms.create!(
      name: 'Quarto Duplo de Luxo', 
      description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', 
      area: '18', 
      max_capacity: '2', 
      standard_price: '150'
    )
    room.create_service(
      has_bathroom: true, 
      has_balcony: true, 
      has_air_conditioner: true, 
      has_tv: true, 
      has_closet: false, 
      has_vault: true, 
      is_accessible: false
    )

    login_as user
    visit edit_lodge_room_path(lodge, room)
    fill_in 'Nome do quarto', with: ''
    fill_in 'Descrição do quarto', with: ''
    fill_in 'Dimensão (m²)', with: ''
    fill_in 'Quantidade de pessoas permitida', with: ''
    fill_in 'Valor diário padrão', with: ''
    click_on 'Atualizar Quarto'

    expect(page).to have_content 'Não foi possível atualizar o quarto.'
    expect(page).to have_content 'Nome do quarto não pode ficar em branco'
    expect(page).to have_content 'Descrição do quarto não pode ficar em branco'
    expect(page).to have_content 'Área não pode ficar em branco'
    expect(page).to have_content 'Quantidade de pessoas permitida não pode ficar em branco'
    expect(page).to have_content 'Valor diário padrão não pode ficar em branco'
  end

  it 'sucessfully' do
    user = User.create!(
      name: 'José', 
      email: 'jose@email.com', 
      password: 'strongpassword', 
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
    room = lodge.rooms.create!(
      name: 'Quarto Duplo de Luxo', 
      description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', 
      area: '18', 
      max_capacity: '2', 
      standard_price: '150'
    )
    room.create_service(
      has_bathroom: true, 
      has_balcony: false, 
      has_air_conditioner: true, 
      has_tv: true, 
      has_closet: true, 
      has_vault: true, 
      is_accessible: false
    )
    
    login_as user
    visit edit_lodge_room_path(lodge, room)
    fill_in 'Nome do quarto', with: 'Quarto Luxo'
    fill_in 'Descrição do quarto', with: 'Quarto luxuoso com vista panorâmica.'
    fill_in 'Dimensão (m²)', with: '25'
    fill_in 'Quantidade de pessoas permitida', with: '2'
    fill_in 'Valor diário padrão', with: '150'
    check 'Varanda'
    uncheck 'Guarda-roupas'
    check 'Acessível para pessoas com deficiência'
    click_on 'Atualizar Quarto'

    expect(page).to have_content 'Quarto atualizado com sucesso.'
    expect(page).to have_content 'Quarto Luxo'
    expect(page).to have_content 'Quarto luxuoso com vista panorâmica.'
    expect(page).to have_content 'Área: 25 m²'
    expect(page).to have_content 'Quantidade de pessoas permitida: 2'
    expect(page).to have_content 'Valor Diária: R$ 150'
    expect(page).to have_content 'Varanda'
    expect(page).to_not have_content 'Guarda-roupas'
    expect(page).to have_content 'Acessível para pessoas com deficiência'
  end
end