require 'rails_helper'

describe 'User uses search to find lodge' do
  it 'and displays a message for blank search input' do
    visit root_path
    within('div#search-box') do
      fill_in 'search', with: ''
      click_on 'Buscar'
    end

    expect(page).to have_content 'A pesquisa não pode ser vazia'
    expect(page).to have_current_path root_path
  end

  it 'successfully searching by brand_name' do
    user = User.create!(first_name: 'José', last_name: 'Almeida', personal_id: '66444882414', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    lodge = user.create_lodge!(corporate_name: 'Pousada Recanto Almeida LTDA', brand_name: 'Pousada Recanto Almeida', registration_number: '02549631818281834', full_address: 'Rua das Marmitas, 20', city: 'Campos do Jordão', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Na Serra da Mantiqueira, a Pousada Recanto Almeida está localizada em Campos do Jordão. Oferece estacionamento gratuito e café da manhã. O café da manhã é servido diariamente com opções de panificados, sucos cereais e frutas. Nas proximidades da pousada, é possível encontrar restaurantes, padarias e bares.', pets: 1, terms_of_service: 'Liberado o som alto', check_in: '11:30', check_out: '12:00', status: 1)

    visit root_path
    within('div#search-box') do
      fill_in 'search', with: 'Pousada Recanto Almeida'
      click_on 'Buscar'
    end

    expect(page).to have_content 'Exibindo resultados encontrados para Pousada Recanto Almeida'
    expect(page).to have_content 'Aproximadamente 1 resultados'
    expect(page).to have_content 'Pousada Recanto Almeida'
    expect(page).to have_content 'Campos do Jordão'
    expect(page).to have_content 'SP'
    expect(page).to have_content 'Na Serra da Mantiqueira, a Pousada Recanto Almeida está localizada em Campos do Jordão. Oferece estacionamento gratuito e café da manhã. O café da manhã é servido diariamente com opções de panificados, sucos cereais e frutas. Nas proximidades da pousada, é possível encontrar restaurantes, padarias e bares.'
  end

  it 'successfully searching by city' do
    user = User.create!(first_name: 'José', last_name: 'Almeida', personal_id: '66444882414', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    lodge = user.create_lodge!(corporate_name: 'Pousada Recanto Almeida LTDA', brand_name: 'Pousada Recanto Almeida', registration_number: '02549631818281834', full_address: 'Rua das Marmitas, 20', city: 'Campos do Jordão', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Na Serra da Mantiqueira, a Pousada Recanto Almeida está localizada em Campos do Jordão. Oferece estacionamento gratuito e café da manhã. O café da manhã é servido diariamente com opções de panificados, sucos cereais e frutas. Nas proximidades da pousada, é possível encontrar restaurantes, padarias e bares.', pets: 1, terms_of_service: 'Liberado o som alto', check_in: '11:30', check_out: '12:00', status: 1)

    visit root_path
    within('div#search-box') do
      fill_in 'search', with: 'Campos do Jordão'
      click_on 'Buscar'
    end

    expect(page).to have_content 'Exibindo resultados encontrados para Campos do Jordão'
    expect(page).to have_content 'Aproximadamente 1 resultados'
    expect(page).to have_content 'Pousada Recanto Almeida'
    expect(page).to have_content 'Campos do Jordão'
    expect(page).to have_content 'SP'
    expect(page).to have_content 'Na Serra da Mantiqueira, a Pousada Recanto Almeida está localizada em Campos do Jordão. Oferece estacionamento gratuito e café da manhã. O café da manhã é servido diariamente com opções de panificados, sucos cereais e frutas. Nas proximidades da pousada, é possível encontrar restaurantes, padarias e bares.'
  end

  it 'successfully searching by city and displays multiple results' do
    user = User.create!(first_name: 'José', last_name: 'Almeida', personal_id: '66444882414', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    second_user = User.create!(first_name: 'João', last_name: 'Carlos', personal_id: '74184284214', email: 'joao@email.com', password: 'morestrongerpassword', role: 'host')

    user.create_lodge!(
      corporate_name: 'Pousada Sol Nascente LTDA', 
      brand_name: 'Pousada Sol Nascente', 
      registration_number: '01514184897000136', 
      full_address: 'Rua das Águas, 10', 
      city: 'Campos do Jordão', 
      state: 'SP', 
      email: 'pousadasolnascente@contato.com', 
      zip_code: '01100036', 
      contact_number: '14998548758', 
      description: 'Uma pousada com maravilhas do campo e vistas inimagináveis.', 
      pets: 1, 
      terms_of_service: 'Proíbido som alto', 
      check_in: '11:30', 
      check_out: '12:00', 
      status: 1
    ) 
    second_user.create_lodge!(
      corporate_name: 'Pousada Charme da Montanha Ltda',
      brand_name: 'Charme da Montanha',
      registration_number: '03698521470812547',
      full_address: 'Avenida das Flores, 15',
      city: 'Campos do Jordão',
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

    visit root_path
    within('div#search-box') do
      fill_in 'search', with: 'Campos do Jordão'
      click_on 'Buscar'
    end

    expect(page).to have_content 'Exibindo resultados encontrados para Campos do Jordão'
    expect(page).to have_content 'Aproximadamente 2 resultados'
    expect(page).to have_content 'Pousada Sol Nascente'
    expect(page).to have_content 'Charme da Montanha'
  end

  it 'successfully searching by full_address' do
    user = User.create!(first_name: 'José', last_name: 'Almeida', personal_id: '66444882414', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    lodge = user.create_lodge!(corporate_name: 'Pousada Recanto Almeida LTDA', brand_name: 'Pousada Recanto Almeida', registration_number: '02549631818281834', full_address: 'Rua das Marmitas, 20', city: 'Campos do Jordão', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Na Serra da Mantiqueira, a Pousada Recanto Almeida está localizada em Campos do Jordão. Oferece estacionamento gratuito e café da manhã. O café da manhã é servido diariamente com opções de panificados, sucos cereais e frutas. Nas proximidades da pousada, é possível encontrar restaurantes, padarias e bares.', pets: 1, terms_of_service: 'Liberado o som alto', check_in: '11:30', check_out: '12:00', status: 1)

    visit root_path
    within('div#search-box') do
      fill_in 'search', with: 'Rua das Marmitas, 20'
      click_on 'Buscar'
    end

    expect(page).to have_content 'Exibindo resultados encontrados para Rua das Marmitas, 20'
    expect(page).to have_content 'Aproximadamente 1 resultados'
    expect(page).to have_content 'Pousada Recanto Almeida'
    expect(page).to have_content 'Campos do Jordão'
    expect(page).to have_content 'SP'
    expect(page).to have_content 'Na Serra da Mantiqueira, a Pousada Recanto Almeida está localizada em Campos do Jordão. Oferece estacionamento gratuito e café da manhã. O café da manhã é servido diariamente com opções de panificados, sucos cereais e frutas. Nas proximidades da pousada, é possível encontrar restaurantes, padarias e bares.'
  end
end