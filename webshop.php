<?php
// input submit onderaan op de juiste plek weergeven

function showWebshop()
{    
    $product_array = getAllProductInfo();
    foreach ($product_array as $product)
    {
        echo ' id:'.$product['id'].' Product:'.$product['name'].'
        <a href="index.php?page='.$product['name'].'">
        <img src="images/'.$product['filename'].'" width="50" height="50">
        </a>
        Price: '.$product['price'].' Euro <br>'.showAddToCart(getArrayVar($_SESSION, 'username', ''), $product).''; 
    }         
}

function showDetail($page)
{    
    $product = getProductDetails($page);
    if (empty($product))
    {
        echo '0 results';
    }
    else
    {
        echo 'Product:'.$product['name'].' <br>
        <img src="images/'.$product['filename'].'" width="200" height="200"><br>
        Description: '.$product['description'].' <br>
        Price: '.$product['price'].' Euro <br>
        <form method="post" action="index.php">
        '.showAddToCart(getArrayVar($_SESSION, 'username', ''), $product).'';
    }   
}  

function showAddToCart($username= '', $product)
{
    if ($username)
    {
        echo '<input type="hidden" name="page" value="'.$product['name'].'" />
        <input type="hidden" name="price" value="'.$product['price'].'" />
        <input type="submit" name="add_to_cart" value="Toevoegen aan winkelwagen" />';   
    }
    
}

function addToCart($product)
{   
    return array('name' => $product['page'], 'price' => $product['price']);     
}

function showCart()
{   
    echo 'WORK IN PROGRESS';
}
?>