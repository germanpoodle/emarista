<?php

// Database connection parameters
$hostname = 'localhost';
$username = 'root';
$password = '';
$database = 'emarista';
$port = 3307;

try {
    // Establishing a database connection
    $pdo = new PDO("mysql:host=$hostname;port=$port;dbname=$database", $username, $password);
    
    // Setting PDO to throw exceptions for errors
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // SQL query to create the 'products' table
    $createTableSQL = "CREATE TABLE IF NOT EXISTS products (
                id INT(11) AUTO_INCREMENT PRIMARY KEY,
                name VARCHAR(255) NOT NULL,
                price DECIMAL(10,2) NOT NULL,
                description TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )";

    // Executing the SQL query to create the table
    $pdo->exec($createTableSQL);

    echo "Table 'products' created successfully!<br>";

    // SQL query to insert products into the 'products' table
    $insertProductsSQL = "INSERT INTO products (name, price, description) VALUES
                            ('Product 1', 19.99, 'Description of Product 1'),
                            ('Product 2', 29.99, 'Description of Product 2'),
                            ('Product 3', 39.99, 'Description of Product 3')";

    // Executing the SQL query to insert products
    $pdo->exec($insertProductsSQL);

    echo "Products inserted successfully!";
} catch (PDOException $e) {
    // If an error occurs, PDOException will be thrown
    echo "Error: " . $e->getMessage();
}
