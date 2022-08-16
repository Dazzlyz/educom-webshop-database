function formalize()
{
	document.getElementById('formalize').setAttribute('disabled', true);
	const gwform = new GWForm({
        formid:"4711",
        ajaxpost:false,
        panelize:true,
        preview_img:true
    });
}

function documentReady()
{
    console.log("===== DOC READY ! ======");
	document.getElementById('formalize').addEventListener('click', formalize);
}

