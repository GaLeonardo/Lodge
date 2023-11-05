require 'rails_helper'

describe 'Host create loadge' do
  it 'succesfully' do 
    user = User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
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
    choose(id: 'lodge_house_pets_sim', option: 'sim')
    choose(id: 'lodge_house_status_ativo', option: 'ativo')
    fill_in 'Politica de uso da pousada', with: 'Proibido fumar e som alto após as 22:00h'
    fill_in 'Check-in', with: '11:00'
    fill_in 'Check-out', with: '12:00'
    click_on 'Cadastrar pousada'
    
    expect(page).to have_content 'Pousada cadastrada com sucesso!'
    expect(page).to have_content 'Pousada Sol Nascente'
    expect(page).to have_content 'Telefone para contato: 1432172845'
    expect(page).to have_content 'Email para contato: pousadasolnascente@contato.com'
  end
end