<?php
session_start();
$start_time = microtime(true);

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Get the selected separator
    $separator = $_POST['separator'] == 'comma' ? ',' : ';';
    $_SESSION["sep"] = $separator;
}

if (isset($_FILES['files']) && !empty($_FILES['files']['name'][0])) {
    $upload_destination = '../uploads/';
    $uploaded_files = [];
    $file_names = [];
    $allowed_extensions = ['csv','xlsx'];

    

    foreach ($_FILES['files']['tmp_name'] as $key => $tmp_name) {
        $file_name = basename($_FILES['files']['name'][$key]);
        $file_path = $upload_destination . $file_name;
        $file_extension = pathinfo($file_name, PATHINFO_EXTENSION);
        $file_base_name = pathinfo($file_name, PATHINFO_FILENAME);

        // Check if the file name is "ectifs"
        if ($file_base_name !== 'actifs') {
            $_SESSION["msg"] = "Vous avez le droit de téléverser uniquement les actifs !";
            $_SESSION["color"] = "red";
            header("Location: index.php");
            exit;
        }


        if (in_array($file_extension, $allowed_extensions)) {
            if (file_exists($file_path)) {
                $backup_name = $upload_destination . pathinfo($file_name, PATHINFO_FILENAME) . '-' . date('Y-m-d_H-i-s') . '-backup.' . $file_extension;
                if (rename($file_path, $backup_name)) {
                    $_SESSION["msg"] = "Renaming existing file done " . $file_name;
                    $_SESSION["color"] = "green";
                }
            }

            if (move_uploaded_file($tmp_name, $file_path)) {
                $uploaded_files[] = $file_path;
                $file_names[] = $file_name;
                $_SESSION["msg"] = "Fichier(s) téléchargé(s) avec succès";
                $_SESSION["color"] = "green";
            } else {
                $_SESSION["msg"] = "Erreur lors du téléchargement du fichier " . $file_name;
                $_SESSION["color"] = "red";
                exit;
            }
        } else {
            $_SESSION["msg"] = "Type de fichier invalide pour " . $file_name . "... Seuls les fichiers csv ou excel sont autorisés !";
            $_SESSION["color"] = "red";
            header("Location: index.php");
        }
    }

    function cleanCSVData($data) {
        return trim(preg_replace("/\r\n|\r|\n/", " ", $data));
    }

    function replaceNewlinesInCSV($inputFile, $separator) {
        $tempFile = tempnam(sys_get_temp_dir(), 'csv');

        if (($inputHandle = fopen($inputFile, "r")) !== FALSE && ($tempHandle = fopen($tempFile, "w")) !== FALSE) {
            while (($row = fgetcsv($inputHandle, 0, $separator)) !== FALSE) {
                $row = array_map('cleanCSVData', $row);
                fputcsv($tempHandle, $row, $separator);
            }
            fclose($inputHandle);
            fclose($tempHandle);

            if (copy($tempFile, $inputFile)) {
                unlink($tempFile);
            }
        }
    }

    function xlsxToCsv($inputFilePath, $outputFilePath, $separator) {
        $zip = new ZipArchive;
        if ($zip->open($inputFilePath) === TRUE) {
            // Extract XLSX to a temporary directory
            $extractDir = sys_get_temp_dir() . '/xlsx_extract_' . uniqid();
            $zip->extractTo($extractDir);
            $zip->close();
    
            $sheetData = simplexml_load_file($extractDir . '/xl/worksheets/sheet1.xml');
            $sharedStrings = simplexml_load_file($extractDir . '/xl/sharedStrings.xml');
            $sharedStringIndex = [];
            
            foreach ($sharedStrings->si as $index => $value) {
                $sharedStringIndex[] = (string)$value->t;
            }
    
            $csvData = [];
            foreach ($sheetData->sheetData->row as $row) {
                $rowData = [];
                $maxColumn = 0;
                foreach ($row->c as $cell) {
                    $cellValue = (string)$cell->v;
                    $cellType = (string)$cell['t'];
    
                    if ($cellType === 's') { // Shared string
                        $cellValue = $sharedStringIndex[$cellValue];
                    }
    
                    $cellReference = (string)$cell['r'];
                    $columnIndex = preg_replace('/[0-9]/', '', $cellReference);
                    $columnNumber = columnLetterToNumber($columnIndex) - 1;
    
                    // Fill empty cells
                    while (count($rowData) < $columnNumber) {
                        $rowData[] = '';
                    }
    
                    $rowData[] = $cellValue;
                    $maxColumn = max($maxColumn, $columnNumber);
                }
    
                // Ensure the row data has enough columns
                while (count($rowData) <= $maxColumn) {
                    $rowData[] = '';
                }
    
                $csvData[] = $rowData;
            }
    
            // Write CSV data to file
            $fp = fopen($outputFilePath, 'w');
            foreach ($csvData as $row) {
                fputcsv($fp, $row, $separator);
            }
            fclose($fp);
    
            // Clean up temporary files
            array_map('unlink', glob("$extractDir/*.*"));
            rmdir($extractDir);
    
            return $outputFilePath;
        } else {
            $_SESSION["msg"] = "Échec de l'ouverture du fichier XLSX.";
            $_SESSION["color"] = "red";
            return false;
        }
    }
    
    function columnLetterToNumber($columnLetter) {
        $length = strlen($columnLetter);
        $number = 0;
        for ($i = 0; $i < $length; $i++) {
            $number = $number * 26 + (ord($columnLetter[$i]) - ord('A') + 1);
        }
        return $number;
    }
    
    
    // Function to convert Excel date serial number to timestamp
    function convertExcelDate($excelDate) {
        $unixTimestamp = ($excelDate - 25569) * 86400; // Convert to Unix timestamp
        return $unixTimestamp;
    }
    
    // Function to determine if a cell style represents a date
    function isDateStyle($styleIndex, $zip) {
        // Load the styles.xml file to determine if the style is a date format
        $stylesFileName = 'xl/styles.xml';
        if ($zip->locateName($stylesFileName) !== false) {
            $xmlStyles = simplexml_load_string($zip->getFromName($stylesFileName));
            $cellXfs = $xmlStyles->cellXfs->xf;
    
            if (isset($cellXfs[$styleIndex])) {
                $numFmtId = (int) $cellXfs[$styleIndex]['numFmtId'];
    
                // Common date format IDs in Excel
                $dateFormats = [
                    14, 15, 16, 17, 18, 19, 20, 21, 22, 27, 30, 36, 45, 46, 47, 50, 57, 58, 
                    165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176
                ];
    
                if (in_array($numFmtId, $dateFormats)) {
                    return true;
                }
            }
        }
        return false;
    }
    
    
    

    if (!empty($uploaded_files)) {
        include("login.php");
        try {
            $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            $new_records = [];
            $same_records = [];

            $table_names = [];

            $stmt = $conn->query("SHOW TABLES");
            while ($row = $stmt->fetch(PDO::FETCH_NUM)) {
                $table_names[] = $row[0];
            }

            foreach ($uploaded_files as $inputFile) {
                $file_extension = pathinfo($inputFile, PATHINFO_EXTENSION);
                $table_name = pathinfo($inputFile, PATHINFO_FILENAME);
                $file_base_name = pathinfo($table_name, PATHINFO_FILENAME);

                if (!in_array($file_base_name, $table_names)) {
                    throw new Exception("Fichier $file_base_name n'existe pas");
                }
                if ($file_extension === 'xlsx') {
                    $outputCsv = $upload_destination . $table_name . '.csv';
                    xlsxToCsv($inputFile, $outputCsv, $separator);
                    $inputFile = $outputCsv; // Update to use the converted CSV file
                }

                replaceNewlinesInCSV($inputFile, $separator);

                if (in_array($file_extension, ['csv', 'xlsx']) && in_array($table_name, ['actifs', 'projet'])) {
                    $outputFile = $inputFile;
                    $sqlTableColumns = getSqlTableColumns($table_name, $conn);
                    $corresponding_columns = [
                        "actifs" => [
                            "latitude" => "lat_2", "index" => "index", "level_0" => "level_0", "longitude" => "lon_2",
                            "type" => "type_actif", "transaction" => "transaction", "enquete" => "enquete", "evaluation" => "evaluation",
                            "date" => "date_eval_contrat", "price" => "valeur_global", "titreFoncier" => "num_tf_req",
                            "surface" => "surface", "orientation" => "orientation", "composition" => "desc_1", "destination" => "destination",
                            "unitPrice" => "pu", "desc_age" => "desc_age", "age" => "age", "parking" => "parking", "ascenseur" => "ascenseur", "residenceType" => "residenceType",
                            "elevation" => "elevation", "villaType" => "villaType", "standing" => "standing", "operation" => "operation", "ville" => "ville"
                        ],
                        "projet" => [
                            "id" => "id", "longitude" => "longitude", "latitude" => "latitude", "nombre" => "nombre",
                            "superficieMoyenne" => "superficieMoyenne", "prixMoyen" => "prixMoyen", "Societe_id" => "Societe_id",
                            "nomProjet" => "nomProjet", "typeProjet" => "typeProjet", "Quartier" => "", "Ville" => "",
                            "Representant" => "", "Standing" => ""
                        ]
                    ];

                    replaceData($inputFile, $outputFile, $sqlTableColumns, $corresponding_columns[$table_name], $table_name, $separator);
                    processCSVFile($inputFile, $table_name, $conn, $new_records, $same_records, $separator);
                } else {
                    processCSVFile($inputFile, $table_name, $conn, $new_records, $same_records, $separator);
                }
            }

            $_SESSION['new_records'] = $new_records;
            $_SESSION['same_records'] = $same_records;

            $end_time = microtime(true);
            $_SESSION["upload_time"] = number_format($end_time - $start_time, 4);
            $conn = null;
            header("Location: results.php");
            exit;

        } catch (PDOException $e) {
            $_SESSION["msg"] = "Erreur de la base de donnée: " . $e->getMessage();
            $_SESSION["color"] = "red";
            header("Location: index.php");
        }
    }
} else {
    $_SESSION["msg"] = 'Veuillez choisir un fichier';
    $_SESSION["color"] = "red";
    header("Location: index.php");
}

function processCSVFile($inputFile, $table_name, $conn, &$new_records, &$same_records, $separator) {
    if (($csv_handle = fopen($inputFile, "r")) !== FALSE) {
        $columns = fgetcsv($csv_handle, 1000, $separator);

        if ($columns !== FALSE) {
            if ($table_name == "actifs") array_shift($columns);
        } else {
            fclose($csv_handle);
            $_SESSION["msg"] = "fichier vide ou invalide: $inputFile";
            $_SESSION["color"] = "red";
            return;
        }

        $stmt_select = $conn->prepare("SELECT * FROM `$table_name` WHERE " . implode(" AND ", array_map(fn($col) => "`$col` = :$col", $columns)));

        while (($data = fgetcsv($csv_handle, 1000, $separator)) !== FALSE) {
            if (empty($data)) continue;
            if ($table_name == "actifs") array_shift($data);

            $row_data = array_combine($columns, $data);
            $params = array_combine(array_map(fn($col) => ":$col", $columns), $data);

            $stmt_select->execute($params);
            $result = $stmt_select->fetch(PDO::FETCH_ASSOC);

            if ($result) {
                if ($table_name == "actifs") unset($result['level_0'], $row_data['level_0']);
                if (arraysAreEqual($result, $row_data)) {
                    $same_records[$table_name][] = $row_data;
                }
            } else {
                $new_records[$table_name][] = $row_data;
            }
        }

        fclose($csv_handle);
    } else {
        $_SESSION["msg"] = "Echec d'ouverture du fichier: $inputFile";
        $_SESSION["color"] = "red";
    header(("Location: index.php"));
    }
}

function arraysAreEqual($array1, $array2) {
    return $array1 == $array2;
}

function getSqlTableColumns($tableName, $conn) {
    $stmt = $conn->prepare("SHOW COLUMNS FROM `$tableName`");
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_COLUMN);
}

function replaceData($inputFile, $outputFile, $sqlTableColumns, $corresponding_columns, $table_name, $separator) {

    $csv = array_map(fn($row) => str_getcsv($row, $separator), file($inputFile));

    $headers = $csv[0];
    $filtered_csv = [];

    $mapped_headers = array_map(fn($sqlCol) => array_search($sqlCol, $corresponding_columns), $sqlTableColumns);
    $filtered_csv[] = $sqlTableColumns;

    foreach (array_slice($csv, 1) as $row) {
        // Check if the row has the expected number of columns
        if (count($row) < count($headers)) {
            // Fill in missing columns with empty values
            $row = array_pad($row, count($headers), '');
        }

        $filtered_row = array_map(fn($header) => ($header !== false) ? (isset($row[array_search($header, $headers)]) ? $row[array_search($header, $headers)] : '') : '', $mapped_headers);
        $filtered_csv[] = $filtered_row;
    }
    
    /********************************************************************************/
    /********************************************************************************/
    /********************************************************************************/
    /********************************************************************************/
    /********************************************************************************/
                ////////////////////////////////////////////////////////////
                //                                                        //
                //                       CLEANING                         //
                //                                                        //
                ////////////////////////////////////////////////////////////

    $type_actifColumnIndex = array_search("type_actif", $sqlTableColumns);
    $referenceColumnIndex = array_search("reference", $sqlTableColumns);
    $date_eval_contratColumnIndex = array_search("date_eval_contrat", $sqlTableColumns);
    $surfaceColumnIndex = array_search("surface", $sqlTableColumns);
    $puColumnIndex = array_search("pu", $sqlTableColumns);
    $valeur_globalColumnIndex = array_search("valeur_global", $sqlTableColumns);
    $lon_2ColumnIndex = array_search("lon_2", $sqlTableColumns);
    $lat_2ColumnIndex = array_search("lat_2", $sqlTableColumns);

    $modified_records = [];

    foreach ($filtered_csv as &$row) {
        // Check if the indices exist before accessing them
        if (isset($row[$referenceColumnIndex]) && empty($row[$referenceColumnIndex])) {
            $row[$referenceColumnIndex] = '0';
        }

        if (isset($row[$type_actifColumnIndex])) {
            $row[$type_actifColumnIndex] = str_replace(['Appartement', 'Bureau', 'Villa', 'Terrain', 'Maison', 'Commerce'], ['APPT', 'BURE', 'VILL', 'TERR', 'MAIS', 'COMM'], $row[$type_actifColumnIndex]);
        }

        if (isset($row[$valeur_globalColumnIndex])) {
            $row[$valeur_globalColumnIndex] = str_ireplace(['.'], '', $row[$valeur_globalColumnIndex]);
        }

        if (isset($row[$date_eval_contratColumnIndex]) && is_numeric($row[$date_eval_contratColumnIndex])) {
            // Convert Excel date serial number to Unix timestamp
            $timestamp = ($row[$date_eval_contratColumnIndex] - 25569) * 86400;

            // Create DateTime object from the timestamp in UTC
            $dateTime = (new DateTime('@' . $timestamp))->setTimezone(new DateTimeZone('UTC'));
            
            // Format the date and time as 'Y-m-d H:i:s'
            $row[$date_eval_contratColumnIndex] = $dateTime->format('Y-m-d H:i:s');
        } elseif (isset($row[$date_eval_contratColumnIndex]) && empty($row[$date_eval_contratColumnIndex])) {
            $row[$date_eval_contratColumnIndex] = '0000-00-00 00:00:00'; // Handle empty dates as empty strings or set a default date if desired
        }
    }

    $old_filtered_csv = $filtered_csv;

    array_shift($filtered_csv);

    // Deep copy the array to ensure no reference issues
    $filtered_csv_copy = array_map(function($row) {
        return array_slice($row, 0);
    }, $filtered_csv);

    foreach ($filtered_csv_copy as &$row) {
        // Check if indices exist before accessing them
        if (isset($row[$surfaceColumnIndex])) {
            $row[$surfaceColumnIndex] = str_ireplace(['m²', 'm2', ' '], ['', '', ''], $row[$surfaceColumnIndex]);
            $row[$surfaceColumnIndex] = preg_replace('/,0*/', '', $row[$surfaceColumnIndex]);
        }
        if (isset($row[$puColumnIndex]) && is_string($row[$puColumnIndex])) {
            // Remove specific unwanted substrings and spaces
            $row[$puColumnIndex] = str_ireplace(['Dh/m²', ' '], ['', ''], $row[$puColumnIndex]);
            
            // Replace non-breaking spaces with regular spaces and then remove them
            $row[$puColumnIndex] = str_replace("\u{A0}", '', $row[$puColumnIndex]);

            // Remove any remaining commas and letters
            $row[$puColumnIndex] = preg_replace(['/,[0-9]+/', '/\b[a-zA-Z]\b/'], ['', ''], $row[$puColumnIndex]);

            // Optional: Convert to a float if needed
            $row[$puColumnIndex] = (float) $row[$puColumnIndex];
        }
        if (isset($row[$valeur_globalColumnIndex])) {
            $row[$valeur_globalColumnIndex] = str_ireplace(' ', '', $row[$valeur_globalColumnIndex]);
            $row[$valeur_globalColumnIndex] = preg_replace(['/\b[a-zA-Z]\b|[^0-9]+/'], '0', $row[$valeur_globalColumnIndex]);
        }
        if (isset($row[$lon_2ColumnIndex])) {
            $row[$lon_2ColumnIndex] = preg_replace('/;|,/', '.', $row[$lon_2ColumnIndex]);
        }
        if (isset($row[$lat_2ColumnIndex])) {
            $row[$lat_2ColumnIndex] = preg_replace('/;|,/', '.', $row[$lat_2ColumnIndex]);
        }
    }

    array_unshift($filtered_csv_copy, $sqlTableColumns);

    $modified_records = [];
    $old_records = [];
    $headers = $filtered_csv_copy[0]; // Assuming this is the header row from your CSV

    // Process old records
    foreach (array_slice($old_filtered_csv, 1) as $old_row) {
        $old_row_assoc = array_combine($headers, $old_row);
        $old_records[] = $old_row_assoc;
    }

    // Process modified records
    foreach (array_slice($filtered_csv_copy, 1) as $key => &$new_row) {
        $new_row = array_combine($headers, $new_row);
        $old_filtered_csv[$key + 1] = array_combine($headers, $old_filtered_csv[$key + 1]);

        if (!arraysAreEqual($old_filtered_csv[$key + 1], $new_row)) { // Adjust for header offset
            $modified_records[$table_name][] = $old_filtered_csv[$key + 1];
        }
    }

    // Print the old and modified records for debugging
    $_SESSION['modified_records'] = $modified_records;

    $fp = fopen($outputFile, 'w');
    foreach ($filtered_csv_copy as &$row) {
        fputcsv($fp, $row, $separator);
    }

    fclose($fp);
}

?>
