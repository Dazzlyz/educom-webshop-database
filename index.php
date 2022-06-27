<?php
session_start();
echo '<!DOCTYPE html>';
require 'main_functions.php';

showPage(validateRequest($request = getRequest()));
?>