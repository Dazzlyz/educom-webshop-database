/* 
 */
const GW_PROP_DEL = '|';
const GW_BC_DEL = '---';

class GWBreadCrumb
{
    constructor(index, title, func, params, scrolltop, do_default) 
    {
        this.index = index;
        this.title = title;
        this.func  = func;
        this.params = params;
        this.scrolltop = scrolltop;
        this.do_default = do_default;
    }
    
    toString()
    {
        let fn = '';
        if (typeof this.func === 'function')
        {
            fn = this.func.name;
        }
        return  this.index
                +GW_PROP_DEL
                +this.title
                +GW_PROP_DEL
                + fn 
                +GW_PROP_DEL
                + (this.params ? JSON.stringify(this.params) : "")
                +GW_PROP_DEL
                +this.scrolltop
                +GW_PROP_DEL
                +this.do_default;
    }
    
    asHtml(active, mobile)
    {
        return '<span title="'+this.title+'" class="gw-breadcrumb'
                +(active?" gw-breadcrumb-active":"")
                +'" data-gw-index="'
                +this.index+'">'
                +(active&&mobile ? "&hellip;" : this.title)
                +'</span>';
    }
}

class GWBreadCrumbTrail
{
    constructor(options)
    {
        this.defaction = options.defaultaction;
        this.candodefaction = (typeof this.defaction == 'function'); 
        this.container = document.getElementById(options.container_id);
        this.clear();
    }
    
    clear()
    {
        this.breadcrumbs = [];
        return this;
    }
    
    saveTrail()
    {
        const len = this.breadcrumbs.length;
        let trail = '';
        for (let i = 0; i < len; i++) 
        {
            if (trail !== '') 
            {
                trail += GW_BC_DEL;
            }
            trail += this.breadcrumbs[i].toString();
        }
        sessionStorage.setItem("gw"+this.container, trail);
        return this;
    }
    
    loadTrail()
    {
        let trail = sessionStorage.getItem("gw"+this.container);
        if (trail)
        {
            this.breadcrumbs = [];
            const bct = trail.split(GW_BC_DEL);
            const len = bct.length;
            for (let i = 0; i < len; i++) 
            {
                const bc = bct[i].split(GW_PROP_DEL);
                if (bc.length===6)
                {
                    //console.log(bc);
                    let fn     = bc[2] ==''     ? ''    : window[bc[2]];
                    let params = bc[3] ==''     ? []    : JSON.parse(bc[3]);
                    let dd     = bc[5] =="true" ? true  : false;
                    this.breadcrumbs.push(
                        new GWBreadCrumb(bc[0], bc[1], fn, params,bc[4], dd)
                    );
                }
            }
        }
        return this;
    }
    
    showTrail()
    {
        let html = "";
        const len = this.breadcrumbs.length;
        for (let i = 0; i < len; i++) 
        {
            if (i > 0)
            {
                html += '&nbsp;&gt;&nbsp;'  //10140 #10132 ðŸ‘€
            }    
            html += this.breadcrumbs[i].asHtml(i<(len-1), window.innerWidth <= 480);
        }    
        this.container.innerHTML = html;
        this._addEventListener();
    }  
    
    addBreadCrumb(title, func, params, scrolltop=0, do_default=true)
    {
        this.breadcrumbs.push(new GWBreadCrumb(this.breadcrumbs.length, title, func, params, scrolltop,do_default));
        return this.saveTrail();
    }
    
    removeLast()
    {
        this.breadcrumbs.pop();
        return this.saveTrail();
    }
    
    handleEvent(e) 
    {
        if (e.type==="click" && e.target.classList.contains("gw-breadcrumb"))
        {
            this._breadCrumbClick(parseInt(e.target.getAttribute("data-gw-index")));
        }
    }
    
    _addEventListener()
    {
        Array.from(this.container.getElementsByClassName('gw-breadcrumb')).forEach(
           breadcrumb => breadcrumb.addEventListener("click", this, false)
        );
    }
    
    _breadCrumbClick(index)
    {
        if (index < this.breadcrumbs.length-1)
        {    
            const fn = this.breadcrumbs[index].func;
            const dd = this.breadcrumbs[index].do_default;
            if (typeof fn == 'function')
            {    
                const st = this.breadcrumbs[(index+1)].scrolltop;
                while (this.breadcrumbs.length-1 > index)
                {
                    this.breadcrumbs.pop();
                }    
                this.saveTrail().showTrail();
                if (dd && this.candodefaction) this.defaction();
                let params = this.breadcrumbs[index].params 
                            ? this.breadcrumbs[index].params
                            : [] ;
                //console.log(params);            
                //console.log(fn.name);            
                fn.apply(null,params);   
                document.documentElement.scrollTop = st;
            }    
        }    
    }
}




