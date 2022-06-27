<?php
session_start();
echo '<!DOCTYPE html>';
require 'main_functions.php';

// Hier ook kijken voor correct meegeven van $request
showPage(
    validateRequest(
        $request = getRequest()
    ));
?>