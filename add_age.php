<?php

// Define file paths
$inputFilePath = 'actifs.csv'; // Input file path
$outputFilePath = 'actifsss.csv'; // Output file path

// Open the input CSV file for reading
if (($handle = fopen($inputFilePath, 'r')) !== false) {
    // Read the header line
    $header = fgetcsv($handle);

    // Find the index of the 'desc_age' column
    $descAgeIndex = array_search('desc_age', $header);

    // Add a new 'age' column to the header
    $header[] = 'age';

    // Open the output CSV file for writing
    $outputHandle = fopen($outputFilePath, 'w');
    
    // Write the updated header to the output file
    fputcsv($outputHandle, $header);

    // Read each row and add the calculated age
    while (($row = fgetcsv($handle)) !== false) {
        $descAge = $row[$descAgeIndex];

        // Determine age based on 'desc_age'
        $age = '';
        if (stripos($descAge, 'Récent') !== false) {
            $age = 8;
        } elseif (stripos($descAge, 'neuf') !== false) {
            $age = 0;
        } elseif (stripos($descAge, 'ancien') !== false) {
            $age = 15;
        }
        else{
            $age = 0;
        }


        // Add the calculated age to the row
        $row[] = $age;

        // Write the updated row to the output file
        fputcsv($outputHandle, $row);
    }

    // Close the file handles
    fclose($handle);
    fclose($outputHandle);

    echo "CSV file updated successfully.";
} else {
    echo "Failed to open the input CSV file.";
}
