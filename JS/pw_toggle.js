class PasswordToggler
{
//==============================================================================
    constructor(options)
    {
        this.pw_input = document.getElementById(options.id);
        if (this.pw_input !== null)
        {
            this.pw_input_type = this.pw_input.getAttribute('type');
            if (this.pw_input_type==='password')
            {
                this._addPasswordToggler();
            }
            else
            {
                throw new Error('Element '+options.id +' is not a password-field');
            }
        }
        else
        {
            throw new Error('Element '+options.id +' not found');
        }
    }
//==============================================================================
    handleEvent(event) 
    {
        if (event.type==='click')
        {
            this._togglePassword();
        }
        if (event.type==='keydown')
        {
            if (event.ctrlKey && event.key==='t')
            {
                this._togglePassword();
            }
        }
    }
//==============================================================================
    _togglePassWord()
    {
        this.pw_input_type = (this.pw_input_type==='password')?'text':'password';
        this.pw_input.setAttribute('type', this.pw_input_type);
    }
//==============================================================================
    _addPasswordToggler()
    {
        const pw_button = document.createElement('span');
        pw_button.innerHTML = '[&#x1F441;]';
        this.pw_input.after(pw_button);
        pw_button.addEventListener('click', this, false);
        this.pw_input.addEventListener('keydown', this, false);
    }
}


