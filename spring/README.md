# Spring

### pr6: REST API Q&A-форума с JWT · *Q&A forum REST API with JWT*

`Java 17` `Spring Boot` `Spring Security` `OAuth2 Resource Server` `Spring Data JPA` `PostgreSQL` `Swagger`

**Что сделано:**
- REST API без веб-страниц: `/api/questions`, `/api/answers`, `/api/comments`, `/api/tags`, `/api/question-tags`, `/api/votes`, `/api/users`, `/api/roles`. У каждого ресурса есть `GET` (список и по id), `POST`, `PUT`, `DELETE`
- Вход через `POST /api/auth/login`. Пользователь проверяется через `AuthenticationManager`, в ответ выдаётся JWT на 1 час
- Токены подписываются RSA-ключами (Nimbus `JwtEncoder` / `JwtDecoder`) и проверяются через `oauth2ResourceServer().jwt()`
- Stateless-сессии, пароли хешируются BCrypt
- Без токена открыты только логин и Swagger UI
- Глобальный обработчик ошибок

**Структура:**
```
pr6/src/main/java/org/example/pr6/
├── config/      # SecurityConfig, JwtConfig (загрузка RSA-ключей), OpenApiConfig
├── controller/  # AuthApiController + REST-контроллеры сущностей, GlobalExceptionHandler
├── model/       # JPA-сущности
├── repository/  # Spring Data JPA
└── service/     # CustomUserDetailsService
```

**Запуск:**
1. Сгенерируй ключи по инструкции в `src/main/resources/certs/README.md`.
2. Задай `DB_USER` и `DB_PASSWORD`.
3. Выполни `./mvnw spring-boot:run`.

---

## English

**pr6**: a Q&A forum REST API with JWT.
- CRUD endpoints for questions, answers, comments, tags, question-tags, votes, users and roles
- `POST /api/auth/login` returns a 1-hour JWT signed with RSA keys (Nimbus) and validated by the OAuth2 resource server
- Stateless sessions, BCrypt passwords; only login and Swagger UI are public
- Global exception handler

**Run:** generate keys (see `src/main/resources/certs/README.md`), set `DB_USER` / `DB_PASSWORD`, then `./mvnw spring-boot:run`.
