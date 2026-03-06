#!/bin/bash

echo "Starting SendIt Cycles Demo Database Container..."
echo ""

# Build and start the container
docker-compose up -d

# Wait for database to be ready
echo "Waiting for database to be ready..."
sleep 5

# Check health
docker-compose exec -T sendit-demo-db pg_isready -U sendit_demo -d sendit_cycles_demo

echo ""
echo "✓ Demo database container is running"
echo ""
echo "Connection Details:"
echo "  Host: localhost"
echo "  Port: 5432"
echo "  Database: sendit_cycles_demo"
echo "  User: sendit_demo"
echo "  Password: DemoPass123!"
echo ""
echo "JDBC Connection String:"
echo "  jdbc:postgresql://localhost:5432/sendit_cycles_demo"
echo ""
echo "Container Info:"
docker ps | grep sendit_cycles_demo
echo ""
echo "To view logs: docker-compose logs -f sendit-demo-db"
echo "To stop: docker-compose down"
