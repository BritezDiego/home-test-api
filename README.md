
# Inventory API Tests

Este proyecto contiene pruebas para una API de inventario utilizando Karate, un marco de pruebas BDD basado en Java. Las pruebas cubren escenarios como la adición de artículos, la validación de los mismos y la gestión de errores como IDs duplicados o datos incompletos.

## Requisitos

- Java 8 o superior
- Maven

## Instrucciones de instalación y ejecución

### Clonar el repositorio

1. Clona el repositorio:

   ```bash
   git clone https://github.com/BritezDiego/home-test-api
   ```

### Construir el proyecto

1. Ejecuta el siguiente comando para descargar las dependencias y compilar el proyecto:

   ```bash
   mvn clean install
   ```

### Ejecutar las pruebas

1. Para ejecutar las pruebas, usa el siguiente comando de Maven:

   ```bash
   mvn test
   ```

   Esto ejecutará todos los escenarios definidos en los archivos `.feature` de Karate.

## Estructura del proyecto

El proyecto está organizado de la siguiente manera:

```
src
 └── test
      └── java
           └── classpath
                └── features
                     ├── inventory_test.feature   # Archivo de características con las pruebas de la API de inventario
                     ├── try-add.feature          # Archivo auxiliar para intentar agregar un item
      └── resources
           └── karate-config.js               # Configuración global de Karate
```

## Archivos Gherkin

Las pruebas están definidas en el archivo `inventory_test.feature`. Cada escenario sigue la sintaxis Gherkin, que describe el comportamiento esperado de la API bajo diversas condiciones.

Ejemplo de un escenario en Gherkin:

```gherkin
Feature: Inventory API Test Scenarios

Background:
  * url baseUrl

Scenario: Get all menu items
  Given path 'inventory'
  When method GET
  Then status 200
  And assert response.data.length >= 9
  And match each response.data contains { id: '#notnull', name: '#notnull', price: '#notnull', image: '#notnull' }
```

## Escenarios de prueba

1. **Get all menu items:** Obtiene todos los elementos del inventario y valida que la respuesta contiene al menos 9 artículos y que todos los artículos contienen los campos `id`, `name`, `price` e `image`.
   
2. **Filter by id:** Filtra los artículos por un `id` específico y valida que la respuesta sea la correcta.

3. **Add item for non existent id:** Añade un nuevo artículo con un ID aleatorio y valida que la respuesta tenga un código de estado 200.

4. **Add item for existent id (conflict):** Intenta añadir un artículo con un ID ya existente y valida que la respuesta tenga un código de estado 400.

5. **Add item with missing info:** Intenta añadir un artículo con datos faltantes (por ejemplo, sin ID) y valida que la respuesta tenga un código de estado 400 y un mensaje de error adecuado.

6. **Validate recent added item is present in the inventory:** Después de agregar un artículo, valida que este artículo se haya agregado correctamente al inventario consultando su `id` específico.
