<?php
// input submir toevoegen aan wagen alleen tonen bij login.
function showWebshop()
{
    $product_array = getAllProducts();
    foreach ($product_array as $product)
    {
        echo ' id:'.$product['id'].' Product:'.$product['name'].'
        <a href="index.php?page='.$product['name'].'">
        <img src="images/'.$product['filename'].'" width="50" height="50">
        </a>
        Price: '.$product['price'].' Euro <input type="submit" value="Toevoegen aan wagen"> <br>'; 
    }   
}
// zorgen in database handler dat er simpler wordt uitgelezen.
function showDetail($page)
{
    $product = getProductDetails($page);

    echo 'Product:'.$product[0]['name'].' <br>
    <img src="images/'.$product[0]['filename'].'" width="200" height="200"><br>
    Description: '.$product[0]['description'].' <br>
    Price: '.$product[0]['price'].' Euro <br>
    <form method="post" action="index.php">
    <input type="hidden" name="page" value="'.$product[0]['name'].'" />
    <input type="hidden" name="price" value="'.$product[0]['price'].'" />
        <input type="submit" name="add_to_cart" value="Toevoegen aan winkelwagen" />';    
}  

function addToCart($product)
{   
    return array('name' => $product['page'], 'price' => $product['price']);     
}

function showCart()
{   
    echo $_SESSION['shoppingcart']['name'];
}
?>