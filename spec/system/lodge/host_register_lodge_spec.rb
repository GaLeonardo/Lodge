require 'rails_helper'

describe 'Host create lodge' do
  it 'if is authenticated' do
    visit new_lodge_path

    expect(page).to have_current_path new_user_session_path
  end

  it 'if is host' do
    user = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password', role: :visitor)

    login_as user
    visit new_lodge_path

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Acesso não autorizado.'
  end

  it 'cannot visit homepage until register a lodge' do
    user = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password', role: :host)

    login_as user
    visit root_path

    expect(page).to have_current_path new_lodge_path
  end

  it 'miss all datas and see errors' do
    user = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password', role: :host)

    login_as user
    visit new_lodge_path
    fill_in 'Nome da pousada', with: ''
    fill_in 'Razão social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Telefone', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Check-in', with: ''
    fill_in 'Check-out', with: ''
    click_on 'Criar Pousada'

    expect(page).to have_content 'Não foi possível cadastrar a pousada.'
    expect(page).to have_content 'Razão social não pode ficar em branco'
    expect(page).to have_content 'Nome da pousada não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'CEP não pode ficar em branco'
    expect(page).to have_content 'Telefone não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Pets não pode ficar em branco'
    expect(page).to have_content 'Politica de uso da pousada não pode ficar em branco'
    expect(page).to have_content 'Check-in não pode ficar em branco'
    expect(page).to have_content 'Check-out não pode ficar em branco'
    expect(page).to have_content 'Status não pode ficar em branco'
    expect(page).to have_content 'Pousada deve ter ao menos um método de pagamento'
  end
end