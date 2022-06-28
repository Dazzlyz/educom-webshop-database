<?php 

function openForm($page)
{
	echo '<div class="standard">		
	<form method="post" action="index.php">
	<input type="hidden" name="page" value="'.$page.'" />';
}

function errorSpan($post_result, $key)
{
	array_key_exists($key, $post_result) ? $error_msg = '*'.$post_result[$key] : $error_msg = '';
	echo '<span class="error">' . $error_msg . '</span> <br>';
}

function create_result($post_result, $result) 
{
	array_key_exists($result, $post_result) ? $result = $post_result[$result] : $result = '';
	return $result;
}

function closeForm()
{
	echo '<input type="submit" id="submit" value="Verstuur">
	</form>
	</div>';
}

function generateForm($key, $post_result)
{	
	$set_array_key = 'get'.$key.'fields';
	openForm($key);	

	foreach ($formfields = $set_array_key() as $key => $info)
	{ 
		if (isset($info['get_array']))
		{
			$info['field_option']($post_result, $info['key'], $info['label'], $info['get_array']);
		}
		else 
		{
			$info['field_option']($post_result, $info['key'], $info['label']);
		}
		if (isset($info['required']) && $info['required'] == 'yes')
		{
			errorSpan($post_result, $info['key'].'Err');			
		}
	}		
	closeForm();	
}

function showThankYou($post_result) 
{
	echo '<h2>Bedankt voor het invoeren! </h2>
	Uw gegevens: <br>';
	foreach ($post_result as $key => $value)
	{
		if ($key == 'error_counter' || $value == '')
		{
			continue;
		}
		else
		{
			echo ''.ucfirst($key).' : '.$value.'<br>';
		}
	}
}
?>