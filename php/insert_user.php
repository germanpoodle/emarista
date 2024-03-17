<?php
$hostname = 'localhost';
$username = 'root';
$password = '';
$database = 'emarista';
$port = 3307;

// Create connection
$db = new mysqli($hostname, $username, $password, $database, $port);

// Check connection
if ($db->connect_error) {
    die("Database connection failed: " . $db->connect_error);
}

// Get values from GET request
$studID = $_POST['studID'];
$studName = $_POST['studName'];

// Use prepared statement to prevent SQL injection
$sql = "INSERT INTO users (studID, studName) VALUES (?, ?)";
$stmt = $db->prepare($sql);

if ($stmt) {
    // Bind parameters and execute the statement
    $stmt->bind_param("ss", $studID, $studName);
    $stmt->execute();

    // Check for errors
    if ($stmt->error) {
        echo "Error: " . $stmt->error;
    } else {
        echo "Record inserted successfully.";
    }
    // Close the statement
    $stmt->close();
} else {
    echo "Error in preparing the statement.";
}

// Close the database connection
$db->close();
?>
