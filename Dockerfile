FROM postgres:16-alpine

# Set environment variables
ENV POSTGRES_DB=sendit_cycles_demo
ENV POSTGRES_USER=sendit_demo
ENV POSTGRES_PASSWORD=DemoPass123!

# Copy initialization script
COPY init-demo-db.sql /docker-entrypoint-initdb.d/01-init-schema.sql

# Expose PostgreSQL port
EXPOSE 5432
