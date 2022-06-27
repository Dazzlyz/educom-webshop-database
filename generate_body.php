<?php

function generateBody($post_result, $page) 
{
	if ($_SERVER['REQUEST_METHOD'] == 'GET') 
	{ 	
		generateForm($page, $post_result, 'getContactFields');
	}		
	if ($_SERVER['REQUEST_METHOD'] == 'POST') 
	{	
		checkPostRequest($post_result, $page);		
	}	
}

function checkPostRequest($post_result, $page)
{
	$post_result = validatePostData($_POST, $post_result, $page);	
	handlePost($page, $post_result);	
}

function handlePost($page, $result_array)
{
	generateForm($page, $result_array);		
}
?>