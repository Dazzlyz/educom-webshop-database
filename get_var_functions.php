<?php

function getArrayVar($array, $key, $default='') 
{ 
   return isset($array[$key]) ? $array[$key] : $default; 
} 

function getPostVar($key, $default='') 
{ 
    return getArrayVar($_POST, $key, $default);
}

function getUrlVar($key, $default='') 
{ 
	return getArrayVar($_GET, $key, $default);
} 
?>