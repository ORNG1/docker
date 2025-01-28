<?php
    $mysqli = new mysqli('bdd', 'monuser', 'password', 'mabase');
    if (mysqli_connect_errno()) {
        printf("Connect failed: %s\n", mysqli_connect_error());
        exit();
    }

    if ($mysqli->query("INSERT INTO mabase.matable (compteur) SELECT count(*)+1 FROM mabase.matable;") === TRUE) {
        printf("Count updated\n<br />");
    }

    if ($result = $mysqli->query("SELECT * FROM mabase.matable")) {
        printf("Count : %d\n<br />", $result->num_rows);

        $result->close();
    } else {
        printf("Error with SELECT query: %s\n", $mysqli->error);
    }

    $mysqli->close();
?>