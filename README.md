# Belajar CodeIgniter 4

Proyek belajar [CodeIgniter 4](https://codeigniter.com/) dengan lingkungan pengembangan berbasis Docker (WSL2).

## Stack

| Service      | Image            | URL                     |
|--------------|------------------|-------------------------|
| `app`        | PHP 8.3 + Apache | http://localhost:8000   |
| `db`         | MariaDB 11       | (internal, host: `db`)  |
| `phpmyadmin` | phpMyAdmin       | http://localhost:8081   |

## Struktur

```
.
├── Dockerfile           # Image PHP 8.3 + Apache + ekstensi untuk CI4
├── docker-compose.yml   # app, db, phpmyadmin
└── src/                 # Kode aplikasi CodeIgniter 4
```

## Menjalankan setelah clone

```bash
git clone <url-repo> ci4-belajar
cd ci4-belajar

# 1. Build image & install dependency (vendor/ tidak ikut di-commit)
docker compose build
docker compose run --rm --no-deps -u www-data app composer install

# 2. Buat file environment
cp src/env src/.env
```

Edit `src/.env`, hapus tanda `#` lalu sesuaikan:

```ini
CI_ENVIRONMENT = development
app.baseURL = 'http://localhost:8000/'

database.default.hostname = db
database.default.database = ci4_belajar
database.default.username = ci4
database.default.password = secret
database.default.DBDriver = MySQLi
database.default.port = 3306
```

```bash
# 3. Jalankan
docker compose up -d
```

Buka http://localhost:8000.

## Perintah sehari-hari

```bash
docker compose up -d                                   # start
docker compose down                                    # stop
docker compose logs -f app                             # lihat log
docker compose exec -u www-data app php spark list     # perintah spark
docker compose exec -u www-data app composer require <paket>
```

> Kredensial database di `docker-compose.yml` hanya untuk pengembangan lokal.
