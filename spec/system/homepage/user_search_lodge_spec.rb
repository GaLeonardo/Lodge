require 'rails_helper'

describe 'User uses search to find lodge' do
  it 'successfully searching by brand_name' do
    user = User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host')
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
    user = User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host')
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

  it 'successfully searching by full_address' do
    user = User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host')
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