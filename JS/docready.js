/*
    Document Ready EventListener Example
    Geert Weggemans - M@nKind
    16-05-2022
 */
function documentReady()
{
    console.log("===== DOC READY ======");
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

