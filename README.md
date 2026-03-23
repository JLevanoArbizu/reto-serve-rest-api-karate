# Reto de Automatización QA - BackEnd (ServeRest API)

![Java](https://img.shields.io/badge/Java-17-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![Maven](https://img.shields.io/badge/Maven-3.6.0-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white)
![Karate DSL](https://img.shields.io/badge/Karate_DSL-1.4.1-000000?style=for-the-badge)
![JUnit 5](https://img.shields.io/badge/JUnit-5-25A162?style=for-the-badge&logo=junit5&logoColor=white)

Este repositorio contiene la suite de pruebas automatizadas para la API de Usuarios de [ServeRest](https://serverest.dev/), desarrollada en Java utilizando **Karate DSL**.

**Historia de Usuario base:** Como administrador del sistema, quiero poder gestionar los usuarios a través de la API para administrar la base de datos de usuarios.

## Estructura del Proyecto

La arquitectura del proyecto sigue el principio de **Separación de Responsabilidades (SoC)**, organizada de la siguiente manera:

```text
reto-serve-rest-api-karate/
├── src/
│   └── test/
│       └── java/
│           ├── features/             # Escenarios de negocio (CRUD)
│           │   └── usuarios.feature
│           ├── helpers/              # Utilidades JS para datos dinámicos
│           │   └── utils.js
│           ├── runners/              # Ejecutor centralizado Junit 5
│           │   └── KarateTest.java
│           ├── schemas/              # Contratos JSON para validación
│           │   └── usuario-schema.json
│           ├── karate-config.js      # Configuración global y ambientes
│           └── logback-test.xml      # Configuración de logs y reportes
└── pom.xml                           # Gestión de dependencias Maven

```
---

##  Instrucciones para ejecutar los Tests

Para correr esta suite de automatización en tu entorno local, sigue estos pasos:

### 1. Requisitos Previos
Asegúrate de tener instalado lo siguiente en tu sistema:
* **Java:** JDK 11 o superior (el proyecto compila en Java 17).
* **Maven:** Apache Maven 3.6.0 o superior.
* **Git:** Para clonar el repositorio.

### 2. Clonar el Proyecto
Abre tu terminal y ejecuta:

```bash
git clone [https://github.com/TU_USUARIO/reto-serve-rest-api-karate.git](https://github.com/TU_USUARIO/reto-serve-rest-api-karate.git)
```
```bash
cd reto-serve-rest-api-karate
```

### 3. Ejecución de la Suite Completa
Para correr todos los escenarios (CRUD positivo y casos negativos), utiliza el siguiente comando de Maven:

```bash
mvn test
```

### 4. Ejecución Específica (Opcional)
Si deseas ejecutar únicamente el archivo de características de usuarios de forma aislada, puedes usar:

```bash
mvn test -Dkarate.options="classpath:features/usuarios.feature"
```

---

##  Visualización de Reportes

Karate genera automáticamente un reporte HTML detallado de las pruebas. Al finalizar la ejecución de los comandos, puedes analizar los resultados, el Response Body y los Request Headers abriendo la siguiente ruta en tu navegador web:

**`target/karate-reports/karate-summary.html`**

---
##  Estrategia de Automatización y Patrones Utilizados

El diseño de esta suite de pruebas busca garantizar la escalabilidad y mantenibilidad del proyecto a largo plazo. Para ello, se aplicaron las siguientes estrategias y patrones de diseño:

### Estrategia de Pruebas
* **Validación de Contratos (Contract Testing):** Se prioriza la validación estricta de la estructura de las respuestas HTTP frente a esquemas JSON, garantizando que la API no rompa los contratos establecidos con el FrontEnd.
* **Aislamiento de Estado (Data Independence):** Los datos de prueba se generan de forma dinámica en tiempo de ejecución (ej. emails aleatorios). El flujo CRUD culmina con la eliminación del recurso (`DELETE`), garantizando que la base de datos regrese a su estado original para evitar colisiones en futuras ejecuciones.
* **Cobertura Positiva y Negativa:** Se separan los flujos ideales (Happy Path) de los flujos de error (Edge Cases), asegurando que el sistema maneje correctamente las excepciones y devuelva los códigos HTTP esperados.

### Patrones y Arquitectura
* **BDD (Behavior-Driven Development):** Uso de la sintaxis Gherkin (`Given`, `When`, `Then`) para construir escenarios de prueba legibles, atómicos y orientados al comportamiento, funcionando como documentación viva del negocio.
* **Separation of Concerns (SoC):** El proyecto divide las responsabilidades en módulos específicos para facilitar su mantenimiento:
    * `features/`: Contiene los escenarios de negocio (operaciones CRUD), separando la lógica de las pruebas por dominios o recursos.
    * `schemas/`: Centraliza los contratos JSON esperados, separando las aserciones de estructura de los pasos de la prueba.
    * `helpers/`: Almacena funciones de soporte (`utils.js`) para la generación dinámica de datos, manteniendo los archivos Gherkin limpios de lógica compleja.
    * `runners/`: Centraliza la ejecución de la suite de pruebas mediante JUnit 5.
    * `karate-config.js`: Gestiona la configuración global y variables de entorno (como la `baseUrl` y `timeouts`), permitiendo que la suite escale fácilmente a entornos de QA, Staging o Producción sin modificar las pruebas.

---


