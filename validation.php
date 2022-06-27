<?php
// nog pagina doorlopen op functies die algemener en zonder herhaling kunnen

function testInput($data) 
{
	$data = trim($data);
	$data = stripslashes($data);
	$data = htmlspecialchars($data);
	return $data;	  
}	

function handleError($post_result, $key, $error_msg)
{
	$post_result[$key] = $error_msg;
	$post_result['error_counter'] += 1;
	return $post_result;
}

//functienaam?
function checkFringeCases($key, $post_result)
{
	if ($key == 'naam' && (!preg_match("/^[a-zA-Z-' ]*$/",$post_result[$key])))
	{
		$post_result = handleError($post_result, ''.$key.'Err', 'Alleen letters toegestaan');								
	}
	elseif ($key == 'mail' && (!filter_var($post_result[$key], FILTER_VALIDATE_EMAIL)))
	{
		$post_result = handleError($post_result, ''.$key.'Err', 'Geen geldig E-mail formaat');								
	}
	elseif ($key == 'tel' && (!preg_match("/^[0-9-' ]*$/", $post_result[$key]))) 
	{
		$post_result = handleError($post_result, ''.$key.'Err', 'Alleen nummers toegestaan');				
	}
	return $post_result;
}

function validateDefaultfield($global_post, $post_result, $key)
{
	if (empty($global_post[$key])) 
	{
		$post_result = handleError($post_result, ''.$key.'Err', ''.ucfirst($key).' is een verplicht veld');			
	} 
	else 
	{
		$post_result[$key] = testInput($global_post[$key]);
		$post_result = checkFringeCases($key, $post_result);
	}
	return $post_result;
}

function validateAanhef($global_post, $post_result, $key)
{	
	if (isset($global_post['aanhef']))
	{
		$post_result[$key] = testInput($global_post[$key]);
			if ($post_result[$key] == '-') 
			{
				$post_result[$key] = '';
			}
	}
	return $post_result;
}

function checkRegister($global_post, $post_result, $key)
{
	// onderstaande zou opgelost zijn TESTEN of validatie nog werkt als bedoeld
	// check klopt, empty check wordt wel 2maal gerunt, later kijken om te fixen	
	switch ($key)
	{
		case 'mail' :		
		{			
			if (checkMailEntries($global_post))
			{
				$post_result = handleError($post_result, ''.$key.'Err', 'Email al geregisteerd');
			}		
		}
		break;
		default :
			if (isset($global_post['wachtwoord']) && isset($global_post['wachtwoord_controle']))
			{
				if ($global_post['wachtwoord'] != $global_post['wachtwoord_controle'])
				{
					$post_result = handleError($post_result, ''.$key.'Err', 'Wachtwoord niet gelijk');	
				}	
			}
		break;
	}
	return $post_result;
}

function checkLogin($global_post, $post_result, $key)
{	 	
	if (isset($global_post['mail']) && (checkMailEntries($global_post)))
	{
		$user_data = getUserDataFromDb($post_result);		
	}
	switch ($key)
	{
		case 'mail' :				
			if (!checkMailEntries($global_post))
			{
				$post_result = handleError($post_result, ''.$key.'Err', 'Email onbekend');
			}		
		break;
		case 'wachtwoord' :			
			if (isset($user_data) && isset($global_post[$key]))		
			{					
				if ($global_post[$key] == $user_data['password'])
				{
					makeCheckArray($user_data);
				}
				else 
				{
					$post_result = handleError($post_result, ''.$key.'Err', 'Wachtwoord onjuist');
				}
			}
		break;	
	}
	return $post_result;
}

function checkCurrentPassword($global_post, $post_result, $key)
{
	if (isset($global_post['wachtwoord']))
	{
		if ($global_post['wachtwoord'] !== $_SESSION['password'])		
		{
			$post_result = handleError($post_result, ''.$key.'Err', 'Wachtwoord onjuist');
		}
	}	
	return $post_result;	
}

function checkChangePassword($global_post, $post_result, $key)
{
	if (isset($global_post['nieuw_wachtwoord']) && isset($global_post['nieuw_wachtwoord_controle']))
	{	
		if ($global_post['nieuw_wachtwoord'] !== $global_post['nieuw_wachtwoord_controle'])
		{			
			$post_result = handleError($post_result, ''.$key.'Err', 'Wachtwoord niet gelijk');
		}	
		if ($global_post['wachtwoord'] == $global_post['nieuw_wachtwoord_controle'])
		{
			$post_result = handleError($post_result, ''.$key.'Err', 'Nieuw wachtwoord kan niet huidige wachtwoord zijn');
		}
	}
	return $post_result;
}

// nadenken over bij deze soort functies array meegeven
function validatePostData($global_post, $post_result, $key) 
{	
	$set_array_key = 'get'.$key.'fields';
	$post_result['error_counter'] = 0;	
	
	foreach ($formfields = $set_array_key() as $key => $info)
	{			
		$post_result = $info['validation_type']($global_post, $post_result, $info['key']);	
		
		if (isset ($info['special_validation']))
		{
			$post_result = $info['special_validation']($global_post, $post_result, $info['key']);					
		}	
	}
	return $post_result;
}

function isResultArrayComplete($post_result)
{		
	return ($post_result['error_counter'] == 0); 
}
?>	