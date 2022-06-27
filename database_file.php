 <?php
 // naam bestand?!?!?!?
// 
 
 // werkend maken dat niet elke keer db los aangeroepen hoeft te worden. 
function connectDatabase()
{
	$servername = "127.0.0.1";
	$username = "access";
	$password = "Hallo";
	$dbname = "menno_webshop";
	$conn = mysqli_connect($servername, $username, $password, $dbname);

	if (!$conn) 
	{
		die("Connection failed: " . mysqli_connect_error());
	}
	return $conn;
}
// AANZIENLIJK MOOIER MAKEN
function checkMailEntries($user_data)
{
	$servername = "127.0.0.1";
	$username = "access";
	$password = "Hallo";
	$dbname = "menno_webshop";
	$conn = mysqli_connect($servername, $username, $password, $dbname);

	if (!$conn) 
	{
		die("Connection failed: " . mysqli_connect_error());
	}	
	$sql = 'SELECT id, mail from users';
	$result = mysqli_query($conn, $sql);
	mysqli_close($conn);
	
	if (mysqli_num_rows($result) > 0)
	{
		while($row = mysqli_fetch_assoc($result)) 
		{
			if ($row['mail'] == $user_data['mail'])
			{
				$rows[] = 'true';
			}	
			else 
			{
				$rows[] = 'false';				
			}
		}
	} 
	else 
	{
	  echo "0 results";
	}
	if (in_array('true', $rows))
	{
		return true;
	}
	else
	{
		return false;
	}
}	

function insertData($user_data)
{
	$servername = "127.0.0.1";
	$username = "access";
	$password = "Hallo";
	$dbname = "menno_webshop";
	$conn = mysqli_connect($servername, $username, $password, $dbname);

	if (!$conn) 
	{
		die("Connection failed: " . mysqli_connect_error());
	}	
	
	$sql = 'INSERT INTO users(mail, name, password)	
	VALUES ("'.$user_data['mail'].'", "'.$user_data['naam'].'" , "'.$user_data['wachtwoord'].'")';

	if (mysqli_query($conn, $sql)) {
	echo "New record created successfully";
	} else {
	echo "Error: " . $sql . "<br>" . mysqli_error($conn);
	}

	mysqli_close($conn);
}

function updatePassword($new_password, $session_email)
{
	$servername = "127.0.0.1";
	$username = "access";
	$password = "Hallo";
	$dbname = "menno_webshop";	
	$conn = mysqli_connect($servername, $username, $password, $dbname);
	
	if (!$conn) 
	{
		die("Connection failed: " . mysqli_connect_error());
	}
	
	$sql = 'UPDATE users SET password="'.$new_password.'" WHERE mail="'.$session_email.'"';
	
	if (!mysqli_query($conn, $sql)) 
	{
		echo "Error updating record: " . mysqli_error($conn);
	}

mysqli_close($conn);

}







function getUserDataFromDb($user_data) : array
{
	$servername = "127.0.0.1";
	$username = "access";
	$password = "Hallo";
	$dbname = "menno_webshop";
	$conn = mysqli_connect($servername, $username, $password, $dbname);

	if (!$conn) 
	{
		die("Connection failed: " . mysqli_connect_error());
	}

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
	else 
	{
	  echo "";
	}


}
?> 



