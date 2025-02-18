# Keycloak Authentication & Authorization Study Project

## Overview
This project is designed for studying authentication and authorization using **Keycloak**. It demonstrates how to integrate Keycloak with a Spring Boot application, leveraging OAuth2 and JWT-based security.

## Technologies Used
- **Spring Boot** (Security, OAuth2, JWT)
- **Keycloak** (Identity and Access Management)
- **Terraform** (Infrastructure as Code for Keycloak setup)

## Setup Instructions

### 1. Start Keycloak
Ensure you have **Keycloak** running locally. If you haven't installed it yet, you can use Docker:

```sh
docker run -d --name keycloak -p 8080:8080 \
  -e KEYCLOAK_ADMIN=admin \
  -e KEYCLOAK_ADMIN_PASSWORD=admin \
  quay.io/keycloak/keycloak:latest start-dev
```

### 2. Apply Terraform Configuration
Use **Terraform** to configure Keycloak:

```sh
cd terraform
terraform init
terraform apply
```

### 3. Run the Spring Boot Application
Ensure Keycloak is running, then start the application:

```sh
./mvnw spring-boot:run
```

### 4. Test Authentication
Use an API client (e.g., Postman) or `curl` to test authentication:

#### Obtain a Token
```sh
curl -X POST http://localhost:8080/realms/commerce/protocol/openid-connect/token \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=password" \
  -d "client_id=api-commerce" \
  -d "username=seller" \
  -d "password=1234"
```

#### Access Secure Endpoints
```sh
curl -H "Authorization: Bearer <TOKEN>" http://localhost:8081/secure/seller
```

## Project Structure
```
├── src/main/java/com/example/demo_authorization
│   ├── controller/SecureController.java
│   ├── config/SecurityConfig.java
├── terraform
│   ├── main.tf (Keycloak configuration)
├── application.yml
└── README.md
```

## Notes
- Replace `<TOKEN>` in API requests with an actual JWT token.
- Ensure Keycloak is accessible at `http://localhost:8080`.
- This project is for **learning purposes only** and does not include production-grade security hardening.

## License
This project is open-source and free to use for educational purposes.

