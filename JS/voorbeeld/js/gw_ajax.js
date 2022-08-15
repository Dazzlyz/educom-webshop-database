//==============================================================================
function show(element, visible)
{
    element.style.display = (visible?'block':'none');
}
//==============================================================================
function hideById(id)
{
    document.getElementById(id).style.display='none';
}
//==============================================================================
function showById(id)
{
    document.getElementById(id).style.display='block';
}
//==============================================================================
function populateSelect(targetselect, items)
{
    targetselect.options.length = 0;
    for (let i = 0; i < items.length; i++) 
    {
        let opt = document.createElement('option');
        opt.value= items[i].val;
        opt.innerHTML = items[i].txt;
        targetselect.appendChild(opt);
    }        
}
//==============================================================================
function ajaxBusy()
{
    
}
//==============================================================================
function ajaxReady()
{
    
}
//==============================================================================
function showMsg(html, error)
{
    const usermsg = document.getElementById('usermsg');
    if (error)
    {
        usermsg.classList.replace('w3-green', 'w3-red');
    }    
    else
    {
        usermsg.classList.replace('w3-red','w3-green');
    }   
    usermsg.getElementByTagName('P').innerHTML = html;
    show(usermsg,true);
}
//==============================================================================
function showErrorMsg(msg)
{
    showMsg(msg, true);
}
//==============================================================================
function showUserMsg(msg)
{
    showMsg(msg, false);
}
//==============================================================================
function makeAjaxCall(url, method, responsetype, data)
{
    const promiseObj = new Promise(function(resolve, reject)
    {
        ajaxBusy();
        const ajax = new XMLHttpRequest();
        ajax.open(method, url, true);
        ajax.responseType = responsetype;
        ajax.send(data);
        ajax.onreadystatechange = function()
        {
            if (ajax.readyState === 4)
            {
                if (ajax.status === 200)
                {
                    console.log("ajax done successfully");
                    if (responsetype==="json")
                    {
                        resolve(ajax.response); //JSON.parse(resp));
                    }
                    else
                    {
                        resolve(ajax.responseText);
                    }
                } 
                else 
                {
                    reject(ajax.status);
                    console.log("ajax failed");
                }
                ajaxReady();
            } 
            else 
            {
                console.log("ajax busy");
            }
            console.log("ajax request sent succesfully");
        };    
    });
    return promiseObj;
} 
//==============================================================================
function doAjax(url, method, responsetype, data, succes, fail)
{
    makeAjaxCall(url, method, responsetype, data).then(succes, fail);
}
//==============================================================================
async function ajaxGet(url, responsetype, succes, fail)
{
    let response = await fetch(
            url, 
            {
                method: 'GET',
            }
        );
    let result = '';   
    if (response.ok) // if HTTP-status is 200-299
    { 
        if (responsetype==='json')    
        {
            result = await response.json();
        }
        else
        {
            result = await response.text();
        } // fails (already consumed)
        succes(result);
    } 
    else
    {
        let error = await response.text();
        fail(error);
    }    
}
//==============================================================================
async function ajaxPost(url, responsetype, data, succes, fail)
{
    let response = await fetch(
            url, 
            {
                method: 'POST',
                body: data
            }
        );
    let result = '';   
    if (response.ok) // if HTTP-status is 200-299
    { 
        if (responsetype==='json')    
        {
            result = await response.json();
        }
        else
        {
            result = await response.text();
        } // fails (already consumed)
        succes(result);
    } 
    else
    {
        let error = await response.text();
        fail(error);
    }    
}


