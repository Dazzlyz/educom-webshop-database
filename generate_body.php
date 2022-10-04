<?php

function generateBody($post_result, $page) 
{
    $form = new Form();
    ($_SERVER['REQUEST_METHOD'] == 'POST') ? checkPostRequest($post_result, $page) : $form->generateForm($page, $post_result);
}	

function checkPostRequest($post_result, $page)
{
    $post_result = validatePostData($_POST, $post_result, $page);	
    handlePost($page, $post_result);	
}


function showThankYou($post_result) 
{		
    echo '<h2>Bedankt voor het invoeren! </h2>
    Uw gegevens: <br>';
    foreach ($post_result as $key => $value)
    {		
        if (in_array($key, showThanksArray()) && ($value !== ''))
        {
            echo ''.ucfirst($key).' : '.$value.'<br>';
        }
    }
}

function handlePost($page, $post_result)
{
    $form = new Form();
    $page == 'contact' && isResultArrayComplete($post_result) ? showThankYou($post_result) : $form->generateForm($page, $post_result);
}

?>