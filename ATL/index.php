<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, minimum-scale=1">
    <title>Insertion de Données (normal)</title>
    <link rel="icon" href="alomrane.png">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer">
</head>
<body>
    <?php include 'login.php'; ?>
    <div class="back-cont">
        <div class="back">
            <div>Vérifiez votre fichier CSV pour choisir un séparateur !</div>
        </div>
        <a href="../empty-actifs.xlsx">
            <div class="back">télécharger fichier vide actifs.xlsx</div>
        </a>
        <div class="back">
            <div>Base de données: <?php echo $_SESSION["db"]; ?></div>
        </div>
        <div class="back">
            <div>Host: <?php echo $_SESSION["host"]; ?></div>
        </div>
    </div>

    <?php session_start(); if(isset($_SESSION["msg"])): ?>
        <div class="msg-cont">
            <div class="msg" style="background-color: <?php echo $_SESSION["color"]; ?>;">
                <p style="color: white;"><?php echo $_SESSION["msg"]; ?></p>
                <div class="xmark"> <i class="fa-solid fa-xmark" style="color: #ffffff; font-size:large;"></i> </div>
            </div>
        </div>
        <?php unset($_SESSION["msg"]); ?>
    <?php endif ?>
    <div class='msg-cont' style='display:block;'><p class='msg' style='color: white;'></p></div>

    <form class="upload-form index-upload-form" action="upload.php" method="post" enctype="multipart/form-data">
        <h1>Formulaire de Téléversement</h1>
        <label for="files"><i class="fa-solid fa-folder-open fa-2x"></i> Sélectionner des fichiers...</label>
        <input id="files" type="file" name="files[]">
        
        <!-- Dropdown with Dynamic Label -->
        <div class="dropdown-container">
            <label id="separator-label" class="dropdown-label" for="separator">Votre séparateur CSV actuel: Point-virgule (;)</label>
            <select id="separator" name="separator" onchange="updateLabel()">
                <option value="semicolon" selected>Point-virgule (;)</option>
                <option value="comma">Virgule (,)</option>
            </select>
        </div>

        <div class="progress"></div>
        <button class="upload" type="submit">Téléverser</button>
    </form>

    <script src="index.js"></script>

    <?php session_destroy(); ?>
</body>
</html>
