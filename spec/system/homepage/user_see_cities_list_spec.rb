require 'rails_helper'

describe 'User see cities list from homepage' do
  it 'and see multiple cities' do
    user = User.create!(first_name: 'José', last_name: 'Almeida', personal_id: '66444882414', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    second_user = User.create!(
      first_name: 'João',
      last_name: 'Silva',
      personal_id: '12345678901',
      email: 'joao@email.com',
      password: 'morestrongerpassword',
      role: 'host'
    )

    third_user = User.create!(
      first_name: 'Clauber',
      last_name: 'Oliveira',
      personal_id: '98765432109',
      email: 'clauber@email.com',
      password: 'morestrongerpassword',
      role: 'host'
    )

    fourth_user = User.create!(
      first_name: 'Ricardo',
      last_name: 'Santos',
      personal_id: '56789012345',
      email: 'ricardo@email.com',
      password: 'twowaymorestrongerpassword',
      role: 'host'
    )

    fifth_user = User.create!(
      first_name: 'Renan',
      last_name: 'Pereira',
      personal_id: '98701234567',
      email: 'renan@email.com',
      password: 'evenmorethanricardopassword',
      role: 'host'
    )

    user.create_lodge!(
      corporate_name: 'Pousada Sol Nascente LTDA', 
      brand_name: 'Pousada Sol Nascente', 
      registration_number: '01514184897000136', 
      full_address: 'Rua das Águas, 10', 
      city: 'São Paulo', 
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
      city: 'Monte Verde',
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
    third_user.create_lodge!(
      corporate_name: 'Villa das Águas Hospedagem Eireli',
      brand_name: 'Villa das Águas',
      registration_number: '04125896321478596',
      full_address: 'Alameda das Fontes, 8',
      city: 'Brotas',
      state: 'SP',
      email: 'villadasaguas@contato.com',
      zip_code: '02300145',
      contact_number: '14789632541',
      description: 'A Pousada Villa das Águas proporciona uma experiência única em Brotas. Com quartos confortáveis, área de lazer com piscina e um ambiente cercado pela natureza. Próxima aos principais pontos turísticos da cidade.',
      pets: 0,
      terms_of_service: 'Proibido som alto, ambiente familiar',
      check_in: '15:00',
      check_out: '11:00',
      status: 1
    )
    fourth_user.create_lodge!(
      corporate_name: 'Serenity Inn Resorts Ltda',
      brand_name: 'Serenity Inn',
      registration_number: '03214569874125874',
      full_address: 'Estrada da Paz, 25',
      city: 'Gramado',
      state: 'RS',
      email: 'serenityinn@contato.com',
      zip_code: '05489632',
      contact_number: '51975321465',
      description: 'No coração de Gramado, a Serenity Inn oferece o charme e conforto que você procura. Quartos elegantes, café da manhã especial e proximidade aos principais eventos da cidade. Sua estadia será inesquecível.',
      pets: 0,
      terms_of_service: 'Ambiente tranquilo, sem som alto',
      check_in: '13:00',
      check_out: '12:00',
      status: 1
    )
    fifth_user.create_lodge!(
      corporate_name: 'Paraíso das Estrelas Pousadas SA',
      brand_name: 'Paraíso das Estrelas',
      registration_number: '02874159632587410',
      full_address: 'Rua do Céu, 7',
      city: 'Fernando de Noronha',
      state: 'PE',
      email: 'paraisodasestrelas@contato.com',
      zip_code: '02136589',
      contact_number: '81987456321',
      description: 'Em Fernando de Noronha, o Paraíso das Estrelas oferece uma experiência única. Aconchego, natureza e uma vista privilegiada para o mar. Próxima às principais praias e pontos turísticos da ilha.',
      pets: 0,
      terms_of_service: 'Respeito à natureza, sem som alto',
      check_in: '12:00',
      check_out: '10:00',
      status: 1
    )

    visit root_path

    within('div#cities') do
      expect(page).to have_content 'São Paulo'
      expect(page).to have_content 'Monte Verde'
      expect(page).to have_content 'Brotas'
      expect(page).to have_content 'Gramado'
      expect(page).to have_content 'Fernando de Noronha'
    end
  end

  it 'and can click to see more details' do
    user = User.create!(first_name: 'José', last_name: 'Almeida', personal_id: '66444882414', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)

    visit root_path
    within('div#cities') do
      click_on 'São Paulo'
    end

    expect(page).to have_content 'Pousadas em São Paulo'
    expect(page).to have_content 'Pousada Sol Nascente'
    expect(page).to have_content 'São Paulo'
    expect(page).to have_content 'SP'
    expect(page).to have_content 'Uma pousada com maravilhas do campo e vistas inimagináveis'
  end

  it 'can navigate back to the homepage after viewing city details' do
    user = User.create!(first_name: 'José', last_name: 'Almeida', personal_id: '66444882414', email: 'jose@email.com', password: 'strongpassword', role: 'host')
    lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)

    visit root_path
    within('div#cities') do
      click_on 'São Paulo'
    end
    click_on 'Pousadas'

    expect(page).to have_current_path root_path
  end
end