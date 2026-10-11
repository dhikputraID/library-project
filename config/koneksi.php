<?php
  // Database configuration
  $host = "localhost";
  $user = "root";
  $password = "";
  $database = "db_greatbook";
  
  // Connection to the database
  $koneksi = mysqli_connect($host, $user, $password, $database);
  
  if(!$koneksi) {
    die("connection failed!" . mysqli_connect_error());
  }
?>