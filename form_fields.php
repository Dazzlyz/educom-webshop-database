<?php
function makeSelect($post_result, $key, $label, $get_array) 
{	
	$select_options = $get_array();	
			
	echo '<label for="'.$key.'">'.$label.':</label>
	<select id="'.$key.'" name="'.$key.'">';
	$value = create_result($post_result, $key);
	
	foreach ($select_options as $option) 
	{	
		$selected = $option == $value ? 'selected' : '';
		echo '<option value="'.$option.'" '.$selected.'>'.$option.'</option>';			
	}	
	echo '</select> <br>';	
}

	
function makeTextInput($post_result, $key, $label) 
{
	$text_result = create_result($post_result, $key);
	
	echo '<label for="' . $key . '">' . $label . ':</label>
	<input type="text" id="' . $key . '" name="' . $key . '" value="' . $text_result . '">';	
}

function makeRadioButtons($post_result, $key, $label, $get_array) 
{
	$options = $get_array();	
	
	echo '<label for="' . $key . '">'. $label .':</label>';
	
	foreach ($options as $option) 
	{	
		$checked = array_key_exists($key, $post_result) && ($post_result[$key]== $option) ? 'checked' : '';	
		echo '<input type="radio" id="' . $option . '" name="' . $key . '" '.$checked.' value="' . $option . '">
		<label for="' . $option . '">' . ucfirst($option). '</label>';
	}	
}	

function makeTextArea($post_result, $key, $label) 
{
	$area_result = create_result($post_result, $key);	
		
	echo '<label for="' . $key . '">' . $label .':</label>
	<textarea id="' . $key . '" name="' . $key . '" rows="4" >' .$area_result. '</textarea>';	
}
?>