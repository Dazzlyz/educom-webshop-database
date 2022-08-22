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
    generateProvinces();
    focusOut();
    // generateMenu();
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

function generateMenu()
{
    let tabs = ["1. Base", "2. User", "3. File", "4. Datatime", "5. Numeric",
         "6. MC", "7. Optional Dialogs", "8. Buttons"];
            for (let x in tabs)
            {
                let btn = document.createElement('button');
                btn.innerHTML = tabs[x];
                btn.setAttribute('id', 'b'+ x);
                document.getElementById('menu').after(btn);
            } 
}

function addPasswordFunction()
{
    const pw_input = document.getElementById('password');
    const pw_button = document.getElementById('password_toggle');
    pw_button.innerHTML = '[&#128584;]';
    pw_input.after(pw_button);
    pw_button.addEventListener('click', togglePassWord);
}

function generateProvinces()
{
    let provincies = ["Drenthe", "Flevoland", "Friesland", "Gelderland", "Groningen", "Limburg", 
                    "Noord-Brabant", "Noord-Holland", "Overijssel", "Utrecht", "Zeeland", "Zuid-Holland"];
        for (let x in provincies)
        {
            let opt = document.createElement('option');
            opt.innerHTML = provincies[x];
            document.getElementById('tickmarks').appendChild(opt);
        }
    
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
    let fsets = {'b0': 'fs_base', 'b1': 'fs_user', 'b2': 'fs_file', 'b3':'fs_datetime', 'b4': 'fs_numeric', 'b5': 'fs_mc', 'b6': 'fs_optional', 'b7': 'fs_buttons' }
    
    for (var key in fsets)
    {
        document.getElementById(key).addEventListener('click', () => 
        {
            document.getElementById(fsets[key]).hidden = false;
        }, 
        false)
    }

    // document.getElementById("b0").addEventListener('click', () => 
    // {
    //     let val = "b0";
    //     for (var key in fsets)        
    //     {
    //         if (key == val)
    //         {
    //             document.getElementById(fsets[key]).hidden = false;
    //         }
    //         else
    //         {
    //             document.getElementById(fsets[key]).hidden = true;
    //         }            
    //     }
    // }, 
    // false)

    // document.getElementById("b1").addEventListener('click', () => 
    // {
    //     let val = "b1";
    //     for (var key in fsets)        
    //     {
    //         if (key == val)
    //         {
    //             document.getElementById(fsets[key]).hidden = false;
    //         }
    //         else
    //         {
    //             document.getElementById(fsets[key]).hidden = true;
    //         }            
    //     }
    // }, 
    // false)
    // document.getElementById("b2").addEventListener('click', () => 
    // {
    //     let val = "b2";
    //     for (var key in fsets)        
    //     {
    //         if (key == val)
    //         {
    //             document.getElementById(fsets[key]).hidden = false;
    //         }
    //         else
    //         {
    //             document.getElementById(fsets[key]).hidden = true;
    //         }            
    //     }
    // }, 
    // false)
    // document.getElementById("b3").addEventListener('click', () => 
    // {
    //     let val = "b3";
    //     for (var key in fsets)        
    //     {
    //         if (key == val)
    //         {
    //             document.getElementById(fsets[key]).hidden = false;
    //         }
    //         else
    //         {
    //             document.getElementById(fsets[key]).hidden = true;
    //         }            
    //     }
    // }, 
    // false)
    // document.getElementById("b4").addEventListener('click', () => 
    // {
    //     let val = "b4";
    //     for (var key in fsets)        
    //     {
    //         if (key == val)
    //         {
    //             document.getElementById(fsets[key]).hidden = false;
    //         }
    //         else
    //         {
    //             document.getElementById(fsets[key]).hidden = true;
    //         }            
    //     }
    // }, 
    // false)
    // document.getElementById("b5").addEventListener('click', () => 
    // {
    //     let val = "b5";
    //     for (var key in fsets)        
    //     {
    //         if (key == val)
    //         {
    //             document.getElementById(fsets[key]).hidden = false;
    //         }
    //         else
    //         {
    //             document.getElementById(fsets[key]).hidden = true;
    //         }            
    //     }

    // }, 
    // false)
    // document.getElementById("b6").addEventListener('click', () => 
    // {
    //     let val = "b6";
    //     for (var key in fsets)        
    //     {
    //         if (key == val)
    //         {
    //             document.getElementById(fsets[key]).hidden = false;
    //         }
    //         else
    //         {
    //             document.getElementById(fsets[key]).hidden = true;
    //         }            
    //     }
    // }, 
    // false)
    // document.getElementById("b7").addEventListener('click', () => 
    // {
    //     let val = "b7";
    //     for (var key in fsets)        
    //     {
    //         if (key == val)
    //         {
    //             document.getElementById(fsets[key]).hidden = false;
    //         }
    //         else
    //         {
    //             document.getElementById(fsets[key]).hidden = true;
    //         }            
    //     }
    // }, 
    // false)
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


