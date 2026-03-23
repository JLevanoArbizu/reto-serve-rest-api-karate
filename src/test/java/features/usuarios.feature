Feature: Gestion de Usuarios en ServeRest

  Background:
    * url baseUrl
    * def userSchema = read('classpath:schemas/usuario-schema.json')
    * def utils = call read('classpath:helpers/utils.js')
    * def randomEmail = utils.getRandomEmail()

  Scenario: Flujo Completo CRUD de Usuario
    # 1. POST - Registrar usuario (Criterio 2)
    Given path 'usuarios'
    And request { nome: "Jose Levano", email: "#(randomEmail)", password: "testpassword", administrador: "true" }
    When method post
    Then status 201
    And match response.message == "Cadastro realizado com sucesso"
    * def userId = response._id

    # 2. GET - Buscar por ID (Criterio 3)
    Given path 'usuarios', userId
    When method get
    Then status 200
    And match response == userSchema
    And match response._id == userId

    # 3. PUT - Actualizar informacion (Criterio 4)
    Given path 'usuarios', userId
    And request { nome: "Jose Fernando", email: "#(randomEmail)", password: "newpassword", administrador: "true" }
    When method put
    Then status 200
    And match response.message == "Registro alterado com sucesso"

    # 4. DELETE - Eliminar usuario (Criterio 5)
    Given path 'usuarios', userId
    When method delete
    Then status 200
    And match response.message == "Registro excluído com sucesso"

  Scenario: Listar todos los usuarios y validar contrato (Criterio 1)
    Given path 'usuarios'
    When method get
    Then status 200
    And match each response.usuarios == userSchema

  Scenario: Caso Negativo - Registro con email duplicado (Criterio 2 - Negativo)
    # Primero creamos un usuario
    * def email = utils.getRandomEmail()
    Given path 'usuarios'
    And request { nome: "Original", email: "#(email)", password: "123", administrador: "true" }
    When method post
    Then status 201

    # Intentamos registrar el mismo email
    Given path 'usuarios'
    And request { nome: "Duplicado", email: "#(email)", password: "123", administrador: "true" }
    When method post
    Then status 400
    And match response.message == "Este email já está sendo usado"