require 'rails_helper'

RSpec.describe LodgeHouse, type: :model do
  describe '#valid' do
    context 'presence' do
      it 'corporate_name is mandatory' do
        User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
        PaymentMethod.create!(name: 'Pix')
        lodge_house = LodgeHouse.new(corporate_name: '', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1, user_id: 1, payment_methods_id: 1)

        expect(lodge_house).not_to be_valid
      end

      it 'brand_name is mandatory' do
        User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
        PaymentMethod.create!(name: 'Pix')
        lodge_house = LodgeHouse.new(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: '', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1, user_id: 1, payment_methods_id: 1)

        expect(lodge_house).not_to be_valid
      end

      it 'registration_number is mandatory' do
        User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
        PaymentMethod.create!(name: 'Pix')
        lodge_house = LodgeHouse.new(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1, user_id: 1, payment_methods_id: 1)

        expect(lodge_house).not_to be_valid
      end

      it 'full_address is mandatory' do
        User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
        PaymentMethod.create!(name: 'Pix')
        lodge_house = LodgeHouse.new(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: '', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1, user_id: 1, payment_methods_id: 1)

        expect(lodge_house).not_to be_valid
      end

      it 'city is mandatory' do
        User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
        PaymentMethod.create!(name: 'Pix')
        lodge_house = LodgeHouse.new(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: '', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1, user_id: 1, payment_methods_id: 1)

        expect(lodge_house).not_to be_valid
      end

      it 'state is mandatory' do
        User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
        PaymentMethod.create!(name: 'Pix')
        lodge_house = LodgeHouse.new(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: '', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1, user_id: 1, payment_methods_id: 1)

        expect(lodge_house).not_to be_valid
      end

      it 'email is mandatory' do
        User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
        PaymentMethod.create!(name: 'Pix')
        lodge_house = LodgeHouse.new(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: '', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1, user_id: 1, payment_methods_id: 1)

        expect(lodge_house).not_to be_valid
      end

      it 'zip_code is mandatory' do
        User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
        PaymentMethod.create!(name: 'Pix')
        lodge_house = LodgeHouse.new(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1, user_id: 1, payment_methods_id: 1)

        expect(lodge_house).not_to be_valid
      end

      it 'contact_number is mandatory' do
        User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
        PaymentMethod.create!(name: 'Pix')
        lodge_house = LodgeHouse.new(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1, user_id: 1, payment_methods_id: 1)

        expect(lodge_house).not_to be_valid
      end

      it 'description is mandatory' do
        User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
        PaymentMethod.create!(name: 'Pix')
        lodge_house = LodgeHouse.new(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: '', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1, user_id: 1, payment_methods_id: 1)

        expect(lodge_house).not_to be_valid
      end

      it 'pets is mandatory' do
        User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
        PaymentMethod.create!(name: 'Pix')
        lodge_house = LodgeHouse.new(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: '', terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1, user_id: 1, payment_methods_id: 1)

        expect(lodge_house).not_to be_valid
      end

      it 'terms_of_service is mandatory' do
        User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
        PaymentMethod.create!(name: 'Pix')
        lodge_house = LodgeHouse.new(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: '', check_in: '11:30', check_out: '12:00', status: 1, user_id: 1, payment_methods_id: 1)

        expect(lodge_house).not_to be_valid
      end

      it 'check_in is mandatory' do
        User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
        PaymentMethod.create!(name: 'Pix')
        lodge_house = LodgeHouse.new(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '', check_out: '12:00', status: 1, user_id: 1, payment_methods_id: 1)

        expect(lodge_house).not_to be_valid
      end

      it 'check_out is mandatory' do
        User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
        PaymentMethod.create!(name: 'Pix')
        lodge_house = LodgeHouse.new(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '', status: 1, user_id: 1, payment_methods_id: 1)

        expect(lodge_house).not_to be_valid
      end

      it 'status is mandatory' do
        User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
        PaymentMethod.create!(name: 'Pix')
        lodge_house = LodgeHouse.new(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: '', user_id: 1, payment_methods_id: 1)

        expect(lodge_house).not_to be_valid
      end

      it 'user_id is mandatory' do
        User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
        PaymentMethod.create!(name: 'Pix')
        lodge_house = LodgeHouse.new(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1, user_id: '', payment_methods_id: 1)

        expect(lodge_house).not_to be_valid
      end

      it 'payment_methods_id is mandatory' do
        User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'Anfitrião')
        PaymentMethod.create!(name: 'Pix')
        lodge_house = LodgeHouse.new(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1, user_id: 1, payment_methods_id: '')

        expect(lodge_house).not_to be_valid
      end
    end
  end
end