require 'rails_helper'

RSpec.describe SeasonalPrice, type: :model do
  describe '#valid' do
    context 'presence' do
      it 'name is mandatory' do
        seasonal_price = SeasonalPrice.new

        seasonal_price.valid?

        expect(seasonal_price.errors.include? :name).to be true
      end

      it 'start_date is mandatory' do
        seasonal_price = SeasonalPrice.new

        seasonal_price.valid?

        expect(seasonal_price.errors.include? :start_date).to be true
      end

      it 'end_date is mandatory' do
        seasonal_price = SeasonalPrice.new

        seasonal_price.valid?
        
        expect(seasonal_price.errors.include? :end_date).to be true
      end

      it 'price is mandatory' do
        seasonal_price = SeasonalPrice.new

        seasonal_price.valid?

        expect(seasonal_price.errors.include? :price).to be true
      end
    end

    context 'date range' do
      it 'end date is equal to start date' do
        seasonal_price = SeasonalPrice.new(name: 'Verão', start_date: Date.today, end_date: Date.today, price: 100)

        seasonal_price.valid?

        expect(seasonal_price.errors[:end_date]).to include('não pode ser anterior ou igual a data de início.')
      end

      it 'end date is greater than start date' do
        seasonal_price = SeasonalPrice.new(name: 'Verão', start_date: Date.today, end_date: Date.yesterday, price: 100)

        seasonal_price.valid?

        expect(seasonal_price.errors[:end_date]).to include('não pode ser anterior ou igual a data de início.')
      end

      it 'start date is past' do
        seasonal_price = SeasonalPrice.new(name: 'Verão', start_date: 1.day.ago, end_date: Date.today, price: 100)

        seasonal_price.valid?

        expect(seasonal_price.errors[:start_date]).to include('não pode ser no passado.')
      end

      it 'when last day conflicts with first day of existing one' do
        user = User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host')
        lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)
        room = lodge.rooms.create!(name: 'Quarto Duplo de Luxo', description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', area: '18', max_capacity: '2', standard_price: '150')
        room.create_service(has_bathroom: true, has_balcony: true, has_air_conditioner: true, has_tv: true, has_closet: true, has_vault: true, is_accessible: true)
        room.seasonal_prices.create!(name: 'Verão', start_date: 5.days.from_now, end_date: 15.days.from_now, price: '29999')
        seasonal = room.seasonal_prices.build(name: 'Outono', start_date: 1.day.from_now, end_date: 5.days.from_now, price: '30099')

        seasonal.valid?

        expect(seasonal.errors['Preço de temporada']).to include('não pode ter conflito com outros períodos.')
      end

      it 'when first day conflicts with last day of existing one' do
        user = User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host')
        lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)
        room = lodge.rooms.create!(name: 'Quarto Duplo de Luxo', description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', area: '18', max_capacity: '2', standard_price: '150')
        room.create_service(has_bathroom: true, has_balcony: true, has_air_conditioner: true, has_tv: true, has_closet: true, has_vault: true, is_accessible: true)
        room.seasonal_prices.create!(name: 'Verão', start_date: 5.days.from_now, end_date: 15.days.from_now, price: '29999')
        seasonal = room.seasonal_prices.build(name: 'Outono', start_date: 15.days.from_now, end_date: 20.days.from_now, price: '30099')
      
        seasonal.valid?
      
        expect(seasonal.errors['Preço de temporada']).to include('não pode ter conflito com outros períodos.')
      end
      
      it 'when the entire period is inside of an existing seasonal' do
        user = User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host')
        lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)
        room = lodge.rooms.create!(name: 'Quarto Duplo de Luxo', description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', area: '18', max_capacity: '2', standard_price: '150')
        room.create_service(has_bathroom: true, has_balcony: true, has_air_conditioner: true, has_tv: true, has_closet: true, has_vault: true, is_accessible: true)
        room.seasonal_prices.create!(name: 'Verão', start_date: 5.days.from_now, end_date: 15.days.from_now, price: '29999')
        seasonal = room.seasonal_prices.build(name: 'Outono', start_date: 7.days.from_now, end_date: 10.days.from_now, price: '30099')
      
        seasonal.valid?
      
        expect(seasonal.errors['Preço de temporada']).to include('não pode ter conflito com outros períodos.')
      end
      
      it 'when the existing period seasonal is entirely inside of the new seasonal' do
        user = User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host')
        lodge = user.create_lodge!(corporate_name: 'Pousada Sol Nascente LTDA', brand_name: 'Pousada Sol Nascente', registration_number: '01514184897000136', full_address: 'Rua das Águas, 10', city: 'São Paulo', state: 'SP', email: 'pousadasolnascente@contato.com', zip_code: '01100036', contact_number: '14998548758', description: 'Uma pousada com maravilhas do campo e vistas inimagináveis', pets: 1, terms_of_service: 'Proíbido som alto', check_in: '11:30', check_out: '12:00', status: 1)
        room = lodge.rooms.create!(name: 'Quarto Duplo de Luxo', description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', area: '18', max_capacity: '2', standard_price: '150')
        room.create_service(has_bathroom: true, has_balcony: true, has_air_conditioner: true, has_tv: true, has_closet: true, has_vault: true, is_accessible: true)
        room.seasonal_prices.create!(name: 'Verão', start_date: 5.days.from_now, end_date: 15.days.from_now, price: '29999')
        seasonal = room.seasonal_prices.build(name: 'Outono', start_date: 3.days.from_now, end_date: 17.days.from_now, price: '30099')
      
        seasonal.valid?
      
        expect(seasonal.errors['Preço de temporada']).to include('não pode ter conflito com outros períodos.')
      end
    end
  end
end
