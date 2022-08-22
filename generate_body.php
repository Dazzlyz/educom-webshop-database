<?php

function generateBody($post_result, $page) 
{
    ($_SERVER['REQUEST_METHOD'] == 'POST') ? checkPostRequest($post_result, $page) : generateForm($page, $post_result);
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