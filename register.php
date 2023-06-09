<?php

require "connect.php";

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $response = array();
    $nobp = $_POST['nobp'];
    $username = $_POST['username'];
    $password = $_POST['password'];

    $cek = "SELECT * FROM mahasiswa WHERE nobp='$nobp'";
    $result = mysqli_query($con, $cek);

    if (mysqli_num_rows($result) > 0) {
        $response['value'] = 0;
        $response['message'] = "Registrasi gagal: NBP sudah terdaftar";
    } else {
        $insert = "INSERT INTO mahasiswa (nobp, username, password) VALUES ('$nobp', '$username', '$password')";
        $query = mysqli_query($con, $insert);

        if ($query) {
            $response['value'] = 1;
            $response['message'] = "Registrasi berhasil";
        } else {
            $response['value'] = 0;
            $response['message'] = "Registrasi gagal";
        }
    }

    echo json_encode($response);
}

?>

