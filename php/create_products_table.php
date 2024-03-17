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
    $sql = "CREATE TABLE IF NOT EXISTS products (
                id INT(11) AUTO_INCREMENT PRIMARY KEY,
                name VARCHAR(255) NOT NULL,
                price DECIMAL(10,2) NOT NULL,
                description TEXT,
            )";

    // Executing the SQL query
    $pdo->exec($sql);

    echo "Table 'products' created successfully!";
} catch (PDOException $e) {
    // If an error occurs, PDOException will be thrown
    echo "Error creating table: " . $e->getMessage();
}
