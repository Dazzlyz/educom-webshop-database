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
require 'session_manager.php';
require 'webshop.php';
require 'arrays.php';

function getRequest() : array
{	
    $posted = ($_SERVER['REQUEST_METHOD'] == 'POST') ? true : false;
    $page = getRequestedPage(); 
    return array ('posted' => $posted,
                  'page' => $page);	
}

function validateRequest() : array
{	
    $request = getRequest();
    $response = $request;	
    try
    { 	   
    
        if ($request['posted'])
        {	   
            if (in_array($request['page'] , getAvailableProducts()))
            {
                manageCart($_POST);		
                header('Location: http://localhost/educom-webshop-database/index.php?page=shoppingcart');
            }	       
            else 
            {      
                $post_result = validatePostData($_POST, $post_result=array(), $request['page']);	
                
                switch ($request['page'])
                {			
                    case 'login' :					
                        if (isResultArrayComplete($post_result))
                        {
                            logInUser();	
                            $response['page'] = 'home';
                        }				    			
                    break;
                    case 'register' :				
                        if (isResultArrayComplete($post_result))
                        {	                           										
                            insertData($post_result['mail'], $post_result['naam'], $post_result['wachtwoord'] );                       						
                            $response['page'] = 'login';
                        }				             			
                    break;
                    case 'changepassword' :									
                        if (isResultArrayComplete($post_result))
                        {		
                            updatePassword($post_result['nieuw_wachtwoord_controle'], $_SESSION['email']);                      
                            updateSessionPassword($post_result['nieuw_wachtwoord_controle']);
                            $response['page'] = 'home';
                        }				            			
                    break;   
                }        
            }
        
        }            
        else
        {           	                
            switch ($request['page'])
            {
                case 'logout' :
                    logOutUser();
                    $response['page'] = 'home';
                break;
                case 'detail' :
                    $response['page'] =  getUrlVar('product','home');
                    break;
                case 'afrekenen' :                    
                    addOrder();
                    emptyShoppingCart();                
                    header('Location: http://localhost/educom-webshop-database/index.php?page=home'); 
                break;        
            }
        }
    }   
    catch(Exception $e)
    {
        echo $e->getMessage();
    }
    return $response;
}

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
    try
    {        
        if (in_array($page , getAvailableProducts()))
        {           
            showDetail($page);      
        }
        else 
        {
            switch ($page)
            {
                case 'home' :
                    homeText();				
                break;
                case 'about' :                                   
                    aboutText();	
                break;                   
                case 'webshop':                   
                    showWebshop();            
                break;	
                case 'shoppingcart' :
                    showCart();
                break;
              
                default:
                    generateBody($post_result, $page);
                break;		
            }	
        }
    }
    catch(Exception $e)
    {
        echo $e->getMessage();
    }  
}
?>