 <?php

function connectDatabase()
{
	$servername = "127.0.0.1";
	$username = "WebShopUser";
	$password = "Hallo";
	$dbname = "menno_webshop";
	$conn = mysqli_connect($servername, $username, $password, $dbname);

	if (!$conn) 
	{
		die("Connection failed: " . mysqli_connect_error());
	}
	return $conn;
}

function checkMailEntries($user_data)
{	
	$conn = connectDatabase();	
	$sql = 'SELECT mail from users WHERE mail="'.$user_data['mail'].'"';
	$result = mysqli_query($conn, $sql);
	mysqli_close($conn);
	
	return (mysqli_num_rows($result) > 0) ? true : false;
}	

function insertData($user_data)
{
	$conn = connectDatabase();
	
	$sql = 'INSERT INTO users(mail, name, password)	
	VALUES ("'.$user_data['mail'].'", "'.$user_data['naam'].'" , "'.$user_data['wachtwoord'].'")';

	if (!mysqli_query($conn, $sql)) 
	{
		echo "Error: " . $sql . "<br>" . mysqli_error($conn);
	}
	mysqli_close($conn);
}

function updatePassword($new_password, $current_email)
{
	$conn = connectDatabase();
	
	$sql = 'UPDATE users SET password="'.$new_password.'" WHERE mail="'.$current_email.'"';
	
	if (!mysqli_query($conn, $sql)) 
	{
		echo "Error updating record: " . mysqli_error($conn);
	}
	mysqli_close($conn);
}

function getUserDataFromDb($user_data) : array
{
	$conn = connectDatabase();

	$sql = 'SELECT mail, name, password FROM users WHERE mail ="'.$user_data['mail'].'"';
	$result = mysqli_query($conn, $sql);
	mysqli_close($conn);
	if (mysqli_num_rows($result) > 0) 
	{	 	
		while($row = mysqli_fetch_assoc($result)) 
		{
			return array ('mail' => $row['mail'] , 'naam' =>  $row['name'] , 'password' =>  $row['password'] );			
		}
	} 	
}

function getAllProducts()
{
	$conn = connectDatabase();
	$sql = "SELECT id, name, price, filename FROM products";
	$result = $conn->query($sql);
	$conn->close();
	if ($result->num_rows > 0) 
	{	
		while($row = $result->fetch_assoc()) 
		{
			$complete_array[] = array('id' => $row['id'], 'name' =>  $row['name'], 'price' => $row['price'], 'filename' => $row['filename']);		
		}
	}
	else 
	{
		echo "0 results";
	}	
	return $complete_array;
}



?> 



