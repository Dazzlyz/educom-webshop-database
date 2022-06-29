<?php

require 'arrays.php';
// Betere oplossing vinden
function generateHeader($title) 
{
	switch ($title)
	{
		case 'changepassword' :
			echo '<h1>Change Password</h1>';
		break;
		case 'thankyou' :
			echo '<h1>Thank you</h1>';
		break;
		case 'shoppingcart' :
			echo '<h1>Shopping Cart</h1>';
		break;
		default :
			echo '<h1>' . strtoupper($title) . '</h1>';	
		break;
	}
}

function generalFooter() 
{
	echo '<footer>
	<p> &copy; 2022 Menno van den Bosch </p>
	</footer>';
}

function generateHead($page_name) 
{
	echo '<html lang="nl">
	<head>
	<link rel="stylesheet" href="CSS/style.css">
	<title>' . ucfirst($page_name) . '</title>
	</head>';
}

function closingTags() 
{
	echo'</body>
	</html>';
}

function openBody() 
{
	echo '<body>' ;
}
?>