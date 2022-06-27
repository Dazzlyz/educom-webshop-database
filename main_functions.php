<?php

require 'page_functions.php';
require 'texts.php';
require 'get_var_functions.php';
require 'validation.php';
require 'forms.php';
require 'form_fields.php';
require 'generate_body.php';
require 'menu.php';
require 'handle_database.php';

function getRequest() : array
{
	$requested_type = $_SERVER['REQUEST_METHOD']; 
	$posted = ($requested_type == 'POST') ? true : false;
	$page = getRequestedPage(); 
	return array ('posted' => $posted,
				  'page' => $page);	
}

function validateRequest(array $request) : array
{
	$request = getRequest();
    $response = $request;

    if ($request['posted'])
    {
		
        switch ($request['page'])
        {
            case 'login' :
				$post_result = validatePostData($_POST, $post_result=array(), $request['page']);	
				if (isResultArrayComplete($post_result))
				{
					$_SESSION['email'] = $_SESSION['check_array']['email'];
					$_SESSION['password'] = $_SESSION['check_array']['password'];	
					$_SESSION['username'] = $_SESSION['check_array']['naam'];		
					$response['page'] = 'home';
				}
				else 
				{
					$response = $request;
				}               			
                break;
			case 'register' :
				$post_result = validatePostData($_POST, $post_result=array(), $request['page']);	
				if (isResultArrayComplete($post_result))
				{											
					insertData($post_result);
					$response['page'] = 'login';
				}
				else 
				{
					$response = $request;
				}               			
                break;
			case 'changepassword' :				
				$post_result = validatePostData($_POST, $post_result=array(), $request['page']);					
				if (isResultArrayComplete($post_result))
				{		
					updatePassword($post_result['nieuw_wachtwoord_controle'], $_SESSION['email']);
					$_SESSION['password'] = $post_result['nieuw_wachtwoord_controle'];
					$response['page'] = 'home';
				}
				else 
				{
					$response = $request;
				}               			
                break;	
			case 'contact' :
				$post_result = validatePostData($_POST, $post_result=array(), $request['page']);	
				if (isResultArrayComplete($post_result))
				{
					showThankYou($post_result); 
				}	
				else 
				{
					$response = $request;
				} 
				break;	
        }
    }
    else
    {
        switch ($request['page'])
        {
            case 'logout' :
                $_SESSION['username']	= '';
                $response['page'] = 'home';
                break;
        }
    }
    return $response;
}

// titel fixen, vooral van changepassword pagina
function showPage($response='') 
{	
	generateHead($response['page']);

	openBody();
	
	generateHeader($response['page']);
	
	showMenu(getMenuItems(getArrayVar($_SESSION, 'username', '')));
	
	generateContent($response['page']);
	
	generalFooter();

	closingTags();	
}

function getRequestedPage() 
{     
	$requested_type = $_SERVER['REQUEST_METHOD']; 
	if ($requested_type == 'POST') 
    { 
		$requested_page = getPostVar('page','home'); 				
    } 
    else 
    { 
		$requested_page = getUrlVar('page','home'); 
    }   
   return $requested_page; 
}

function generateContent($page, $post_result=array())
{
	switch ($page)
	{
		case 'home' :
			homeText();				
		break;
		case 'about' :		
			aboutText();	
		break;			
		default:
			generateBody($post_result, $page);
		break;		
	}	
}




?>