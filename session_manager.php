<?php 

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

function manageCart($post)
{
    // if (!isset($_SESSION['shoppingcard']))
    // {
    //     $_SESSION['shoppingcard'] = addToCart($post);
    // }
    // // wordt INT ?!?!?!
    // else 
    // {
    //     $push_array =  $_SESSION['shoppingcard'];
    //     $_SESSION['shoppingcard'] = array_merge($push_array, addToCart($post));    
    // }
    echo 'placeholder, functie werkt nog niet';
}

?>