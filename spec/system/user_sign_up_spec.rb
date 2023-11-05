require 'rails_helper'

describe 'User create account' do
  it 'successfully as user' do

    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'José'
    fill_in 'E-mail', with: 'jose@gmail.com'
    fill_in 'Senha', with: 'strongpassword'
    fill_in 'Confirme sua senha', with: 'strongpassword'
    select 'Visitante', from: 'Tipo de Usuário'
    click_on 'Criar conta'

    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'jose@gmail.com'
    expect(page).to have_content 'Pousadas'
    expect(page).not_to have_content 'Criar pousada'
    expect(page).not_to have_button 'Entrar'
    expect(page).to have_button 'Sair'

    user = User.last
    expect(user.name).to eq 'José'
    expect(user.role).to eq 'Visitante'
  end

  it 'successfully as host' do

    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'José'
    fill_in 'E-mail', with: 'jose@gmail.com'
    fill_in 'Senha', with: 'strongpassword'
    fill_in 'Confirme sua senha', with: 'strongpassword'
    select 'Anfitrião', from: 'Tipo de Usuário'
    click_on 'Criar conta'

    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'jose@gmail.com'
    expect(page).to have_content 'Pousadas'
    expect(page).to have_content 'Criar pousada'
    expect(page).not_to have_button 'Entrar'
    expect(page).to have_button 'Sair'

    user = User.last
    expect(user.name).to eq 'José'
    expect(user.role).to eq 'Anfitrião'
  end
end