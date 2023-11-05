require 'rails_helper'

describe 'Host create lodge room' do
  it 'sucessfully' do
    user = User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
    PaymentMethod.create!(name: 'Pix')
    LodgeHouse.create!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1, user_id: 1, payment_methods_id: 1)

    login_as(user)
    visit root_path
    click_on 'Cadastrar quarto'
    fill_in 'Nome', with: 'Quarto Duplo de Luxo'
    fill_in 'Descrição', with: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.'
    fill_in 'Dimensão (m²)', with: '18'
    fill_in 'Quantidade máxima de pessoas por quarto', with: '2'
    fill_in 'Valor diário padrão' , with: '150'
    select 'Sim', from: 'banheiro'
    select 'Sim', from: 'varanda'
    select 'Sim', from: 'ar-condicionado'
    select 'Sim', from: 'TV'
    select 'Sim', from: 'guarda-roupa'
    select 'Sim', from: 'cofre'
    select 'Sim', from: 'acessivelPCD'
    click_on 'Salvar'

    expect(page).to have_content 'Quarto cadastrado com sucesso.'
    expect(page).to have_content 'Quarto Duplo de Luxo'
    expect(page).to have_content 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.'
    expect(page).to have_content 'Área: 18 m²'
    expect(page).to have_content 'Quantidade de pessoas permitida: 2'
    expect(page).to have_content 'Valor Diária: R$ 150'
    expect(page).to have_content 'Banheira'
    expect(page).to have_content 'Varanda'
    expect(page).to have_content 'Ar-Condicionado'
    expect(page).to have_content 'TV'
    expect(page).to have_content 'Guarda-Roupa'
    expect(page).to have_content 'Cofre'
    expect(page).to have_content 'Acessível para pessoas com deficiência'
  end
end