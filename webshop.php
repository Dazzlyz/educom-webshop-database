<?php
function showWebshop()
{
    $product_array = getAllProducts();
    // per product 1 array dus 0,1,2,3,4 en per array vier keys, id , name, price, filename
    echo ' id:'.$product_array['0']['id'].' Product:'.$product_array['0']['name'].'<img src="images/'.$product_array['0']['filename'].'" width="50" height="50"> Price: '.$product_array['0']['price'].' Euro<br>';

    echo ' id:'.$product_array['1']['id'].' Product:'.$product_array['1']['name'].'<img src="images/'.$product_array['1']['filename'].'" width="50" height="50"> Price: '.$product_array['1']['price'].' Euro<br>';
    
    echo ' id:'.$product_array['2']['id'].' Product:'.$product_array['2']['name'].'<img src="images/'.$product_array['2']['filename'].'" width="50" height="50"> Price: '.$product_array['2']['price'].' Euro<br>';
    
    echo ' id:'.$product_array['3']['id'].' Product:'.$product_array['3']['name'].'<img src="images/'.$product_array['3']['filename'].'" width="50" height="50"> Price: '.$product_array['3']['price'].' Euro<br>';
    
    echo ' id:'.$product_array['4']['id'].' Product:'.$product_array['4']['name'].'<img src="images/'.$product_array['4']['filename'].'" width="50" height="50"> Price: '.$product_array['4']['price'].' Euro<br>';
}

?>