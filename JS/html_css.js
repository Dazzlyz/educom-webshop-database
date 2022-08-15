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


