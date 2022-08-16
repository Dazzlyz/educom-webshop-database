/*
    Document Ready EventListener Example
    Geert Weggemans - M@nKind
    16-05-2022
 */

// maak array voor iteractie per fieldset voor de button structuur. 
// button menu structureren door klein te testen 
function documentReady()
{
    console.log("===== DOC READY ======");
    updateNumberCount();
    logValue();
    togglePassword();
    toggleFieldsets(); 
}	

// alles pakt het eerst veld in bestand
function logValue()
{    
    document.addEventListener("focusout", focusOut);        
}

function focusOut()
{
    const val = document.querySelector('input').value;
 	console.log(val);    
}

function togglePassword() // ???!?!?!?
{
    const input = document.querySelector('input')
    const button = document.querySelector('button')
    document.getElementById("password_toggle").onclick = () => 
    {
    if (input.type === 'password') 
    {
        input.type = 'text'
    } else 
    {
        input.type = 'password'
    }
    }
}

function toggleFieldsets()
{
    document.getElementById("b1").addEventListener('click', () => 
    {
        document.getElementById("fs_file").hidden = false;
        document.getElementById("fs_user").hidden = true;
        document.getElementById("fs_base").hidden = true;
        document.getElementById("fs_datatime").hidden = true;
        document.getElementById("fs_numeric").hidden = true;
        document.getElementById("fs_mc").hidden = true;
        document.getElementById("fs_optional").hidden = true;
        document.getElementById("fs_buttons").hidden = true;
    }, 
    false)
    document.getElementById("b2").addEventListener('click', () => 
    {
        document.getElementById("fs_file").hidden = true;
        document.getElementById("fs_user").hidden = false;
        document.getElementById("fs_base").hidden = true;
        document.getElementById("fs_datatime").hidden = true;
        document.getElementById("fs_numeric").hidden = true;
        document.getElementById("fs_mc").hidden = true;
        document.getElementById("fs_optional").hidden = true;
        document.getElementById("fs_buttons").hidden = true;
    }, 
    false)
    document.getElementById("b3").addEventListener('click', () => 
    {
        document.getElementById("fs_file").hidden = true;
        document.getElementById("fs_user").hidden = true;
        document.getElementById("fs_base").hidden = false;
        document.getElementById("fs_datatime").hidden = true;
        document.getElementById("fs_numeric").hidden = true;
        document.getElementById("fs_mc").hidden = true;
        document.getElementById("fs_optional").hidden = true;
        document.getElementById("fs_buttons").hidden = true;
    }, 
    false)
    document.getElementById("b4").addEventListener('click', () => 
    {
        document.getElementById("fs_file").hidden = true;
        document.getElementById("fs_user").hidden = true;
        document.getElementById("fs_base").hidden = true;
        document.getElementById("fs_datatime").hidden = false;
        document.getElementById("fs_numeric").hidden = true;
        document.getElementById("fs_mc").hidden = true;
        document.getElementById("fs_optional").hidden = true;
        document.getElementById("fs_buttons").hidden = true;
    }, 
    false)
    document.getElementById("b5").addEventListener('click', () => 
    {
        document.getElementById("fs_file").hidden = true;
        document.getElementById("fs_user").hidden = true;
        document.getElementById("fs_base").hidden = true;
        document.getElementById("fs_datatime").hidden = true;
        document.getElementById("fs_numeric").hidden = false;
        document.getElementById("fs_mc").hidden = true;
        document.getElementById("fs_optional").hidden = true;
        document.getElementById("fs_buttons").hidden = true;
    }, 
    false)
    document.getElementById("b6").addEventListener('click', () => 
    {
        document.getElementById("fs_file").hidden = true;
        document.getElementById("fs_user").hidden = true;
        document.getElementById("fs_base").hidden = true;
        document.getElementById("fs_datatime").hidden = true;
        document.getElementById("fs_numeric").hidden = true;
        document.getElementById("fs_mc").hidden = false;
        document.getElementById("fs_optional").hidden = true;
        document.getElementById("fs_buttons").hidden = true;

    }, 
    false)
    document.getElementById("b7").addEventListener('click', () => 
    {
        document.getElementById("fs_file").hidden = true;
        document.getElementById("fs_user").hidden = true;
        document.getElementById("fs_base").hidden = true;
        document.getElementById("fs_datatime").hidden = true;
        document.getElementById("fs_numeric").hidden = true;
        document.getElementById("fs_mc").hidden = true;
        document.getElementById("fs_optional").hidden = false;
        document.getElementById("fs_buttons").hidden = true;
    }, 
    false)
    document.getElementById("b8").addEventListener('click', () => 
    {
        document.getElementById("fs_file").hidden = true;
        document.getElementById("fs_user").hidden = true;
        document.getElementById("fs_base").hidden = true;
        document.getElementById("fs_datatime").hidden = true;
        document.getElementById("fs_numeric").hidden = true;
        document.getElementById("fs_mc").hidden = true;
        document.getElementById("fs_optional").hidden = true;
        document.getElementById("fs_buttons").hidden = false;
    }, 
    false)
}

function updateNumberCount()
{
    document.getElementById('rijkolom').onkeyup = function () {
    document.getElementById('count').innerHTML = "Total characters: " + (this.value.length);
    };
}

// function handleButtons()
    


    
(function (execute_this_function_when_ready) 
{
     if (document.readyState === "complete" || document.readyState === "interactive") 
    {        // call on next available tick
        setTimeout(execute_this_function_when_ready, 1);        
    } 
    else
    {    
        document.addEventListener("DOMContentLoaded", execute_this_function_when_ready);        
    }
}(documentReady));    


