<?php

require 'arrays.php';

function generateHeader($title) 
{
	if ($title == 'changepassword')
	{
		echo '<h1>Change Password</h1>';
	}
	else
	{
		echo '<h1>' . strtoupper($title) . '</h1>';
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
	<link rel="stylesheet" href="styles/style.css">
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