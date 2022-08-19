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
    addPasswordFunction();
    toggleFieldsets();  
    focusOut();
}	

function togglePassword() // ???!?!?!? post resultaten en check eerst alle velden? 
{
    document.getElementById("password_toggle").addEventListener('click', () => 
    {
        if (document.querySelector('input').type === 'password') 
        {
            document.querySelector('input').type = 'text'
        } 
        else 
        {
            document.querySelector('input').type = 'password'
        }
    })
}
function addPasswordFunction()
{
    const pw_input = document.getElementById('password');
    const pw_button = document.getElementById('password_toggle');
    pw_button.innerHTML = '[&#128584;]';
    pw_input.after(pw_button);
    pw_button.addEventListener('click', togglePassWord);
}

function togglePassWord()
{    
    const newtype = (document.getElementById('password').getAttribute('type')==='text')?'password':'text';
    document.getElementById('password').setAttribute('type', newtype);
}


// alles pakt het eerst veld in bestand
function logValue(e)
{   
    console.log(e.target.name+' = '+e.target.value);   
}

function focusOut()
{
    Array.from(document.getElementsByTagName('input')).forEach(
        element => element.addEventListener('blur', logValue)
 );
}




// checken hoe functies nu met array werken, 1+2 linken naar base en rest naar een te ver terug? 
function toggleFieldsets()
{
    document.getElementById("b1").addEventListener('click', () => 
    {
        document.getElementById("fs_base").hidden = false;
        document.getElementById("fs_user").hidden = true;
        document.getElementById("fs_file").hidden = true;
        document.getElementById("fs_datetime").hidden = true;
        document.getElementById("fs_numeric").hidden = true;
        document.getElementById("fs_mc").hidden = true;
        document.getElementById("fs_optional").hidden = true;
        document.getElementById("fs_buttons").hidden = true;
    }, 
    false)
    document.getElementById("b2").addEventListener('click', () => 
    {
        document.getElementById("fs_base").hidden = true;
        document.getElementById("fs_user").hidden = false;
        document.getElementById("fs_file").hidden = true;
        document.getElementById("fs_datetime").hidden = true;
        document.getElementById("fs_numeric").hidden = true;
        document.getElementById("fs_mc").hidden = true;
        document.getElementById("fs_optional").hidden = true;
        document.getElementById("fs_buttons").hidden = true;
    }, 
    false)
    document.getElementById("b3").addEventListener('click', () => 
    {
        document.getElementById("fs_base").hidden = true;
        document.getElementById("fs_user").hidden = true;
        document.getElementById("fs_file").hidden = false;
        document.getElementById("fs_datetime").hidden = true;
        document.getElementById("fs_numeric").hidden = true;
        document.getElementById("fs_mc").hidden = true;
        document.getElementById("fs_optional").hidden = true;
        document.getElementById("fs_buttons").hidden = true;
    }, 
    false)
    document.getElementById("b4").addEventListener('click', () => 
    {
        document.getElementById("fs_base").hidden = true;
        document.getElementById("fs_user").hidden = true;
        document.getElementById("fs_file").hidden = true;
        document.getElementById("fs_datetime").hidden = false;
        document.getElementById("fs_numeric").hidden = true;
        document.getElementById("fs_mc").hidden = true;
        document.getElementById("fs_optional").hidden = true;
        document.getElementById("fs_buttons").hidden = true;
    }, 
    false)
    document.getElementById("b5").addEventListener('click', () => 
    {
        document.getElementById("fs_base").hidden = true;
        document.getElementById("fs_user").hidden = true;
        document.getElementById("fs_file").hidden = true;
        document.getElementById("fs_datetime").hidden = true;
        document.getElementById("fs_numeric").hidden = false;
        document.getElementById("fs_mc").hidden = true;
        document.getElementById("fs_optional").hidden = true;
        document.getElementById("fs_buttons").hidden = true;
    }, 
    false)
    document.getElementById("b6").addEventListener('click', () => 
    {
        document.getElementById("fs_base").hidden = true;
        document.getElementById("fs_user").hidden = true;
        document.getElementById("fs_file").hidden = true;
        document.getElementById("fs_datetime").hidden = true;
        document.getElementById("fs_numeric").hidden = true;
        document.getElementById("fs_mc").hidden = false;
        document.getElementById("fs_optional").hidden = true;
        document.getElementById("fs_buttons").hidden = true;

    }, 
    false)
    document.getElementById("b7").addEventListener('click', () => 
    {
        document.getElementById("fs_base").hidden = true;
        document.getElementById("fs_user").hidden = true;
        document.getElementById("fs_file").hidden = true;
        document.getElementById("fs_datetime").hidden = true;
        document.getElementById("fs_numeric").hidden = true;
        document.getElementById("fs_mc").hidden = true;
        document.getElementById("fs_optional").hidden = false;
        document.getElementById("fs_buttons").hidden = true;
    }, 
    false)
    document.getElementById("b8").addEventListener('click', () => 
    {
        document.getElementById("fs_base").hidden = true;
        document.getElementById("fs_user").hidden = true;
        document.getElementById("fs_file").hidden = true;
        document.getElementById("fs_datetime").hidden = true;
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


