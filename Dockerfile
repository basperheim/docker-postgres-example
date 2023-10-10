# Use the official PostgreSQL image as the base image
FROM postgres:15

# Set environment variables
ENV POSTGRES_DB=my_db
ENV POSTGRES_USER=my_role
ENV POSTGRES_PASSWORD=0519

# Copy custom PostgreSQL configuration files
COPY postgresql.conf /etc/postgresql/postgresql.conf
COPY pg_hba.conf /etc/postgresql/pg_hba.conf

# Install PostGIS extension
RUN apt-get update && \
    apt-get install -y postgresql-15-postgis-3

# Create a mount point for the data volume
VOLUME /var/lib/postgresql/data

# Copy custom SQL scripts to initialize the database
COPY init.sql /docker-entrypoint-initdb.d/

# Expose PostgreSQL port
EXPOSE 5432