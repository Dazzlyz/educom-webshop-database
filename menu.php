<?php 
// tabel uit database met rubrieken structuur maken??
// define ('BASELINK', 'index.php'); constant nog in class opnemen? 

class Menu 
{
    const BASELINK = 'index.php';

    function getMenuItems(string $username = '') : array
    {
        $items = [
            'home'		=> 'Home',
            'about' 	=> 'About me',
            'contact' 	=> 'Contact me',	
            'webshop' => 'WebShop'	
        ];
        if ($username)
        {
            return array_merge($items, ['shoppingcart' => 'Shopping Cart', 'logout' => 'Logout '.$username,  'changepassword' => 'Change Password']);
        }
        return array_merge($items, ['login' => 'Login', 'register' => 'Register']);
    }

    function showMenuItem(string $page, string $title) : void
    {
        echo '<li class="menu_item"><a href="'.self::BASELINK.'?page='.$page.'">'.$title.'</a></li>'.PHP_EOL;
    }

    function showMenu(array $items) : void
    {
        echo '<ul class="menu">'.PHP_EOL;
        foreach ($items as $page => $title)
        {
            $this->showMenuItem($page, $title);
        }
        echo '</ul>'.PHP_EOL;
    }
}
?>
