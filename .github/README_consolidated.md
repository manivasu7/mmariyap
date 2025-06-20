# 📘 Consolidated README

## 🦸‍♂️ Main Documentation

# Marvel Characters API

API REST para gestión de personajes de Marvel, desarrollada en Java 17 + Spring Boot + Gradle.

## Despliegue de prueba

Ambiente de test: [http://bp-se-test-cabcd9b246a5.herokuapp.com](http://bp-se-test-cabcd9b246a5.herokuapp.com)

## Uso de la API

Todas las rutas requieren el parámetro de usuario (`{username}`) en el path:

```
http://bp-se-test-cabcd9b246a5.herokuapp.com/{username}/api/characters
```

Ejemplo usando el usuario `testuser`:

```
http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters
```

### Endpoints principales

#### Obtener todos los personajes
- **GET** `/ {username} /api/characters`

#### Obtener personaje por ID
- **GET** `/ {username} /api/characters/{id}`

#### Crear personaje
- **POST** `/ {username} /api/characters`
  - Body (JSON):
    ```json
    {
      "name": "Spider-Man",
      "alterego": "Peter Parker",
      "description": "Superhéroe arácnido de Marvel",
      "powers": ["Agilidad", "Sentido arácnido", "Trepar muros"]
    }
    ```

#### Actualizar personaje
- **PUT** `/ {username} /api/characters/{id}`
  - Body igual al POST

#### Eliminar personaje
- **DELETE** `/ {username} /api/characters/{id}`

### Ejemplo con curl
```sh
curl -X POST \
  http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "Iron Man",
    "alterego": "Tony Stark",
    "description": "Genio, millonario, playboy, filántropo",
    "powers": ["Armadura", "Inteligencia"]
  }'
```

### Colección Postman
Incluida en el repo: `MarvelCharactersAPI.postman_collection.json`

---

## Levantar el proyecto localmente

1. **Requisitos previos:**
   - Java 17 instalado
   - Gradle (o usar el wrapper incluido: `./gradlew`)

2. **Clona el repositorio:**
   ```sh
   git clone https://github.com/dg-juacasti/bp-dev-test
   cd bp-dev-test
   ```

3. **Construye el proyecto:**
   ```sh
   ./gradlew build o gradlew build
   ```

4. **Ejecuta la aplicación:**
   ```sh
   ./gradlew bootRun o gradlew bootRun
   ```
   o bien:
   ```sh
   java -jar app/build/libs/app-0.0.1-SNAPSHOT.jar
   ```

5. **La API estará disponible en:**
   - `http://localhost:8080/{username}/api/characters`

---

**Notas:**
- Cada usuario ({username}) tiene su propio espacio de personajes.


---

## 🧪 Additional Information

# Proyecto base de pruebas automatizadas con Karate, Java y Gradle

Este proyecto es una base para implementar pruebas automatizadas de la colección de peticiones entregadas (por ejemplo, una colección Postman). Todas las pruebas deben ser escritas en el archivo `src/test/resources/karate-test.feature` siguiendo la sintaxis de Karate DSL.

## Instrucciones de uso

### 1. Descarga del proyecto

Clona este repositorio en tu máquina local:

```sh
git clone https://github.com/dg-juacasti/test-automatisation-base
cd test-automatisation-base
```

### 2. Escribe tus pruebas

- Implementa los escenarios de prueba en el archivo:
  - `src/test/resources/karate-test.feature`
- Usa la sintaxis de Karate para definir los escenarios y validaciones.

### 3. Ejecuta las pruebas

Asegúrate de tener Java 17, 18 o 21 instalado y activo. Luego ejecuta:

```sh
./gradlew test o gradlew test
```

Esto compilará el proyecto y ejecutará todas las pruebas automatizadas.

---

- Si tienes problemas de SSL, puedes agregar la línea `* configure ssl = true` en el `Background` de tu archivo `.feature`.
- Los reportes de ejecución se generarán en la carpeta `karate-reports/`.


---

## 🧰 cURL Examples

# Ejemplos de uso de la Marvel Characters API (cURL)

> Dominio de test: http://bp-se-test-cabcd9b246a5.herokuapp.com
> Usuario de ejemplo: testuser

---

## Obtener todos los personajes
```sh
curl -X GET \
  http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters
```

## Obtener personaje por ID
```sh
curl -X GET \
  http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/1
```

## Crear personaje (válido)
```sh
curl -X POST \
  http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "Spider-Man",
    "alterego": "Peter Parker",
    "description": "Superhéroe arácnido de Marvel",
    "powers": ["Agilidad", "Sentido arácnido", "Trepar muros"]
  }'
```

## Crear personaje (nombre duplicado, error 400)
```sh
curl -X POST \
  http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "Spider-Man",
    "alterego": "Peter Parker",
    "description": "Otro intento duplicado",
    "powers": ["Agilidad"]
  }'
```

## Crear personaje (datos inválidos, error 400)
```sh
curl -X POST \
  http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "",
    "alterego": "",
    "description": "",
    "powers": []
  }'
```

## Obtener personaje inexistente (error 404)
```sh
curl -X GET \
  http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/9999
```

## Actualizar personaje (válido)
```sh
curl -X PUT \
  http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/1 \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "Spider-Man",
    "alterego": "Peter Parker",
    "description": "Superhéroe arácnido de Marvel (actualizado)",
    "powers": ["Agilidad", "Sentido arácnido", "Trepar muros"]
  }'
```

## Actualizar personaje inexistente (error 404)
```sh
curl -X PUT \
  http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/9999 \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "No existe",
    "alterego": "Nadie",
    "description": "No existe",
    "powers": ["Nada"]
  }'
```

## Eliminar personaje (válido)
```sh
curl -X DELETE \
  http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/1
```

## Eliminar personaje inexistente (error 404)
```sh
curl -X DELETE \
  http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/9999
```

