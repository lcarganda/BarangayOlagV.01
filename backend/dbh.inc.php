<?php
$dsn = "mysql:host=mysql-leonarddevelopment.alwaysdata.net;dbname=leonarddevelopment_barangayolag";
$dbusername = "421947";
$dbpassword = "Arganda.2239";

try {
    $pdo = new PDO($dsn, $dbusername, $dbpassword);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
    exit;
}

?>