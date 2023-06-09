<?php
    require "connect.php";

    if ($_SERVER['REQUEST_METHOD'] == "POST") {
        $response = array();
        $nobp = $_POST['nobp'];
        $password = $_POST['password'];

        $cek = "SELECT * FROM mahasiswa WHERE nobp='$nobp'";
        $result = mysqli_query($con, $cek);

        if (mysqli_num_rows($result) > 0) {
            $row = mysqli_fetch_assoc($result);
            $storedPassword = $row['password'];

            if ($password == $storedPassword) {
                $response['value'] = 1;
                $response['message'] = 'Login Berhasil';
            } else {
                $response['value'] = 0;
                $response['message'] = "Login gagal: Password salah";
            }
        } else {
            $response['value'] = 0;
            $response['message'] = "Login gagal: User tidak ditemukan";
        }

        echo json_encode($response);
    }
?>
