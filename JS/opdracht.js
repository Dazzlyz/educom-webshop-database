/*
    Document Ready EventListener Example
    Geert Weggemans - M@nKind
    16-05-2022
 */
function togglePassWord()
{
    const pw_input =  document.getElementById('password');
    const newtype = (pw_input.getAttribute('type')==='password')?'text':'password';
    pw_input.setAttribute('type', newtype);
}

function addPasswordFunction()
{
    const pw_input = document.getElementById('password');
    const pw_button = document.createElement('span');
    pw_button.innerHTML = '[&#x1F441;]';
    pw_input.after(pw_button);
    pw_button.addEventListener('click', togglePassWord);
}

function looseFocus(e)
{
    console.log(e.target.name+' = '+e.target.value);
}

function addLooseFocusFunction()
{
    Array.from(document.getElementsByTagName('input')).forEach(
           element => element.addEventListener('blur', looseFocus)
    );
}

function countChars(e)
{
    const id = e.target.id;
    let count_span = document.getElementById('count_'+id);
    if (count_span===null)
    {
        count_span = document.createElement('span');
        count_span.id = 'count_'+id;
        count_span.style.display = 'block';
        e.target.after(count_span);
    }    
    count_span.innerHTML =e.target.value.length+' characters';
}


function addCharCountFunction()
{
    Array.from(document.getElementsByTagName('textarea')).forEach(
           element => element.addEventListener('keyup', countChars)
    );
}


function documentReady()
{
    alert("===== DOC READY ======");
    addPasswordFunction();
    addLooseFocusFunction();
    addCharCountFunction();
}	

(function (execute_this_function_when_ready) 
{
    if (document.readyState === "complete" || document.readyState === "interactive") 
    {
        // call on next available tick
        setTimeout(execute_this_function_when_ready, 1);
    } 
    else
    {
        document.addEventListener("DOMContentLoaded", execute_this_function_when_ready);
    }
}(documentReady));    


