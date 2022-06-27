<?php 

 // gebruiken om eenmalig database te openen? 
 function openDatabase()
 {
     $_SESSION['conn'] = connectDatabase();	
 }

function makeCheckArray($user_data)
{
    $_SESSION['check_array'] = array('email' => $user_data['mail'], 'naam' => $user_data['naam'], 'password' => $user_data['password']);
}

function logInUser()
{
    $_SESSION['email'] = $_SESSION['check_array']['email'];
	$_SESSION['password'] = $_SESSION['check_array']['password'];	
	$_SESSION['username'] = $_SESSION['check_array']['naam'];		
}

function updateSessionPassword($new_password)
{
    $_SESSION['password'] = $new_password;
}

function logOutUser()
{
    $_SESSION['email'] = '';
	$_SESSION['password'] = '';	
    $_SESSION['username']	= '';
}








?>