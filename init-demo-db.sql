-- ============================================================================
-- SendIt Cycles Demo Database Schema (PostgreSQL)
-- ============================================================================

-- Categories Table
CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Products Table
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  category_id INTEGER NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL,
  stock_quantity INTEGER NOT NULL DEFAULT 0,
  image_url VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

-- Users Table
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  role VARCHAR(20) DEFAULT 'user',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Orders Table
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  total_price DECIMAL(10, 2) NOT NULL,
  status VARCHAR(50) DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Order Items Table
CREATE TABLE order_items (
  id SERIAL PRIMARY KEY,
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  price_at_purchase DECIMAL(10, 2) NOT NULL,
  frame_size VARCHAR(2) DEFAULT 'M',
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Create Performance Indexes
CREATE INDEX idx_products_category_id ON products(category_id);
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_users_email ON users(email);

-- ============================================================================
-- SEED DATA
-- ============================================================================

-- Categories
INSERT INTO categories (name, description) VALUES
  ('XC', 'Cross-Country bikes for speed and efficiency'),
  ('Trail', 'Versatile all-purpose trail bikes'),
  ('Downcountry', 'Lightweight descending machines'),
  ('Enduro', 'Long-travel aggressive trail bikes'),
  ('Downhill', 'Gravity-focused extreme downhill bikes');

-- Products (Bikes)
INSERT INTO products (category_id, name, description, price, stock_quantity, image_url) VALUES
  (1, 'Swift XC Pro', 'Lightweight cross-country racer built for speed', 1499.99, 15, '/api/images/1-swift-xc-pro.jpg'),
  (2, 'TrailBlazer Elite', 'Versatile trail bike for all terrain mayhem', 2199.99, 20, '/api/images/2-trailblazer-elite.jpg'),
  (3, 'Alpine Descent', 'Lightweight with big descending capability', 2799.99, 10, '/api/images/3-alpine-descent.jpg'),
  (4, 'Beast Mode 29', 'Long travel aggressive enduro machine for tech', 3499.99, 12, '/api/images/4-beast-mode-29.jpg'),
  (5, 'Gravity King DH', 'Full suspension gravity focused monster truck', 4299.99, 8, '/api/images/5-gravity-king-dh.jpg'),
  (1, 'Cross Lite', 'Budget-friendly cross-country option', 899.99, 25, '/api/images/6-cross-lite.jpg'),
  (2, 'Trailmaster 27.5', 'Perfect 27.5" trail ripper for flow', 1899.99, 18, '/api/images/7-trailmaster-27.5.jpg'),
  (4, 'Enduro Plus', 'Feature-packed enduro workhorse', 3099.99, 14, '/api/images/8-enduro-plus.jpg');

-- Demo Users
INSERT INTO users (email, password_hash, first_name, last_name, role) VALUES
  ('admin@senditcycles.com', '$2a$10$PCcHVwS.8SPme67BvM9r7uztWnq/HSSM.QLPAuGGpG7nitIUwDveu', 'Admin', 'User', 'admin'),
  ('john.smith@email.com', '$2a$10$PCcHVwS.8SPme67BvM9r7uztWnq/HSSM.QLPAuGGpG7nitIUwDveu', 'John', 'Smith', 'user'),
  ('sarah.johnson@email.com', '$2a$10$PCcHVwS.8SPme67BvM9r7uztWnq/HSSM.QLPAuGGpG7nitIUwDveu', 'Sarah', 'Johnson', 'user'),
  ('mike.williams@email.com', '$2a$10$PCcHVwS.8SPme67BvM9r7uztWnq/HSSM.QLPAuGGpG7nitIUwDveu', 'Mike', 'Williams', 'user'),
  ('emma.davis@email.com', '$2a$10$PCcHVwS.8SPme67BvM9r7uztWnq/HSSM.QLPAuGGpG7nitIUwDveu', 'Emma', 'Davis', 'user');

-- Sample Orders
INSERT INTO orders (user_id, total_price, status) VALUES
  (2, 1499.99, 'completed'),
  (3, 4299.99, 'pending'),
  (4, 3499.99, 'shipped'),
  (5, 2199.99, 'completed'),
  (2, 899.99, 'pending');

-- Sample Order Items
INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase, frame_size) VALUES
  (1, 1, 1, 1499.99, 'M'),
  (2, 5, 1, 4299.99, 'L'),
  (3, 4, 1, 3499.99, 'L'),
  (4, 2, 1, 2199.99, 'M'),
  (5, 6, 2, 899.99, 'S');
