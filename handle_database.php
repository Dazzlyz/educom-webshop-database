 <?php
// Exceptions voor nieuwe database functies goed bewaken! 
// Kijken naar hoe data naar elkaar relateerd, User ID's gebruiken in andere tabellen, e.g. order per user ID
function connectDatabase()
{
    $servername = "127.0.0.1";
    $username = "WebShopUser";
    $password = "Hallo";
    $dbname = "menno_webshop";
    $conn = mysqli_connect($servername, $username, $password, $dbname);

    if (!$conn) 
    {
        throw new Exception('Database connection error, please try again');
    }
    return $conn;
}

function checkMailEntries($email)
{	    
    $conn = connectDatabase();	
    $checked_email =  mysqli_real_escape_string($conn, $email);
    
    $sql = 'SELECT mail from users WHERE mail="'.$checked_email.'"';
    $result = mysqli_query($conn, $sql);
    
    checkQuery($conn, $sql, 'Error getting mail from database, please try again');        
    mysqli_close($conn);    
    return (mysqli_num_rows($result) > 0) ? true : false;   
}	

function insertData($email, $name, $password)
{	
    $conn = connectDatabase();
    $checked_email =  mysqli_real_escape_string($conn, $email);
    $checked_name = mysqli_real_escape_string($conn, $name);
    $checked_password = mysqli_real_escape_string($conn, $password);
    
    $sql = 'INSERT INTO users(mail, name, password)	
    VALUES ("'.$checked_email.'", "'.$checked_name.'" , "'.$checked_password.'")';
    
    checkQuery($conn, $sql, 'Error entering new user');    
    mysqli_close($conn);
}

function updatePassword($new_password, $current_email)
{	
    $conn = connectDatabase();
    $checked_password = mysqli_real_escape_string($conn, $new_password);
    $checked_email =  mysqli_real_escape_string($conn, $current_email);
    
    $sql = 'UPDATE users SET password="'.$checked_password.'" WHERE mail="'.$checked_email.'"';
    
    checkQuery($conn, $sql, 'Error entering new password');    
    mysqli_close($conn);	
}

function getUserDataFromDb($email) 
{	
    $conn = connectDatabase();
    $checked_email =  mysqli_real_escape_string($conn, $email);
    
    $sql = 'SELECT mail, name, password FROM users WHERE mail ="'.$checked_email.'"';
    $result = mysqli_query($conn, $sql);	
    
    checkQuery($conn, $sql, 'Error no entry found for this account, please try again');    
    if($row = mysqli_fetch_assoc($result)) 
    {
        mysqli_close($conn);
        return $row;	
    }	
}

function getAllProductInfo()
{	
    $conn = connectDatabase();
    
    $sql = "SELECT id, name, price, filename FROM products";
    $result = mysqli_query($conn, $sql);
    
    checkQuery($conn, $sql, 'Error loading products, please refresh page');    
    $complete_array = array();
    while($row = $result->fetch_assoc()) 
    {
        $complete_array[] = $row;		
    }
    mysqli_close($conn);
    return $complete_array;
}

function getProductFromId($id)
{
    $conn = connectDatabase();
    $sql = 'SELECT * from products WHERE id="'.$id.'"';
    $result = mysqli_query($conn, $sql);

    checkQuery($conn, $sql, 'Error loading product details, please refresh page or try another product'); 
    if($row = $result->fetch_assoc()) 
    {
        mysqli_close($conn);	
        return $row;	
    }	  
}

function checkQuery($conn, $sql, $err_msg)
{
    if (!mysqli_query($conn, $sql)) 
    {
        throw new Exception($err_msg);
    }
}

function addOrder()
{		
    $conn = connectDatabase();	   
    $checked_mail = mysqli_real_escape_string($conn, $_SESSION['email']);   
    $checked_name = mysqli_real_escape_string($conn, $_SESSION['username']);

    foreach($_SESSION['shoppingcart'] as $fruit => $values)
    {
        if ($values['quantity'] > 0)
        {
            $names .= $fruit . $values['quantity'];
        }
    }

    $sql = 'INSERT INTO orders(product, customer_name, user)          
    VALUES("'.$names.'", "'.$checked_name.'" , "'.$checked_mail.'")';
    checkQuery($conn, $sql, 'Error entering order please try again');   
    
    
    mysqli_close($conn);
}	
?> 



