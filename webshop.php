<?php
// 02-C: Opdracht 3.2 optineel nog toevoegen? (op shoppingcart pagina increment optie bieden)

// add to cart triggert hier altijd op 'page = orange'?
// niet goed gelinkt aan dat product, pakt laatste op de pagina
// nog fixen dat add to cart ook op hoofd pagina webshop kan
function showWebshop()
{       
    $product_array = getAllProductInfo();    
        
    foreach ($product_array as $product)
    {
        echo '<form method="post" action="index.php">
        <br>id:'.$product['id'].' Product:'.$product['name'].'
        <a href="index.php?page='.$product['name'].'">
        <img src="images/'.$product['filename'].'" width="50" height="50"> </a>       
        Price: '.$product['price'].' Euro'; 
        if (getArrayVar($_SESSION, 'username', ''))
        {
            echo '<input type="hidden" name="page" value="'.$product['name'].'" />
            <input type="hidden" name="price" value="'.$product['price'].'" />
            <button type="submit" name="add_to_cart">Toevoegen aan winkelwagen</button><br>';    
        }
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
        echo '<form method="post" action="index.php">
        <br>Product:'.$product['name'].' 
        <img src="images/'.$product['filename'].'" width="200" height="200"><br>
        Description: '.$product['description'].'
        Price: '.$product['price'].' Euro <br>';  
        if (getArrayVar($_SESSION, 'username', ''))
        {
            echo '<input type="hidden" name="page" value="'.$product['name'].'" />
            <input type="hidden" name="price" value="'.$product['price'].'" />
            <input type="submit" name="add_to_cart" value="Toevoegen aan winkelwagen" />';           
        }       
    }   
}  

function addToCart($product)
{   
    
    return array($product['page'] => array ('price' => $product['price'], 'quantity' => 1));     
}

function showCart()
{    
    if (!empty($_SESSION['shoppingcart']))    
    {   
        $total = 0;
        foreach ($_SESSION['shoppingcart'] as $fruit => $values)
        {
            if ($values['quantity'] > 0)
            {
                $product_price = $values['price'] * $values['quantity'];
                echo $fruit . ' selected: ' . $values['quantity'] . ' Price: '.  $product_price .'                 
                <br>'; // enter button of increase / decrease optie voor deze line break
                $total +=  $product_price;
            }
        }
        echo 'Total price: '.$total.' Euro';
        echo '<a href="index.php?page=afrekenen">
        <p>Afrekenen</p>
        </a>
        <a href="index.php?page=cleancart">
        <p>Start over</p>
        </a>';
       
    }
    else
    {
        echo 'Shopping Cart is empty, go to the webshop to add some items!';
    }    
}
?>