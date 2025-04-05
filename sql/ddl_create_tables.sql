CREATE TABLE d_country (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE d_city (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE d_state (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE d_pet_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE d_breed (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE d_pet_category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE d_product_category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE d_color (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE d_brand (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE d_material (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE d_month (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE d_day (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE d_customer (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    email VARCHAR(50),
    country_id INT,
    postal_code VARCHAR(20),
    FOREIGN KEY (country_id) REFERENCES d_country (id) ON DELETE SET NULL
);

CREATE TABLE d_customer_pet (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    customer_id INT,
    type_id INT,
    breed_id INT,
    FOREIGN KEY (customer_id) REFERENCES d_customer (id) ON DELETE CASCADE,
    FOREIGN KEY (type_id) REFERENCES d_pet_type (id) ON DELETE SET NULL,
    FOREIGN KEY (breed_id) REFERENCES d_breed (id) ON DELETE SET NULL
);

CREATE TABLE d_seller (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    country_id INT,
    postal_code VARCHAR(20),
    FOREIGN KEY (country_id) REFERENCES d_country (id) ON DELETE SET NULL
);

CREATE TABLE d_time (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL UNIQUE,
    year INT,
    quarter INT,
    month_id INT,
    day_id INT,
    FOREIGN KEY (month_id) REFERENCES d_month (id) ON DELETE SET NULL,
    FOREIGN KEY (day_id) REFERENCES d_day (id) ON DELETE SET NULL
);

CREATE TABLE d_product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    category_id INT,
    price DECIMAL(10, 2),
    quantity INT,
    weight DECIMAL(10, 2),
    color_id INT,
    size VARCHAR(50),
    brand_id INT,
    material_id INT,
    description TEXT,
    rating DECIMAL(2, 1),
    reviews INT,
    release_date_id INT,
    expiry_date_id INT,
    FOREIGN KEY (category_id) REFERENCES d_product_category (id) ON DELETE SET NULL,
    FOREIGN KEY (color_id) REFERENCES d_color (id) ON DELETE SET NULL,
    FOREIGN KEY (brand_id) REFERENCES d_brand (id) ON DELETE SET NULL,
    FOREIGN KEY (material_id) REFERENCES d_material (id) ON DELETE SET NULL,
    FOREIGN KEY (release_date_id) REFERENCES d_time (id) ON DELETE SET NULL,
    FOREIGN KEY (expiry_date_id) REFERENCES d_time (id) ON DELETE SET NULL
);

CREATE TABLE f_sales (
    id SERIAL PRIMARY KEY,
    date_id INT,
    customer_id INT,
    seller_id INT,
    product_id INT,
    quantity INT,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (date_id) REFERENCES d_time (id) ON DELETE SET NULL,
    FOREIGN KEY (customer_id) REFERENCES d_customer (id) ON DELETE SET NULL,
    FOREIGN KEY (seller_id) REFERENCES d_seller (id) ON DELETE SET NULL,
    FOREIGN KEY (product_id) REFERENCES d_product (id) ON DELETE SET NULL
);

CREATE TABLE d_store (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    location VARCHAR(50),
    city_id INT,
    state_id INT,
    country_id INT,
    phone VARCHAR(20),
    email VARCHAR(50),
    FOREIGN KEY (city_id) REFERENCES d_city (id) ON DELETE SET NULL,
    FOREIGN KEY (state_id) REFERENCES d_state (id) ON DELETE SET NULL,
    FOREIGN KEY (country_id) REFERENCES d_country (id) ON DELETE SET NULL
);

CREATE TABLE d_supplier (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    contact VARCHAR(50),
    email VARCHAR(50) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(50),
    city_id INT,
    country_id INT,
    FOREIGN KEY (city_id) REFERENCES d_city (id) ON DELETE SET NULL,
    FOREIGN KEY (country_id) REFERENCES d_country (id) ON DELETE SET NULL
);