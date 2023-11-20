require 'rails_helper'

describe 'User autenticates' do
  it 'successfully as host' do
    user = User.create!(first_name: 'José', last_name: 'Almeida', personal_id: '66444882414', email: 'jose@email.com', password: 'strongpassword', role: 'host')

    visit root_path
    click_on 'Iniciar sessão'
    fill_in 'E-mail', with: 'jose@email.com'
    fill_in 'Senha', with: 'strongpassword'
    click_on 'Log in'

    expect(page).to have_content 'Para prosseguir, deve-se cadastrar uma pousada'
    expect(page).to have_content 'jose@email.com'
    expect(page).to have_content 'Criar pousada'
    expect(page).to have_button 'Sair'
    expect(page).not_to have_button 'Iniciar sessão'
  end
  
  it 'successfully as user' do
    user = User.create!(
      first_name: 'José', 
      last_name: 'Almeida',
      personal_id: '66444882414',
      email: 'jose@email.com', 
      password: 'strongpassword', 
    )

    visit root_path
    click_on 'Iniciar sessão'
    fill_in 'E-mail', with: 'jose@email.com'
    fill_in 'Senha', with: 'strongpassword'
    click_on 'Log in'

    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).to have_content 'jose@email.com'
    expect(page).not_to have_content 'Criar pousada'
    expect(page).to have_button 'Sair'
    expect(page).not_to have_button 'Iniciar sessão'
  end

  it 'but does not have account' do
    visit root_path
    click_on 'Iniciar sessão'
    fill_in 'E-mail', with: 'jose@email.com'
    fill_in 'Senha', with: 'strongpassword'
    click_on 'Log in'

    expect(page).to have_content 'E-mail ou senha inválidos.'
    expect(page).to have_content 'E-mail'
    expect(page).to have_content 'Senha'
    expect(page).to have_button 'Log in'
  end
end