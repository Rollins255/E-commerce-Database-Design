-- Create the ecommerce database
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- brand table
CREATE TABLE brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL
);

INSERT INTO brand (brand_name) VALUES ('Nike'), ('Samsung'), ('Apple');

-- color table
CREATE TABLE color (
    color_id INT AUTO_INCREMENT PRIMARY KEY,
    color_name VARCHAR(50) NOT NULL
);

INSERT INTO color (color_name) VALUES ('Red'), ('Blue'), ('Black');

-- size_category table
CREATE TABLE size_category (
    size_category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

INSERT INTO size_category (category_name) VALUES ('Clothing Sizes'), ('Shoe Sizes');

-- size_option table
CREATE TABLE size_option (
    size_option_id INT AUTO_INCREMENT PRIMARY KEY,
    size_category_id INT,
    size_label VARCHAR(10) NOT NULL,
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

INSERT INTO size_option (size_category_id, size_label) VALUES 
(1, 'S'), (1, 'M'), (1, 'L'),
(2, '40'), (2, '42');

-- product_category table
CREATE TABLE product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

INSERT INTO product_category (category_name) VALUES ('Clothing'), ('Electronics');

-- product table
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    productName VARCHAR(100) NOT NULL,
    brand_id INT,
    category_id INT,
    base_price DECIMAL(10,2),
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

INSERT INTO product (productName, brand_id, category_id, base_price) VALUES 
('T-Shirt', 1, 1, 15.99),
('Smartphone', 2, 2, 699.99);

-- product_item table
CREATE TABLE product_item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    size_option_id INT,
    color_id INT,
    stock_quantity INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id)
);

INSERT INTO product_item (product_id, size_option_id, color_id, stock_quantity) VALUES 
(1, 1, 1, 100),
(1, 2, 2, 150);

-- product_image table
CREATE TABLE product_image (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    image_url VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- INSERT INTO product_image (product_id, image_url) VALUES 


-- product_variation table
CREATE TABLE product_variation (
    variation_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    size_option_id INT,
    color_id INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id)
);

INSERT INTO product_variation (product_id, size_option_id, color_id) VALUES 
(1, 1, 1),
(1, 2, 2);

-- attribute_category table
CREATE TABLE attribute_category (
    attribute_category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

INSERT INTO attribute_category (category_name) VALUES ('Physical'), ('Technical');

-- attribute_type table
CREATE TABLE attribute_type (
    attribute_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
);

INSERT INTO attribute_type (type_name) VALUES ('Text'), ('Number'), ('Boolean');

-- product_attribute table
CREATE TABLE product_attribute (
    attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    attribute_category_id INT,
    attribute_type_id INT,
    attribute_name VARCHAR(100) NOT NULL,
    attribute_value VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id)
);

INSERT INTO product_attribute (product_id, attribute_category_id, attribute_type_id, attribute_name, attribute_value) VALUES 
(1, 1, 1, 'Material', 'Cotton'),
(2, 2, 1, 'Processor', 'Snapdragon');
