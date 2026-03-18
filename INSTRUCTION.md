## Run with Docker Compose

### Start (build + run)
From the repository root:

```bash
docker compose up --build
```

App will be available on `http://localhost:8080/`  
API will be available on `http://localhost:8080/api/`

### Environment variables
The application reads DB config from these environment variables (provided by `docker-compose.yml`):
- `ENGINE`
- `NAME`
- `USER`
- `PASSWORD`
- `HOST`
- `PORT`

### Run in background

```bash
docker compose up -d --build
```

### Check status / logs

```bash
docker compose ps
docker compose logs -f
docker compose logs -f pythonapp
docker compose logs -f mysql
```

### Stop containers (keep DB data)

```bash
docker compose down
```

### Stop containers and remove DB data (DANGER)

```bash
docker compose down -v
```

