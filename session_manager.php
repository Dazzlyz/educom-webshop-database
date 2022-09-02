<?php 

function makeCheckArray($user_data)
{
    $_SESSION['check_array'] = array('email' => $user_data['mail'], 'naam' => $user_data['name'], 'password' => $user_data['password'], 'id' => $user_data['id'] );
}

function logInUser()
{
    $_SESSION['email'] = $_SESSION['check_array']['email'];
	$_SESSION['password'] = $_SESSION['check_array']['password'];	
	$_SESSION['username'] = $_SESSION['check_array']['naam'];	
    $_SESSION['pid'] = $_SESSION['check_array']['id'];	
    $_SESSION['shoppingcart'] = [];       
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
    $_SESSION['pid'] = '';
    $_SESSION['shoppingcart'] = [];
}

function emptyShoppingCart()
{
    $_SESSION['shoppingcart'] = [];
}

// werkt weer, increase / decrease mooier maken later 
function manageCart($post)    
 {        
    $product = $post['page'];   
    $fruit_array = array(); 
   
    if (isset($post['decrease']) or isset($post['increase']))
    {
        if (isset($post['decrease']) and $post['decrease'] == '-')
        {        
            $_SESSION['shoppingcart'][$product]['quantity'] -= 1;  
        }    
        elseif (isset($post['increase']) and $post['increase'] == '+')
        {    
            $_SESSION['shoppingcart'][$product]['quantity'] += 1;
        }
    }
    else
    {    
        foreach($_SESSION['shoppingcart'] as $fruit => $values)
        {
            array_push($fruit_array, $fruit);
        }
        
        if (in_array($product, $fruit_array))    
        {    
            $_SESSION['shoppingcart'][$product]['quantity'] += 1;
        }
        else 
        { 
            $new_data =  addToCart($post);      
            $_SESSION['shoppingcart'] = array_merge( $_SESSION['shoppingcart'], $new_data); 
        }
    }
}

function setSessionId()
{
    $_SESSION['id'] = getUrlVar('id', 1);
}
?>