<?php
session_start();
$start_time = microtime(true);
include("login.php");
// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
$status = "";
// Foreign key columns mapping for each child table
$foreign_key_columns = [
    'actionnaire' => ['societe' => 'societe_id'],
    'agence' => ['reseau' => 'Reseau_id', 'ville' => 'ville_id'],
    'commentaireprojet' => ['projet' => 'projet_id'],
    'composition' => ['projet' => 'projet_id', 'typecomposition' => 'typecomposition_id'],
    'deblocage' => ['dossierdecredit' => 'dossierdecredit_id'],
    'documentprojet' => ['projet' => 'projet_id'],
    'dossierdecredit' => ['user' => 'Utilisateur_id', 'agence' => 'Agence_id', 'projet' => 'Projet_id', 'statutprojet' => 'Statut_id', 'typecredit' => 'typeCredit_id'],
    'ville' => ['region' => 'region_id'],
    'reseau' => ['directionregionale' => 'direction_regionale_id'],
    'user' => ["utilisateur" =>"TypeUtilisateur_id"],
    'rembourssement' => ["dossierdecredit" => "dossierdecredit_id"]
];

if (isset($_POST['action']) && isset($_POST['table_name']) && isset($_POST['index'])) {
    $action = $_POST['action'];
    $table_name = $_POST['table_name'];
    $index = $_POST['index'];
    $new_record = unserialize(html_entity_decode($_POST['new_records'][$table_name][$index]));

    if ($action == 'add') {
        addRecord($conn, $table_name, $new_record, $foreign_key_columns, $status);
    }

    echo $status;
    exit;
}

if (isset($_POST['action'])) {
    //print_r($_POST['action']);
    foreach ($_POST['action'] as $table_name => $actions) {
        if (is_array($actions)) {
            // Handling individual record actions
            foreach ($actions as $index => $action) {
                $new_record = unserialize(html_entity_decode($_POST['new_records'][$table_name][$index]));
                //print_r($new_record);
                if ($action == 'add') {
                    addRecord($conn, $table_name, $new_record, $foreign_key_columns, $status);
                }
            }
        } else {
            // Handling table-level actions
            $new_records = unserialize(html_entity_decode($_POST['new_records'][$table_name]));
            

            if ($actions == 'add_all') {
                foreach ($new_records as $new_record) {
                    addRecord($conn, $table_name, $new_record, $foreign_key_columns, $status);
                }
                header("Location: index.php");
            }
        }
    }
    $end_time = microtime(true);
    $_SESSION["process_time"] = number_format($end_time - $start_time, 4);
} else {
    $_SESSION["msg"] = "Aucune action spécifiée";
    $_SESSION["color"] = "red";
    header("Location: index.php");
    exit; // Ensure script stops execution after redirection
}

// Close the database connection
$conn->close();

function addRecord($conn, $table_name, $record, $foreign_key_columns, &$status) {
    $table_name == "utilisateur" ? "user" : $table_name;
    if (!is_array($record)) {
        $status = "Erreur: Données invalides pour $table_name";
        $_SESSION["msg"] = $status;
        $_SESSION["msg"] = "red";
        return;
    }

    $columns = implode(", ", array_map(function($col) { return "`$col`"; }, array_keys($record)));
    $placeholders = implode(", ", array_fill(0, count($record), "?"));
    $insert_sql = "INSERT INTO $table_name ($columns) VALUES ($placeholders)";

    $stmt = $conn->prepare($insert_sql);
    if ($stmt) {
        $types = str_repeat('s', count($record));
        $stmt->bind_param($types, ...array_values($record));
        if ($stmt->execute()) {
            $status = "Données inserées avec succès à $table_name";
            $_SESSION["msg"] = $status;
            $_SESSION["color"] = "green";
        } else {
            $status = "Erreur d'insertion des données à $table_name: " . $stmt->error;
            $_SESSION["msg"] = $status;
            $_SESSION["color"] = "red";
        }
        $stmt->close();
    } else {
        $status = "Erreur de preparation de données pour $table_name: " . $conn->error;
        $_SESSION["msg"] = $status;
        $_SESSION["color"] = "red";
    }
}

$_SESSION["msg"] = $status;
//echo $status;
?>
<?php if (isset($_SESSION["msg"])): ?>
    <div class="msg-cont" style="background-color: <?php echo $_SESSION["color"]; ?>;">
        <p class="msg" style="color: white;"><?php echo $_SESSION["msg"]; ?></p>
    </div>
<?php endif; ?>


