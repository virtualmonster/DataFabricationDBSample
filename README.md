# SendIt Cycles Data Fabrication Demo Database

A containerized PostgreSQL database for demonstrating HCL DevOps Test Hub's data fabrication capabilities.

## Overview

This repository provides a standalone demo database that mirrors the SendIt Cycles e-commerce application schema, allowing you to:
- Demonstrate database schema inspection
- Show data reading capabilities
- Insert synthetic data using data fabrication tools
- Work independently from production environments

## Quick Start

```bash
chmod +x start-demo-db.sh
./start-demo-db.sh
```

The database will be available at:
- **Host:** localhost
- **Port:** 5432
- **Database:** sendit_cycles_demo
- **User:** sendit_demo
- **Password:** DemoPass123!

## Contents

- **Dockerfile** - PostgreSQL 16 Alpine image with initialization script
- **docker-compose.yml** - Container orchestration with persistent volume and health checks
- **init-demo-db.sql** - Complete schema and seed data for SendIt Cycles demo
- **start-demo-db.sh** - Convenience startup script

## Schema

The database includes the following tables:
- **categories** - Bike categories (XC, Trail, Enduro, etc.)
- **products** - 8 sample bikes with pricing and stock
- **users** - 5 demo users (admin + 4 customers)
- **orders** - 5 sample orders with various statuses
- **order_items** - Order line items with pricing snapshots

## Connection Strings

### JDBC (for Java/Test Hub)
```
jdbc:postgresql://localhost:5432/sendit_cycles_demo
```

### psql CLI
```bash
psql -h localhost -U sendit_demo -d sendit_cycles_demo
```

## Management

Stop the container:
```bash
docker-compose down
```

View logs:
```bash
docker-compose logs -f sendit-demo-db
```

Restart:
```bash
docker-compose up -d
```

## Data Persistence

Data is stored in a Docker volume (`sendit_demo_data`) and persists across container restarts.

## Notes

- This database is intentionally isolated from production
- Uses port 5432 - ensure no conflicts with existing PostgreSQL instances
- Default credentials are demo/dev only - change for production use
- Database automatically initializes on first run