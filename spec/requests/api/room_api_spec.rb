require 'rails_helper'

describe 'Room API' do
  context 'GET /api/v1/lodges/1/rooms/' do
    it 'list all available rooms at this lodge' do
      user = User.create!(
        first_name: 'José', 
        last_name: 'Almeida', 
        personal_id: '66444882414', 
        email: 'jose@email.com', 
        password: 'strongpassword', 
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

      room = lodge.rooms.create!(
        name: 'Quarto Duplo de Luxo', 
        description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', 
        area: '18', 
        max_capacity: '2', 
        standard_price: '150'
      )
      room.create_service(
        has_bathroom: true, 
        has_balcony: false, 
        has_air_conditioner: true, 
        has_tv: true, 
        has_closet: true, 
        has_vault: true, 
        is_accessible: false
      )

      s_room = lodge.rooms.create!(
        name: 'Quarto Standard',
        description: 'Quarto confortável com todas as comodidades essenciais.',
        area: '15',
        max_capacity: '2',
        standard_price: '100'
      )
      s_room.create_service(
        has_bathroom: true,
        has_balcony: true,
        has_air_conditioner: false,
        has_tv: true,
        has_closet: false,
        has_vault: false,
        is_accessible: true
      )

      get "/api/v1/lodges/#{lodge.id}/rooms/"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 2
      expect(json_response[0]['name']).to eq 'Quarto Duplo de Luxo'
      expect(json_response[0]['description']).to eq 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.'
      expect(json_response[0]['area']).to eq 18
      expect(json_response[0]['max_capacity']).to eq 2
      expect(json_response[0]['standard_price']).to eq 150
      expect(json_response[1]['name']).to eq 'Quarto Standard'
      expect(json_response[1]['description']).to eq 'Quarto confortável com todas as comodidades essenciais.'
      expect(json_response[1]['area']).to eq 15
      expect(json_response[1]['max_capacity']).to eq 2
      expect(json_response[1]['standard_price']).to eq 100
      expect(json_response[0]).not_to include 'created_at'
      expect(json_response[0]).not_to include 'updated_at'
    end
  end

  context 'POST /api/v1/lodges/1/rooms/1/pre_reservation' do
    it 'return reservation price if room is available' do
      user = User.create!(
        first_name: 'José', 
        last_name: 'Almeida', 
        personal_id: '66444882414', 
        email: 'jose@email.com', 
        password: 'strongpassword', 
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

      room = lodge.rooms.create!(
        name: 'Quarto Duplo de Luxo', 
        description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', 
        area: '18', 
        max_capacity: '2', 
        standard_price: '150'
      )
      room.create_service(
        has_bathroom: true, 
        has_balcony: false, 
        has_air_conditioner: true, 
        has_tv: true, 
        has_closet: true, 
        has_vault: true, 
        is_accessible: false
      )

      s_room = lodge.rooms.create!(
        name: 'Quarto Standard',
        description: 'Quarto confortável com todas as comodidades essenciais.',
        area: '15',
        max_capacity: '2',
        standard_price: '100'
      )
      s_room.create_service(
        has_bathroom: true,
        has_balcony: true,
        has_air_conditioner: false,
        has_tv: true,
        has_closet: false,
        has_vault: false,
        is_accessible: true
      )

      post "/api/v1/lodges/#{lodge.id}/rooms/#{room.id}/pre_reservation", params: { 
        room: room,
        start_date: 1.day.from_now,
        end_date: 10.days.from_now,
        number_guests: 2
      }

      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response.class).to eq Hash
      expect(json_response['total_price']).to eq 1350
      expect(json_response.keys).to include 'code'
      expect(json_response.keys).not_to include 'user_id'
      expect(json_response.keys).not_to include 'created_at'
      expect(json_response.keys).not_to include 'updated_at'
      expect(json_response.keys).not_to include 'status'
      expect(json_response.keys).not_to include 'room_id'
    end

    it 'return errors reservation if room is unavailable' do
      user = User.create!(
        first_name: 'José', 
        last_name: 'Almeida', 
        personal_id: '66444882414', 
        email: 'jose@email.com', 
        password: 'strongpassword', 
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

      room = lodge.rooms.create!(
        name: 'Quarto Duplo de Luxo', 
        description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', 
        area: '18', 
        max_capacity: '2', 
        standard_price: '150'
      )
      room.create_service(
        has_bathroom: true, 
        has_balcony: false, 
        has_air_conditioner: true, 
        has_tv: true, 
        has_closet: true, 
        has_vault: true, 
        is_accessible: false
      )
      room.reservations.create!(
        start_date: 5.days.from_now, 
        end_date: 15.days.from_now, 
        number_guests: 2,
        status: 'active'
      )

      post "/api/v1/lodges/#{lodge.id}/rooms/#{room.id}/pre_reservation", params: { 
        room: room,
        start_date: 1.day.from_now,
        end_date: 10.days.from_now,
        number_guests: 4
      }

      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)
      
      expect(json_response.class).to eq Hash
      expect(json_response.keys).to include 'errors'
      expect(json_response['errors']).to include 'Quarto não disponível na data selecionada.'
      expect(json_response['errors']).to include 'Número de hóspedes excede a capacidade do quarto.'
    end
  end
end