<?php
session_start();

// Vérifiez si new_records et same_records sont définis dans la session
if (!isset($_SESSION['new_records']) || !isset($_SESSION['same_records'])) {
    $_SESSION["msg"] = "Aucune donnée à afficher";
    $_SESSION["color"] = "red";
    header("Location: index.php");
}

$new_records = $_SESSION['new_records'];
$same_records = $_SESSION['same_records'];

if(isset($_SESSION['modified_records'])){
    $modified_records = $_SESSION['modified_records']; 
}

if (!isset($_SESSION["track"])) {
    $_SESSION["track"] = [];
}

function generateUniqueNumber(&$array) {
    $number = 0;
    while (in_array(++$number, $array));
    $array[] = $number;
    return $number;
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Résultat d'importation</title>
    <link rel="icon" href="alomrane.png">
    <link rel="stylesheet" href="style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="results.js"></script>
</head>
<body>
    <div id="response"></div>
    <div class="loader-wrapper">
        <span class="loader"><span class="loader-inner"></span></span>
    </div>

    <div class="back-cont">
        <a href="index.php"><div class="back">Précédent</div></a>
        <a href="#new_records"><div class="back">Nouvelles données</div></a>
        <a href="#same_records"><div class="back">Mêmes données</div></a>
        <a href="#modified_records"><div class="back">données modifiées</div></a>
        <a href="../empty-actifs.xlsx">
            <div class="back">Télécharger empty actifs.xlsx</div>
        </a>
    </div>
    <div class="result upload-form">
        <h1>Résultats de l'importation des fichiers</h1>
        <?php $start_time = microtime(true); ?>
        <!-- Afficher les enregistrements modifiés avec des actions individuelles -->

        <?php if (!empty($modified_records)): ?>          
            <?php
                foreach ($modified_records as $table_name => $records): ?>
                <div id="modified_records" class="table-container">
                    <h1 class="sticky-header" style="color: red; font-weight:bold; ">VÉRIFIEZ À NOUVEAU LES ENREGISTREMENTS CI-DESSOUS (<?php echo count($records); ?>)</h1>
                    <h3>Table : <?php echo $table_name; ?></h3>
                    <table id="mod">
                        <thead>
                            <tr>
                                <?php foreach (array_keys($records[0]) as $column): ?>
                                    <th><?php echo $column; ?></th>
                                <?php endforeach; ?>
                            </tr>
                        </thead>
                        <tbody>
                            <?php $countM = 0; foreach ($records as $index => $record): $countM++; ?>
                                <tr>
                                    <?php $tracker = 0; foreach ($record as $value): ?>
                                        <td id="<?php echo "T".$tracker; ?>"><?php echo htmlspecialchars($value); $tracker++; ?></td>
                                    <?php endforeach; $tracker = 0; ?>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            <?php endforeach; ?>
            <?php else: ?>
                <p>Tout semble propre</p>
                <?php $countM = 0; ?>
        <?php endif; ?>

        <form id="new_records" action="process.php" method="post">
            <?php foreach ($new_records as $table_name => $records): ?>
                <h3 id="<?php echo $table_name; ?>">Options pour la table : <?php echo $table_name; ?></h3>
                <input type="hidden" name="same_records[<?php echo $table_name; ?>]" value="<?php echo htmlentities(serialize($same_records[$table_name] ?? [])); ?>">
                <div class="action">
                    <button type="submit" class="addButton addAll" id="add_all_<?php echo $table_name; ?>" name="action[<?php echo $table_name; ?>]" value="add_all">Ajouter tout</button>
                    <input type="hidden" name="new_records[<?php echo $table_name; ?>]" value="<?php echo htmlentities(serialize($records)); ?>">
                </div>
            <?php endforeach; ?>
        </form>
        <!-- Afficher les nouvelles données avec des actions individuelles -->
        <?php if (!empty($new_records)): ?>
            <?php foreach ($new_records as $table_name => $records): ?>
                <div class="table-container">
                    <h1 class="sticky-header" style="color: red; font-weight:bold; ">Nouvelles données (<?php echo count($records); ?>)</h1>
                    <form method="post" class="record-form">
                        <h3>Table : <?php echo $table_name; ?></h3>
                        <table>
                            <thead>
                                <tr>
                                    <?php foreach (array_keys($records[0]) as $column): ?>
                                        <th><?php echo $column; ?></th>
                                    <?php endforeach; ?>
                                    <th class="sticky-column">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php $countN = 0; foreach ($records as $index => $record): $countN++; ?>
                                    <tr>
                                        <?php foreach ($record as $value): ?>
                                            <td><?php echo htmlspecialchars($value); ?></td>
                                        <?php endforeach; ?>
                                        <td class="sticky-column">
                                            <button type="submit" id="<?php echo "Button" . generateUniqueNumber($_SESSION["track"]); ?>" class="addButton" name="action[<?php echo $table_name; ?>][<?php echo $index; ?>]" value="add">Ajouter</button>
                                            <input type="hidden" name="new_records[<?php echo $table_name; ?>][<?php echo $index; ?>]" value="<?php echo htmlentities(serialize($record)); ?>">
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </form>
                </div>
            <?php endforeach; ?>
            <?php else: ?>
                <p>Aucune nouvelle donnée trouvée.</p>
                <?php $countN = 0; ?>
        <?php endif; ?>

        <!-- Afficher les mêmes enregistrements -->
        <?php if (!empty($same_records)): ?>
            <?php foreach ($same_records as $table_name => $records): ?>
                <div id="same_records" class="table-container">
                    <h1 class="sticky-header" style="color: red; font-weight:bold; ">Mêmes données (<?php echo count($records); ?>)</h1>
                    <h3>Table : <?php echo $table_name; ?></h3>
                    <table>
                        <thead>
                            <tr>
                                <?php foreach (array_keys($records[0]) as $column): ?>
                                    <th><?php echo $column; ?></th>
                                <?php endforeach; ?>
                            </tr>
                        </thead>
                        <tbody>
                            <?php $countS = 0; foreach ($records as $record):  $countS++; ?>
                                <tr>
                                    <?php foreach ($record as $value): ?>
                                        <td><?php echo htmlspecialchars($value); ?></td>
                                    <?php endforeach; ?>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            <?php endforeach; ?>
            <?php else: ?>
            <p>Aucune même donnée trouvée.</p>
            <?php $countS = 0; ?>
        <?php endif; ?>
    <?php unset($_SESSION["track"]); ?>
    <?php $end_time = microtime(true); ?>
    </div>
    <?php $_SESSION["results_time"] = number_format($end_time - $start_time, 4); ?>

    <div class="time">Temps de téléchargement : <?php echo $_SESSION["upload_time"] ; ?> secondes</div>
    <div class="time">Temps de résultat : <?php echo $_SESSION["results_time"] ; ?> secondes</div>
    <div class="time">Nouvelles données : <?php echo $countN; ?></div>
    <div class="time">Mêmes données : <?php echo $countS ?></div>
    <div class="time">données modifiées : <?php echo $countM; ?></div>
</body>
</html>
