Feature: Inventory API Test Scenarios

Background:
  * url baseUrl


Scenario: Add item with random id
  * def id = '' + Math.floor(Math.random() * 90 + 100)
  * def name = 'Pizza-' + id
  * def usedItem = 
  """
  { 
    "id": "#(id)", 
    "name": "HawaiiPrueba", 
    "image": "hawaiian.png", 
    "price": "$14" 
  }
  """
  * print 'ID generado:', id
  Given path 'inventory/add'
  And request usedItem
  When method POST
  Then status 200

    # Validar que el item fue agregado usando GET
  Given path 'inventory/filter'
  And param id = id
  When method GET
  Then status 200
  And match response == usedItem

Scenario: Add item for existent id (conflict)
* def usedSecondItem = {"id": "10","name": "Hawaiian","image": "hawaiian.png","price": "$14"}
  Given path 'inventory/add'
  And request usedSecondItem
  When method POST
  Then status 400  # Error de conflicto (id ya existe)

Scenario: Add item with missing info
  Given path 'inventory/add'
  And request { name: "Missing ID", image: "missing.png", price: "$10" }
  When method POST
  Then status 400
  And match response == 'Not all requirements are met'



Scenario: Get all menu items
  Given path 'inventory'
  When method GET
  Then status 200
  And assert response.data.length > 8
  And match each response.data contains { id: '#notnull', name: '#notnull', price: '#notnull', image: '#notnull' }

Scenario: Filter by id
  Given path 'inventory/filter'
  And param id = 3
  When method GET
  Then status 200
  And match response == { id: "3", name: "Baked Rolls x 8", image: "roll.png", price: "$10" }
