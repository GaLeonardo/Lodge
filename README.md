API V1 Endpoints
A seguir, estão listados os endpoints disponíveis na API V1.

1. Listagem de Pousadas
Endpoint: GET /api/v1/lodges[?name=]

Exemplo de Resposta:

[
  {
    "id": 1,
    "corporate_name": "Pousada Sol Nascente LTDA",
    "brand_name": "Pousada Sol Nascente",
    "registration_number": "01514184897000136",
    "full_address": "Rua das Águas, 10",
    "city": "São Paulo",
    "state": "SP",
    "email": "pousadasolnascente@contato.com",
    "zip_code": "01100036",
    "contact_number": "14998548758",
    "description": "Uma pousada com maravilhas do campo e vistas inimagináveis.",
    "pets": "sim",
    "terms_of_service": "Proíbido som alto",
    "check_in": "11:30",
    "check_out": "12:00"
  }
]

2. Detalhes de uma Pousada
Endpoint: GET /api/v1/lodges/:id

Exemplo de Resposta:

{
  "id": 1,
  "brand_name": "Pousada Sol Nascente",
  "full_address": "Rua das Águas, 10",
  "city": "São Paulo",
  "state": "SP",
  "email": "pousadasolnascente@contato.com",
  "zip_code": "01100036",
  "contact_number": "14998548758",
  "description": "Uma pousada com maravilhas do campo e vistas inimagináveis.",
  "pets": "sim",
  "terms_of_service": "Proíbido som alto",
  "check_in": "11:30",
  "check_out": "12:00",
  "status": "ativo",
  "average_ratings": 2
}

Ou, em caso de não encontrar a pousada:

Status: 404

{
  "errors": "Página não encontrada"
}

3. Listagem de Quartos de uma Pousada
Endpoint: GET /api/v1/lodges/:lodge_id/rooms

Exemplo de Resposta:

[
  {
    "id": 1,
    "name": "Quarto Duplo de Luxo",
    "description": "Com varanda, esta unidade oferece aquecimento, TV LCD de 32\" e frigobar. E ainda dispõe de Wi-Fi grátis, cofre digital e aparelho de DVD, bem como banheiro privativo com secador de cabelo.",
    "area": 18,
    "max_capacity": 5,
    "standard_price": 150,
    "lodge_id": 1,
    "service": {
      "has_bathroom": true,
      "has_balcony": true,
      "has_air_conditioner": true,
      "has_tv": true,
      "has_closet": false,
      "has_vault": true,
      "is_accessible": false
    }
  }
]

Ou, em caso de não encontrar quartos:

Status: 404

{
  "errors": "Página não encontrada"
}

4. Pré-Reserva de Quarto
Endpoint: GET /api/v1/lodges/:lodge_id/rooms/:room_id/pre_reservation?room_id=[]&start_date=[]&end_date=[]&number_guests=[]

Exemplo de Resposta:

{
  "id": 1,
  "start_date": "2023-12-02",
  "end_date": "2023-12-11",
  "total_price": 1350,
  "number_guests": 2,
  "code": "OSPI3154"
}

Sinta-se à vontade para explorar esses endpoints! 🚀
