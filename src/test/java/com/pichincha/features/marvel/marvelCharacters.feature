Feature: Pruebas de la API de Marvel Characters

  Background:
    * configure ssl = true
    * def baseUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def random = function() { return java.util.UUID.randomUUID() + '' }
    * def username = 'mmariyap_' + random().substring(0,8)
    * def apiPath = '/' + username + '/api/characters'
    * url baseUrl

  @get-all
  Scenario: Obtener todos los personajes
    Given path apiPath
    When method get
    Then status 200
    And match $ == '#array'
    
  @create
  Scenario: Crear un personaje válido
    Given path apiPath
    And request { name: 'Thor', alterego: 'Thor Odinson', description: 'Dios del trueno', powers: ['Control del rayo', 'Super fuerza', 'Mjolnir'] }
    And header Content-Type = 'application/json'
    When method post
    Then status 201
    And match response contains { id: '#number', name: 'Thor', alterego: 'Thor Odinson' }
    * def characterId = response.id
    
    # Verificar que el personaje fue creado
    Given path apiPath + '/' + characterId
    When method get
    Then status 200
    And match $.name == 'Thor'

  @error @validation
  Scenario: Error al crear un personaje con datos inválidos
    Given path apiPath
    And request { name: '', alterego: '', description: '', powers: [] }
    And header Content-Type = 'application/json'
    When method post
    Then status 400
    And match response.name == 'Name is required'

  @error @duplicated
  Scenario: Error al crear un personaje con nombre duplicado
    # Primero creamos un personaje
    Given path apiPath
    And request { name: 'Black Widow', alterego: 'Natasha Romanoff', description: 'Espía rusa', powers: ['Combate', 'Espionaje'] }
    And header Content-Type = 'application/json'
    When method post
    Then status 201
    
    # Intentamos crear otro con el mismo nombre
    Given path apiPath
    And request { name: 'Black Widow', alterego: 'Otra persona', description: 'Intento duplicado', powers: ['Nada'] }
    And header Content-Type = 'application/json'
    When method post
    Then status 400
    And match response.error == 'Character name already exists'

  @get-by-id
  Scenario: Obtener un personaje por ID
    # Primero creamos un personaje
    Given path apiPath
    And request { name: 'Captain America', alterego: 'Steve Rogers', description: 'Super soldado', powers: ['Super fuerza', 'Escudo de Vibranium'] }
    And header Content-Type = 'application/json'
    When method post
    Then status 201
    * def characterId = response.id
    
    # Ahora obtenemos el personaje por ID
    Given path apiPath + '/' + characterId
    When method get
    Then status 200
    And match $.name == 'Captain America'
    And match $.alterego == 'Steve Rogers'

  @error @not-found
  Scenario: Error al obtener un personaje inexistente
    Given path apiPath + '/9999'
    When method get
    Then status 404
    And match response.error == 'Character not found'

  @update
  Scenario: Actualizar un personaje existente
    # Primero creamos un personaje
    Given path apiPath
    And request { name: 'Hulk', alterego: 'Bruce Banner', description: 'Científico con problemas de ira', powers: ['Super fuerza'] }
    And header Content-Type = 'application/json'
    When method post
    Then status 201
    * def characterId = response.id
    
    # Ahora actualizamos el personaje
    Given path apiPath + '/' + characterId
    And request { name: 'Hulk', alterego: 'Bruce Banner', description: 'Científico con problemas de ira (actualizado)', powers: ['Super fuerza', 'Resistencia'] }
    And header Content-Type = 'application/json'
    When method put
    Then status 200
    And match $.description == 'Científico con problemas de ira (actualizado)'
    And match $.powers contains 'Resistencia'

  @error @update-not-found
  Scenario: Error al actualizar un personaje inexistente
    Given path apiPath + '/9999'
    And request { name: 'No existe', alterego: 'Nadie', description: 'No existe', powers: ['Nada'] }
    And header Content-Type = 'application/json'
    When method put
    Then status 404
    And match response.error == 'Character not found'

  @delete
  Scenario: Eliminar un personaje existente
    # Primero creamos un personaje
    Given path apiPath
    And request { name: 'Ant-Man', alterego: 'Scott Lang', description: 'Héroe que puede cambiar de tamaño', powers: ['Reducción', 'Comunicación con hormigas'] }
    And header Content-Type = 'application/json'
    When method post
    Then status 201
    * def characterId = response.id
    
    # Ahora eliminamos el personaje
    Given path apiPath + '/' + characterId
    When method delete
    Then status 204
    
    # Verificamos que ya no existe
    Given path apiPath + '/' + characterId
    When method get
    Then status 404

  @error @delete-not-found
  Scenario: Error al eliminar un personaje inexistente
    Given path apiPath + '/9999'
    When method delete
    Then status 404
    And match response.error == 'Character not found'

  @crud @smoke
  Scenario: Flujo completo - CRUD de personajes
    # 1. Crear personaje
    Given path apiPath
    And request { name: 'Iron Man', alterego: 'Tony Stark', description: 'Genio, millonario, playboy, filántropo', powers: ['Armadura', 'Inteligencia'] }
    And header Content-Type = 'application/json'
    When method post
    Then status 201
    * def characterId = response.id
    
    # 2. Obtener personaje por ID
    Given path apiPath + '/' + characterId
    When method get
    Then status 200
    And match $.name == 'Iron Man'
    
    # 3. Actualizar personaje
    Given path apiPath + '/' + characterId
    And request { name: 'Iron Man', alterego: 'Tony Stark', description: 'El mejor vengador', powers: ['Armadura', 'Inteligencia', 'Recursos'] }
    And header Content-Type = 'application/json'
    When method put
    Then status 200
    And match $.description == 'El mejor vengador'
    And match $.powers contains 'Recursos'
    
    # 4. Eliminar personaje
    Given path apiPath + '/' + characterId
    When method delete
    Then status 204
    
    # 5. Verificar que fue eliminado
    Given path apiPath + '/' + characterId
    When method get
    Then status 404
