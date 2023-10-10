# Docker PostgreSQL 15 Example

Docker example for a Postgres 15 instance with the Postgis extension.

## Create a Dockerfile

You can create a custom Docker image based on the official PostgreSQL image, add the PostGIS extension, and include a bind-mounted volume to persist your data. Here's how you can create a Dockerfile for this purpose.

Create a file named `Dockerfile` (without any file extension) in your project directory with the following content:

```dockerfile
# Use the official PostgreSQL image as the base image
FROM postgres:15

# Set environment variables
ENV POSTGRES_DB=mydatabase
ENV POSTGRES_USER=myuser
ENV POSTGRES_PASSWORD=mypassword

# Install PostGIS extension
RUN apt-get update && \
    apt-get install -y postgresql-15-postgis-3

# Create a mount point for the data volume
VOLUME /var/lib/postgresql/data

# Copy custom SQL scripts to initialize the database
COPY init.sql /docker-entrypoint-initdb.d/

# Expose PostgreSQL port
EXPOSE 5432
```

Replace mydatabase, myuser, and mypassword with your desired database name, user, and password. Also, make sure to adjust the PostgreSQL version (e.g., `postgresql-15-postgis-3`) as needed.

## Create init.sql

Create a SQL script file named `init.sql` in the same directory as your Dockerfile. This script can contain any custom SQL commands you want to execute when the container starts. For example, you can include your `CREATE EXTENSION IF NOT EXISTS postgis;` command in this file.

```sql
-- init.sql
CREATE EXTENSION IF NOT EXISTS postgis;
```

## Commands to build a Docker image

Open a terminal in your project directory and build the Docker image using the following command:

```bash
docker build -t my-postgres-image .
```

Replace `my-postgres-image` with your desired image name.

### Run the Docker container

You can now run a container based on the custom image and bind-mount a local directory for persistent data:

```bash
docker run -d --name my-postgres-container -p 5432:5432 -v ./data my-postgres-image
```

Replace `/path/to/local/data` with the path to a local directory where you want to persist your PostgreSQL data.

This Dockerfile creates a custom PostgreSQL image with the PostGIS extension and a bind-mounted volume for data persistence. It also copies your custom SQL script to initialize the database. When you run a container from this image, it will execute the SQL script during initialization.

Make sure to adapt the configuration and settings to your specific requirements and preferences.

## Run the Docker setup

TL;DR here are all the commands:

```bash
docker build -t postgres-image .
docker run -d --name postgres-container-name -p 5432:5432 -v ./data:/var/lib/postgresql/data postgres-image
```

Stop all containers:

```bash
docker stop $(docker ps -a -q); docker rm $(docker ps -a -q) --force
```

Build and run in one command:

```bash
docker build -t postgres-image . && docker run -d --name postgres-container-name -p 5432:5432 -v ./data:/var/lib/postgresql/data postgres-image
```
