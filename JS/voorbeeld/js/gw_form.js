class GWForm
{
//==============================================================================
    constructor(options)
    {
        this.panel_id = -1;
        this.form  = document.getElementById(options.formid);
        this.ajaxpost = options.ajaxpost ? options.ajaxpost : false;
        this.form.addEventListener('submit', this, false);
        if (options.panelize)
        {
            this._panelize();
        }  
        (options.preview_img) ? this._addPreviewSystem() : this.imagefields = [];
        Array.from(this.form.getElementsByClassName('gw-toggle-password')).forEach(
           element => element.addEventListener('click', this, false)
        );
        Array.from(this.form.getElementsByClassName('gw-db-column-field')).forEach(
           element => this._addChangeObserver(element)
        );
    }
//==============================================================================   
// Public event handler, will be called for all events delegated to this class
//==============================================================================   
    handleEvent(e) 
    {
        console.log(e.type+' event for '+e.target.classList);
        switch(e.type) 
        {
            case 'click':
                if (e.target.classList.contains('gw-toggle-password'))
                {
                    this._togglePassword(e.target.getAttribute('data-gw-toggle-target'));
                    break;
                }
                if (e.target.classList.contains('gw-panel-nav-btn'))
                {
                    this._showPanelByTarget(e.target);
                    break;
                }
                break;
            case 'change':
                this._handleValueChange(e.target);
                break;
            case 'submit':
                e.preventDefault();
                if (this._validateForm())
                {
                    this._postFormData();
                }    
                break;
            
        }
    }
//==============================================================================
    _postFormData()
    {
        let data = new FormData(this.form);
        this.imagefields.forEach(imagefield => imagefield.addToFormData(data));  
        if (this.ajaxpost)
        {    
            ajaxPost(
                    URLBASE+'/AJAX/FORM/'+this.form.id, 'html',data, 
                    function (html)
                    {
                        this.imagefields.forEach(imagefield => imagefield.resetAfterPost());
                        showUserMsg(html);
                    },
                    showErrorMsg
            );        
        }
        else
        {
            ajaxPost(
                    URLBASE+'/PAGE/FORM/'+this.form.id, 'html',data, 
                    function (html)
                    {
                        document.open();
                        document.write(html);
                        document.close();
                    },
                    showErrorMsg
            );        
        }    
    }
//==============================================================================
// Toggle input-type between text (show characters)
// and password (hide characters)
//==============================================================================
    _togglePassword(id)
    {
        const input = document.getElementById(id);
        const newtype = (input.getAttribute('type')==='password')?'text':'password';
        input.setAttribute('type', newtype);
    }    
//==============================================================================
// Attach Change-value event listener to observed field,
// Set observer id to notify the observer-field 
//==============================================================================
    _addChangeObserver(element)
    {
        const observed_id = element.getAttribute('data-gw-observe-value-from');
        const observed = document.getElementById(observed_id);
// TO DO MULTIPLE OBSERVERS        
        observed.setAttribute('data-gw-observed-by', element.id);
        observed.addEventListener('change', this, false); 
    }
//==============================================================================
// Load new values for Observer when Observed value changes
//==============================================================================
    _handleValueChange(element)
    {
        const observer_id = element.getAttribute('data-gw-observed-by');
// TO DO MULTIPLE OBSERVERS        
        const observer = document.getElementById(observer_id);
        if (observer.classList.contains('gw-db-column-field'))
        {
            this._getTableColumns(observer, element.value);
        }
    }
//==============================================================================
// Get new options for TableColuns Select
// bind : succes(xx) calls populateselect(targetselect, xx)
//==============================================================================
    _getTableColumns(targetselect, tablename)
    {
        targetselect.options.length = 0;
        let succes = populateSelect.bind(null,targetselect);
        ajaxGet(
            '/AJAX/TABLECOLUMNS/'+tablename, 
            'json',
            succes,
            showErrorMsg
        );    
    }
//==============================================================================
// Inserts a button-bar above the first fieldset,
// hides all but first fieldset,
// adds click to show fieldset to buttons in button-bar
//==============================================================================
    _panelize()
    {
        //const capture = { capture : true };
        console.log('Panelizing....');
        const panels=this.form.getElementsByTagName('fieldset'); 
        if (panels.length > 0)
        {    
            const bar = document.createElement('div');
            bar.className = 'gw-panel-nav w3-bar w3-black';
            for (let i=0;i<panels.length;i++)
            {
                const legends = panels[i].getElementsByTagName('legend');
                const barbutton = document.createElement('span');
                barbutton.className = 'gw-panel-nav-btn w3-bar-item w3-button '+(i==0?'w3-white':'');
                barbutton.setAttribute('data-gw-target-fieldset', panels[i].id);
                if (legends.length > 0)
                {    
                    legends[0].style.display = 'none'; 
                    barbutton.textContent = legends[0].textContent;
                } 
                else
                {
                    barbutton.textContent = 'Panel '+i;
                }    
                barbutton.addEventListener('click', this, false);
                bar.appendChild(barbutton);
                panels[i].style.display = (i===0?'block':'none'); 
            }    
            panels[0].before(bar);
            this.haspanels = true;
        }    
        else
        {
            this.haspanels = false;
        }    
    }
//==============================================================================
// Show fieldset with target-id, hide others,
// set clicked button to active, deactivate others
//==============================================================================
    _showPanelByTarget(target)
    {
        this._showPanelByID(
                target.getAttribute('data-gw-target-fieldset')
        );
    }
//==============================================================================
    _showPanelByID(id)
    {
        Array.from(this.form.getElementsByClassName('gw-panel-nav-btn')).forEach(
            function(navbtn)
            {
                let fsid = navbtn.getAttribute('data-gw-target-fieldset');
                if (id==fsid)
                {
                    navbtn.classList.add('w3-white');
                    document.getElementById(fsid).style.display = 'block';
                }
                else
                {
                    navbtn.classList.remove('w3-white');
                    document.getElementById(fsid).style.display = 'none';
                }    
             }
        );
    }
//==============================================================================
    _disablePanelByID(id, disable)
    {
        
    }
//==============================================================================
// Adds image preview and resize canvas+buttons to img upload-fields,
// sets neeeded eventlisteners
//==============================================================================
    _addPreviewSystem()
    {
        this.imagefields = [];
        Array.from(this.form.getElementsByClassName('gw-image-upload')).forEach(
            uploadfield => this.imagefields.push(
                new GWImageLoader({
                        form     : this.form.id,   
                        source   : uploadfield.id,
                        uid      : this.form.id+this.imagefields.length,
                        maxwidth : uploadfield.getAttribute('data-gw-maxwidth'),
                                /*,
                        txt_zoomin  : txt[20],
                        txt_zoomout : txt[21],
                        txt_left    : txt[22],
                        txt_up      : txt[23],
                        txt_down    : txt[24],
                        txt_right   : txt[25],
                        txt_reset   : txt[26],
                        txt_explain : txt[27] */
                })
            )
        )    
    }
//==============================================================================
    _validateForm()
    {
        this.panel_id = -1;
        let elements = this.form.elements;
        console.log("VALIDATING");
        for (let i=0;i<elements.length;i++)
        {
            console.log("Validate "+elements[i].name);
            if (elements[i].checkValidity()===false)
            {
                console.log("Validation failed");
                if (this.haspanels)
                {            
                    let fieldset = this._getParentFieldSet(elements[i]);
                    this._showPanelByID(fieldset.id);
                }
                elements[i].reportValidity();
                return false;
            }    
        }    
        return true;
    }    
//==============================================================================
    _getParentFieldSet(element)
    {
        let parent = element.parentNode;
        if (parent.tagName==="FIELDSET")
        {
            return parent;
        }
        else
        {
            return this._getParentFieldSet(parent)
        }    
    }
}


