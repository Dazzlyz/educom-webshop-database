<?php 

function getCommunicatievoorkeuren() : array
{
	return array('email', 'telefoon');
}

function getAanhefOptions() : array
{
	return array('-', 'Dhr', 'Mvr');
}

function getChangePasswordFields() : array
{
	return array
	('wachtwoord'			=>  array('key' => 'wachtwoord',
									'label' => 'Wachtwoord',
									'field_option' => 'makeTextInput',
									'required' => 'yes',
									'validation_type' => 'validateDefaultfield',
									'special_validation' => 'checkCurrentPassword'
									),	
	'nieuw_wachtwoord'			=>  array('key' => 'nieuw_wachtwoord',
									'label' => 'Nieuw wachtwoord',
									'field_option' => 'makeTextInput',
									'required' => 'yes',
									'validation_type' => 'validateDefaultfield',
									'special_validation' => 'checkChangePassword'
									),	
	'nieuw_wachtwoord_controle'			=>  array('key' => 'nieuw_wachtwoord_controle',
									'label' => 'Controleer nieuwe wachtwoord',
									'field_option' => 'makeTextInput',
									'required' => 'yes',
									'validation_type' => 'validateDefaultfield',
									'special_validation' => 'checkChangePassword'
									),
	);
}

function getRegisterFields() : array
{
	return array
	('naam'  				=>  array('key' => 'naam',
									'label' => 'Naam',
									'field_option' => 'makeTextInput',
									'required' => 'yes',
									'validation_type' => 'validateDefaultfield'								
									),
	'email' 				=>  array('key' => 'mail',
									'label' => 'E-mail',
									'field_option' => 'makeTextInput',
									'required' => 'yes',
									'validation_type' => 'validateDefaultfield',
									'special_validation' => 'checkRegister'
									
									),
	'wachtwoord'			=>  array('key' => 'wachtwoord',
									'label' => 'Wachtwoord',
									'field_option' => 'makeTextInput',
									'required' => 'yes',
									'validation_type' => 'validateDefaultfield',
									'special_validation' => 'checkRegister'
									),	
	'wachtwoord_controle'	=>  array('key' => 'wachtwoord_controle',
									'label' => 'Bevestig uw wachtwoord',
									'field_option' => 'makeTextInput',
									'required' => 'yes',
									'validation_type' => 'validateDefaultfield',
									'special_validation' => 'checkRegister'
									),									
	);		
}

function getLoginFields() : array
{
	return array
	('email' 				=>  array('key' => 'mail',
									'label' => 'E-mail',
									'field_option' => 'makeTextInput',
									'required' => 'yes',
									'validation_type' => 'validateDefaultfield',
									'special_validation' => 'checkLogin'	
				
									),
	'wachtwoord'			=>  array('key' => 'wachtwoord',
									'label' => 'Wachtwoord',
									'field_option' => 'makeTextInput',
									'required' => 'yes',
									'validation_type' => 'validateDefaultfield',
									'special_validation' => 'checkLogin'
									),										
	);		
}

function getContactFields() : array
{
	return array
	(
	'aanhef' 				=> 	array('key' => 'aanhef',
									'label' => 'Aanhef',
									'field_option' => 'makeSelect',
									'get_array' => 'getAanhefOptions',
									'validation_type' => 'validateAanhef'									
									),
	'naam'  				=>  array('key' => 'naam',
									'label' => 'Naam',
									'field_option' => 'makeTextInput',
									'required' => 'yes',
									'validation_type' => 'validateDefaultfield'
									),
	'email' 				=>  array('key' => 'mail',
									'label' => 'E-mail',
									'field_option' => 'makeTextInput',
									'required' => 'yes',
									'validation_type' => 'validateDefaultfield'
									),
	'tel'   				=>  array('key' => 'tel',
									'label' => 'Telefoonnummer',
									'field_option' => 'makeTextInput',
									'required' => 'yes',
									'validation_type' => 'validateDefaultfield'
									),
	'communicatievoorkeur' 	=> 	array('key' => 'communicatievoorkeur',
									'label' => 'Communicatievoorkeur',
									'field_option' => 'makeRadioButtons',
									'get_array' => 'getCommunicatievoorkeuren',
									'required' => 'yes',
									'validation_type' => 'validateDefaultfield'
								    ),
	'bericht' 				=> 	array('key' => 'bericht',
									'label' => 'Bericht',
									'field_option' => 'makeTextArea',
									'required' => 'yes',
									'validation_type' => 'validateDefaultfield'
									),
	);		
}

?>
