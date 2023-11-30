require 'rails_helper'

describe 'Lodge API' do
  context 'GET /api/v1/lodges/' do
    it 'list all active lodges' do
      user = User.create!(
        first_name: 'José', 
        last_name: 'Almeida', 
        personal_id: '66444882414', 
        email: 'jose@email.com', 
        password: 'strongpassword', 
        role: 'host'
      )
      
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

      get "/api/v1/lodges/"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 3
      expect(json_response[0]['brand_name']).to eq 'Charme da Montanha'
      expect(json_response[0]['registration_number']).to eq '03698521470812547'
      expect(json_response[0]['full_address']).to eq 'Avenida das Flores, 15'
      expect(json_response[0]['contact_number']).to eq '11987456321'
      expect(json_response[1]['brand_name']).to eq 'Pousada Sol Nascente'
      expect(json_response[1]['registration_number']).to eq '01514184897000136'
      expect(json_response[1]['full_address']).to eq 'Rua das Águas, 10'
      expect(json_response[1]['contact_number']).to eq '14998548758'
      expect(json_response[2]['brand_name']).to eq 'Villa das Águas'
      expect(json_response[2]['registration_number']).to eq '04125896321478596'
      expect(json_response[2]['full_address']).to eq 'Alameda das Fontes, 8'
      expect(json_response[2]['contact_number']).to eq '14789632541'
      expect(json_response[0]).not_to include 'user_id'
      expect(json_response[0]).not_to include 'status'
      expect(json_response[0]).not_to include 'created_at'
      expect(json_response[0]).not_to include 'updated_at'
    end

    it 'list lodge that matches with name given by parameter' do
      user = User.create!(
        first_name: 'José', 
        last_name: 'Almeida', 
        personal_id: '66444882414', 
        email: 'jose@email.com', 
        password: 'strongpassword', 
        role: 'host'
      )
      
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

      get "/api/v1/lodges/", params: { name: 'Charme' }

      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 1
      expect(json_response[0]['brand_name']).to eq 'Charme da Montanha'
      expect(json_response[0]['registration_number']).to eq '03698521470812547'
      expect(json_response[0]['full_address']).to eq 'Avenida das Flores, 15'
      expect(json_response[0]['contact_number']).to eq '11987456321'
    end
  end

  context 'GET /api/v1/lodges/1' do
    it 'list all active lodges' do
      user = User.create!(
        first_name: 'José', 
        last_name: 'Almeida', 
        personal_id: '66444882414', 
        email: 'jose@email.com', 
        password: 'strongpassword', 
        role: 'host'
      )
      
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

      room = lodge.rooms.create!(name: 'Quarto Duplo de Luxo', description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', area: '18', max_capacity: '2', standard_price: '150')
      room.create_service(has_bathroom: true, has_balcony: true, has_air_conditioner: true, has_tv: true, has_closet: true, has_vault: true, is_accessible: true)

      f_reservation = room.reservations.create!(start_date: 2.days.from_now, end_date: 7.days.from_now, status: 4, number_guests: 2, user_id: 1)
      s_reservation = room.reservations.create!(start_date: 2.days.from_now, end_date: 7.days.from_now, status: 4, number_guests: 2, user_id: 1)

      f_reservation.create_review!(rating: '5', commentary: 'Pousada incrível, muito hospitaleiros!')
      s_reservation.create_review!(rating: '5', commentary: 'Nunca vi nada igual, nota 5!')

      get "/api/v1/lodges/#{lodge.id}"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response.class).to eq Hash
      expect(json_response['brand_name']).to eq 'Pousada Sol Nascente'
      expect(json_response['full_address']).to eq 'Rua das Águas, 10'
      expect(json_response['city']).to eq 'São Paulo'
      expect(json_response['state']).to eq 'SP'
      expect(json_response['email']).to eq 'pousadasolnascente@contato.com'
      expect(json_response['zip_code']).to eq '01100036'
      expect(json_response['contact_number']).to eq '14998548758'
      expect(json_response['description']).to eq 'Uma pousada com maravilhas do campo e vistas inimagináveis.'
      expect(json_response['pets']).to eq 'sim'
      expect(json_response['terms_of_service']).to eq 'Proíbido som alto'
      expect(json_response['check_in']).to eq '11:30'
      expect(json_response['check_out']).to eq '12:00'
      expect(json_response['status']).to eq 'ativo'
      expect(json_response['average_ratings']).to eq 5.0

      expect(json_response.keys).not_to include 'user_id'
      expect(json_response.keys).not_to include 'corporate_name'
      expect(json_response.keys).not_to include 'registration_number'
      expect(json_response.keys).not_to include 'created_at'
      expect(json_response.keys).not_to include 'updated_at'
    end
  end
end