<?php

function xlsxToCsv($inputFile, $outputFile) {
    // Open the XLSX file as a ZIP archive
    $zip = new ZipArchive();
    if ($zip->open($inputFile) === TRUE) {
        // Locate the sheet1.xml file within the archive
        $sheetFileName = 'xl/worksheets/sheet1.xml';
        $sharedStringsFileName = 'xl/sharedStrings.xml';
        
        // Read the shared strings for string values
        $sharedStrings = [];
        if ($zip->locateName($sharedStringsFileName) !== false) {
            $xmlStrings = simplexml_load_string($zip->getFromName($sharedStringsFileName));
            foreach ($xmlStrings->si as $item) {
                $sharedStrings[] = (string) $item->t;
            }
        }

        // Extract the sheet data
        $xmlSheet = simplexml_load_string($zip->getFromName($sheetFileName));
        
        // Prepare to write to CSV
        $file = fopen($outputFile, 'w');

        // Parse rows and cells
        foreach ($xmlSheet->sheetData->row as $row) {
            $csvRow = [];
            foreach ($row->c as $cell) {
                // Determine cell value
                $type = (string) $cell['t'];
                if ($type === 's') {
                    // String cell
                    $value = (int) $cell->v;
                    $csvRow[] = $sharedStrings[$value];
                } else {
                    // Numeric or other cell
                    $csvRow[] = (string) $cell->v;
                }
            }
            // Write the row to the CSV
            fputcsv($file, $csvRow);
        }

        // Close the CSV file
        fclose($file);

        // Close the ZIP archive
        $zip->close();
        echo "Conversion completed successfully!";
    } else {
        echo "Failed to open the XLSX file.";
    }
}

// Usage
$inputXlsx = 'uploads/actifs.xlsx';
$outputCsv = 'uploads/actifs.csv';
xlsxToCsv($inputXlsx, $outputCsv);

?>
