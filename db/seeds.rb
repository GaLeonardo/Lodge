# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.create!(name: 'José', email: 'jose@email.com', password: 'strongpassword', role: 'host')
second_user = User.create!(name: 'João', email: 'joao@email.com', password: 'morestrongerpassword', role: 'host')
third_user = User.create!(name: 'Clauber', email: 'clauber@email.com', password: 'morestrongerpassword', role: 'host')
fourth_user = User.create!(name: 'Ricardo', email: 'ricardo@email.com', password: 'twowaymorestrongerpassword', role: 'host')
fifth_user = User.create!(name: 'Renan', email: 'renan@email.com', password: 'evenmorethanricardopassword', role: 'host')

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

room = lodge.rooms.create!(
  name: 'Quarto Duplo de Luxo', 
  description: 'Com varanda, esta unidade oferece aquecimento, TV LCD de 32" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.', 
  area: '18', 
  max_capacity: '5', 
  standard_price: '150'
)
room.create_service(
  has_bathroom: true, 
  has_balcony: true, 
  has_air_conditioner: true, 
  has_tv: true, 
  has_closet: false, 
  has_vault: true, 
  is_accessible: false
)