<?php

function showWebshop()
{       
    $product_array = getAllProductInfo();   
        
    foreach ($product_array as $product)
    {
        echo '
        <br>id:'.$product['id'].' Product:'.$product['name'].'
        <a href="index.php?page=detail&product='.$product['name'].'&id='.$product['id'].'">
        <img src="images/'.$product['filename'].'" width="50" height="50"> </a>       
        Price: '.$product['price'].' Euro';         
        checkAddToCart($product);       
    }            
}

function showDetail($page)
{      
    $product = getProductFromId($page);
    if (empty($product))
    {
        echo '0 results';
    }
    else
    {
        echo '<form method="post" action="index.php">
        <br>Product:'.$product['name'].' 
        <img src="images/'.$product['filename'].'" width="200" height="200"><br>
        Description: '.$product['description'].'
        Price: '.$product['price'].' Euro <br>';  
        checkAddToCart($product);
    }   
}  

function checkAddToCart($product)
{
    if (getArrayVar($_SESSION, 'username', ''))
        {
            echo '<form method="post" action="index.php">
            <input type="hidden" name="page" value="'.$product['name'].'" />           
            <input type="hidden" name="price" value="'.$product['price'].'" />
            <input type="hidden" name="id" value="'.$product['id'].'" />
            <input type="submit" name="add_to_cart" value="Toevoegen aan winkelwagen" />
            </form>';           
        }
}

function addToCart($product)
{       
    $database_result = getProductFromId($product['id']);
    return array($database_result['name'] => array('price' => $database_result['price'], 'quantity' => 1));     
}

function showCart()
{  
    $total = 0;
    foreach ($_SESSION['shoppingcart'] as $fruit => $values)
    {            
        if ($values['quantity'] > 0)
        {
            $product_price = $values['price'] * $values['quantity'];
            echo $fruit . ' selected: ' . $values['quantity'] . ' Price: '.  $product_price .' 
            <form method="post" action="index.php">
            <input type="hidden" name="page" value="'.$fruit.'" />         
            <input type="submit" name="increase" value="+" /> </form> 
            <form method="post" action="index.php">
            <input type="hidden" name="page" value="'.$fruit.'" />         
            <input type="submit" name="decrease" value="-" /> </form> <br>';             
            $total +=  $product_price;
        }             
    }
    if  ($total == 0) 
    {
        echo 'Shopping Cart is empty, go to the <a href="index.php?page=webshop">webshop</a> to add some items!';
    }  
    else
    {
        echo 'Total price: '.$total.' Euro
        <a href="index.php?page=afrekenen">
        <p>Afrekenen</p>
        </a>';  
    }

    
    
}
?>