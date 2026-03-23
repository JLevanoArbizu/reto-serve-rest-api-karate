# Reto de Automatización QA - BackEnd (ServeRest API)

Este repositorio contiene la suite de pruebas automatizadas para la API de Usuarios de [ServeRest](https://serverest.dev/), desarrollada en Java utilizando **Karate DSL**.

**Historia de Usuario base:** Como administrador del sistema, quiero poder gestionar los usuarios a través de la API para administrar la base de datos de usuarios.

---

## Cumplimiento de Especificaciones Técnicas

El proyecto ha sido diseñado para cumplir estrictamente con los 8 puntos solicitados en el reto:

1. **Configuración (Karate DSL):** Proyecto gestionado con Maven (`pom.xml`) utilizando el framework Karate.
2. **Feature Files:** Centralizado en `src/test/java/features/usuarios.feature` para cubrir los endpoints de usuarios.
3. **Operaciones CRUD Completas:** * `GET /usuarios`: Implementado para listar y validar todos los usuarios.
    * `POST /usuarios`: Implementado con generación de datos dinámicos.
    * `GET /usuarios/{_id}`: Búsqueda dinámica utilizando el ID generado en el POST.
    * `PUT /usuarios/{_id}`: Actualización del registro previamente creado.
    * `DELETE /usuarios/{_id}`: Eliminación del registro para garantizar la limpieza de la base de datos.
4. **Validación de Esquema JSON:** Se implementó `usuario-schema.json` en la carpeta `schemas/` para validar estrictamente la estructura y tipos de datos (ej. uso de Regex para emails).
5. **Casos Positivos y Negativos:** Además del flujo ideal (CRUD), se automatizó un escenario negativo para validar la respuesta HTTP 400 al intentar registrar un email duplicado.
6. **Helpers y Datos de Prueba:** Se desarrolló la utilidad `utils.js` en la carpeta `helpers/` para generar correos electrónicos únicos (`getRandomEmail`), evitando fallos por colisión de datos.
7. **Instrucciones de Ejecución:** Detalladas en la sección inferior.
8. **Repositorio:** Código versionado y subido a GitHub (este repositorio).

---

## ⚙️ Instrucciones para ejecutar los Tests

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

## 📊 Visualización de Reportes

Karate genera automáticamente un reporte HTML detallado de las pruebas. Al finalizar la ejecución de los comandos, puedes analizar los resultados, el Response Body y los Request Headers abriendo la siguiente ruta en tu navegador web:

**`target/karate-reports/karate-summary.html`**