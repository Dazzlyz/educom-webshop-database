<?php

function generateBody($post_result, $page) 
{
	if ($_SERVER['REQUEST_METHOD'] == 'GET') 
	{ 	
		generateForm($page, $post_result);
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

function handlePost($page, $post_result)
{
	$page == 'contact' && isResultArrayComplete($post_result) ? showThankYou($post_result) : generateForm($page, $post_result);
}
?>