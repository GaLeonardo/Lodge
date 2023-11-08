require 'rails_helper'

describe 'Host create lodge' do
  it 'succesfully and see it from the lodge path' do 
    user = User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    PaymentMethod.create!(name: 'Pix')
    PaymentMethod.create!(name: 'Cartão de crédito')
    PaymentMethod.create!(name: 'Dinheiro')

    login_as(user)
    visit root_path
    click_on 'Criar pousada'
    fill_in 'Nome da pousada', with: 'Pousada Sol Nascente'
    fill_in 'Razão social', with: '016145548000145'
    fill_in 'CNPJ', with: '016145548000145'
    fill_in 'Telefone', with: '1432172845'
    fill_in 'E-mail', with: 'pousadasolnascente@contato.com'
    fill_in 'Endereço', with: 'Rua Ilha Bela, 500'
    fill_in 'Cidade', with: 'Cajamar'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '07750-750'
    fill_in 'Descrição', with: 'A pousada sol nascente, localizada em cajamar, tem belissimas vistas naturais e cachoeiras que revigoram a energia do espirito'
    select 'Pix', from: 'Método de pagamento'
    choose(id: 'lodge_pets_sim', option: 'sim')
    choose(id: 'lodge_status_ativo', option: 'ativo')
    fill_in 'Politica de uso da pousada', with: 'Proibido fumar e som alto após as 22:00h'
    fill_in 'Check-in', with: '11:00'
    fill_in 'Check-out', with: '12:00'
    click_on 'Cadastrar pousada'
    
    expect(page).to have_content 'Pousada cadastrada com sucesso!'
    expect(page).to have_content 'Pousada Sol Nascente'
    expect(page).to have_content 'Telefone para contato: 1432172845'
    expect(page).to have_content 'Email para contato: pousadasolnascente@contato.com'
  end

  it 'And see it from the root path' do 
    user = User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    PaymentMethod.create!(name: 'Pix')
    Lodge.create!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1, user_id: 1, payment_methods_id: 1)

    login_as(user)
    visit root_path

    expect(page).to have_content 'Pousada Sol Nascente'
    expect(page).to have_content 'Uma pousada com maravilhas do campo e vistas inimagináveis'
    expect(page).to have_content 'Rua das Águas, 10'
  end
end