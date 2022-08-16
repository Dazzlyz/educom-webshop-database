const INTERVAL = 25;
const OVERLAY_X = 450;
const OVERLAY_Y = 300;

class GWImageLoader
{
//==============================================================================
    constructor(options)
    {
        this.action_repeater = null;
        this.imageisloaded = false;
        this.form         = document.getElementById(options.form);
        this.upload_field = document.getElementById(options.source);
        this.interval     = options.interval?options.interval:INTERVAL; 
        this.overlay_x    = options.maxwidth?options.maxwidth:OVERLAY_X; 
        this.overlay_y    = options.maxheight?options.maxheigh:OVERLAY_Y; 
       
        this.cropcontainer   = document.createElement('div');  	 
        this.cropcontainer.id = options.uid;
        this.cropcontainer.style.overflow = 'hidden';
        this.cropcontainer.innerHTML = this._createHtml(options).replace(/xUIDx/g, options.uid);
        this.upload_field.before(this.cropcontainer);
        this.explain      = document.getElementById("explain_"+options.uid);  
     	this.overlay      = document.getElementById("img_overlay_"+options.uid);
     	this.preview_div  = document.getElementById("img_preview_container_"+options.uid);
	this.preview_img  = document.getElementById("upload_image_preview_"+options.uid);
	this.canvas 	  = document.getElementById("image_to_upload_"+options.uid);
        this.croptoolbar  = document.getElementById("crop_toolbar_"+options.uid); 
        this._hide(this.croptoolbar);
        this.reader = new FileReader();
        this.upload_field.addEventListener('change', this, false);
	this.reader.addEventListener('load', this, false);
        Array.from(this.croptoolbar.getElementsByClassName('img-action')).forEach(
           button => button.addEventListener("click", this, false)
        );
        Array.from(this.croptoolbar.getElementsByClassName('img-repeat')).forEach(
           button => button.addEventListener("mousedown", this, false)
        );
        Array.from(this.croptoolbar.getElementsByClassName('img-repeat')).forEach(
           button => button.addEventListener("mouseup", this, false)
        );
    }
//==============================================================================   
    handleEvent(e) 
    {
        switch(e.type) 
        {
            case "change":
                this._handleFileUpload(e.target.files[0]);
                break;
            case "click":
                if (e.target.classList.contains("img-action"))
                {
                    this._imageAction(e.target.getAttribute("data-gw-action"));
                }
		break;
            case "load":
                this._imageLoaded(e);
                break;
            case "mousedown":
                if (e.target.classList.contains("img-repeat"))
                {
                    this._startAction(e.target.getAttribute("data-gw-action"));
                }
                break;
            case "mouseup":
                if (e.target.classList.contains("img-repeat"))
                {
                    this._stopAction();
                }
                break;
        }
    }
//==============================================================================
    resetAfterPost()
    {
//        this.form.reset();
        this._hide(this.explain);
        this._hide(this.canvas);
        this._hide(this.preview_div);
        this._hide(this.croptoolbar);
        this._show(this.upload_field);
        this.imageisloaded = false;
    }
//==============================================================================
    getFormData()
    {
        let result = new FormData(this.form);
        if (this.imageisloaded)
        {
            if (this.canvas.style.display !=="block")
            {    
                this._saveSelectionToCanvas();
            }    
            result.delete(this.upload_field.name);
            let dataURL = this.canvas.toDataURL(); //default is png 'image/jpeg', 0.5);
            const imageblob = this._dataURItoBlob(dataURL);
            result.append(this.upload_field.name, imageblob, "sig.png");//"jpg");
//console.log("Cropped Image Appended");
            this._clearCanvas();
        }    
        return result;
    }
//==============================================================================
    addToFormData(formdata)
    {
        if (this.imageisloaded)
        {
            if (this.canvas.style.display !=="block")
            {    
                this._saveSelectionToCanvas();
            }    
            formdata.delete(this.upload_field.name);
            let dataURL = this.canvas.toDataURL(); //default is png 'image/jpeg', 0.5);
            const imageblob = this._dataURItoBlob(dataURL);
            formdata.append(this.upload_field.name, imageblob, "sig.png");//"jpg");
//console.log("Cropped Image Appended");
            this._clearCanvas();
        }    
    }
//==============================================================================
    _clearCanvas()
    {
        const context = this.canvas.getContext('2d');
        context.clearRect(0, 0, this.canvas.width, this.canvas.height);
    }
//==============================================================================
    _dataURItoBlob (dataURI) 
    {
    // convert base64/URLEncoded data component to raw binary data held in a string
        let byteString;
        if (dataURI.split(',')[0].indexOf('base64') >= 0)
            byteString = atob(dataURI.split(',')[1]);
        else
            byteString = unescape(dataURI.split(',')[1]);

        // separate out the mime component
        const mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];

        // write the bytes of the string to a typed array
        let ia = new Uint8Array(byteString.length);
        for (let i = 0; i < byteString.length; i++) {
            ia[i] = byteString.charCodeAt(i);
        }
        return new Blob([ia], {type: mimeString});
    }
//==============================================================================
    _handleFileUpload(file)
    {
        const imagefile = file.type;
        const match= ["image/jpeg","image/png","image/jpg"];
        if(!((imagefile==match[0]) || (imagefile==match[1]) || (imagefile==match[2])))
        {
            alert('Please Select a valid Image File (jpg/png');
            return false;
        }
        else
        {
            this.reader.readAsDataURL(file);
        }
    }
//==============================================================================
    _imageLoaded(e)
    {
        this.preview_img.src = null; 
        this.preview_img.src = e.target.result;
        this.action_repeater = setInterval(this._checkComplete.bind(this),this.interval);
    }    
//==============================================================================
    _checkComplete()
    {
        if (this.preview_img.complete) 
        {
            this._stopAction();
            this._hide(this.upload_field);
            this._show(this.preview_img);
            this.aspect_ratio = this.preview_img.naturalHeight/this.preview_img.naturalWidth;
            this._show(this.explain);
            this._show(this.preview_div);
            this._show(this.croptoolbar);
            this._enableButtons(true);
            this._hide(this.canvas);
            this.imageisloaded = true;
        }    
    }
//==============================================================================
    _saveSelectionToCanvas()
    {
        const ctx    = this.canvas.getContext('2d');
        if (this.preview_img.naturalWidth < this.overlay_x)
        {
            ctx.drawImage(this.preview_img,
                            0,0,
                            this.preview_img.naturalWidth,
                            this.preview_img.naturalHeight,
                            0,0,
                            this.overlay_x,
                            Math.floor(this.overlay_x*this.aspect_ratio));
//console.log("r="+this.aspect_ratio);                            
//console.log("nw="+this.preview_img.naturalWidth+ ' nh='+this.preview_img.naturalHeight);  
//console.log("sw="+OVERLAY_X+ ' sh='+Math.floor(OVERLAY_X*this.aspect_ratio));                                
        }   
        else
        {    
            const deltax = this.preview_img.naturalWidth/this.preview_img.width;
            const deltay = this.preview_img.naturalHeight/this.preview_img.height;
            const startx = this.preview_img.offsetLeft*(-1);
            const starty = this.preview_img.offsetTop*(-1);
//console.log(startx+' '+starty);
            ctx.drawImage(this.preview_img,
                        Math.floor(startx*deltax), 
                        Math.floor(starty*deltay), 
                        Math.floor(this.overlay_x*deltax), 
                        Math.floor(this.overlay_y*deltay), 0, 0, this.overlay_x, this.overlay_y);
        }    
    }
//==============================================================================
    _imageAction(image_action)
    {
        if (image_action==='save')
        {
            this._saveSelectionToCanvas();
            this._hide(this.preview_div);
            this._show(this.canvas);
            this._enableButtons(false);
        }    
        else if (image_action==='reset')
        {
            this.preview_img.width  = this.preview_img.naturalWidth;
            this.preview_img.height = this.preview_img.naturalHeight;
            this.preview_img.style.left = 0;
            this.preview_img.style.top  = 0;
            this._show(this.preview_div);
            this._hide(this.canvas);
            this._show(this.upload_field);
            this._enableButtons(true);
        }    
    }
//==============================================================================
    _startAction(image_action)
    {
        this.movex = 0; 
        this.movey = 0;
        let move = true;
        switch (image_action)
        {
            case "left"   : this.movex = -2; break;
            case "right"  : this.movex = 2; break;
            case "up"     : this.movey = -2; break;
            case "down"   : this.movey = 2; break;
            case "grow"   : move = false; this.sizex = 4; break;
            case "shrink" : move = false; this.sizex = -4; break;
        }
        if (move)
        {    
            this.action_repeater = setInterval(this._move.bind(this),this.interval);
        }    
        else
        {
            this.action_repeater = setInterval(this._resize.bind(this),this.interval);
        }
    }
//==============================================================================
    _stopAction()
    {
        //console.log("STOP");
        if (this.action_repeater !== null)
            clearInterval(this.action_repeater);
    }    
//==============================================================================
    _move()
    {
        if (this.movex !== 0)
        {    
            const newx = this.preview_img.offsetLeft+this.movex;
            //if (/*newx <= 0 &&*/ (newx+this.preview_img.width) >= OVERLAY_X)
            this.preview_img.style.left = newx+'px';
        }    
        if (this.movey !== 0)
        {    
            const newy = this.preview_img.offsetTop+this.movey;
            if (newy <= 0 && (newy+this.preview_img.height) >= this.overlay_y)
                this.preview_img.style.top = newy+'px';
        }    
    }
//==============================================================================
    _resize()
    {
        const neww = this.preview_img.width+this.sizex;
        const newh = Math.floor(neww*this.aspect_ratio);
        //console.log("ar="+this.aspect_ratio+"neww="+neww+ ' newh='+newh);  
        const canresize = (this.preview_img.offsetLeft+neww >= this.overlay_x)
                      || (this.preview_img.offsetTop+newh >= this.overlay_y);
        if (canresize)
        {
            this.preview_img.width  =  neww;
            this.preview_img.height =  newh;
        }
    }
//==============================================================================
    _show(el)
    {
        el.style.display = 'block';
    }
//==============================================================================
    _hide(el)
    {
        el.style.display = 'none';
    }
//==============================================================================
    _enableButtons(enable)
    {
        Array.from(this.croptoolbar.getElementsByClassName('btn')).forEach(
           button => button.disabled = (enable===false && button.getAttribute("data-gw-action") !== 'reset')
        );
    }
//==============================================================================
    _createHtml(options)
    {
return '  <canvas id="image_to_upload_xUIDx" style="display:none" width="'+this.overlay_x+'" height="'+this.overlay_y+'"></canvas>'
+'  <p id="explain_xUIDx" style="display:none">'+(options.txt_explain?options.txt_explain:'Het geel omkaderde gebied wordt gebruikt als afbeelding')+'</p>'
+'  <div id="img_preview_container_xUIDx" style="display:none;position:relative;width:100%;min-height:'+(this.overlay_y+100)+'px;max-height:'+(this.overlay_y+100)+'px;overflow:hidden;">'
+'    <img id="upload_image_preview_xUIDx" style="position:relative;left:0px;top:0px; alt="empty" src="./images/default/empty.jpg" />'
+'    <div id="img_overlay_xUIDx" style="display:inline-block;background:transparent;'
+'position:absolute;left:0;top:0;width:'+this.overlay_x+'px;height:'+this.overlay_y+'px;z-index:1000;border:2px solid yellow;"></div>'
+'  </div>'
+'  <div id="crop_toolbar_xUIDx" class="w3-bar w3-black" role="toolbar" aria-label="Crop Image Toolbar">'
+'          <span data-gw-action="grow" class="img-repeat w3-bar-item w3-button">'
+(options.txt_zoomin?options.txt_zoomin:'Zoomin')+'</span>'
+'          <span data-gw-action="shrink" class="img-repeat w3-bar-item w3-button">'
+(options.txt_zoomout?options.txt_zoomout:'Zoomout')+'</span>'
+'          <span data-gw-action="left"   class="img-repeat w3-bar-item w3-button">'
+(options.txt_left?options.txt_left:'Left')+'</span>'
+'          <span data-gw-action="right"  class="img-repeat w3-bar-item w3-button">'
+(options.txt_right?options.txt_right:'Right')+'</span>'
+'          <span data-gw-action="up"     class="img-repeat w3-bar-item w3-button">'
+(options.txt_up?options.txt_up:'Up')+'</span>'
+'          <span data-gw-action="down"   class="img-repeat w3-bar-item w3-button">'
+(options.txt_down?options.txt_down:'Down')+'</span>'
+'          <span data-gw-action="reset" class="img-action w3-bar-item w3-button">'
+(options.txt_reset?options.txt_reset:'Reset')+'</span>'
//+'          <button type="button" data-gw-action="save"  class="img-action btn btn-secondary">'
//+(options.txt_save?options.txt_save:'Crop')+'</button>'
+'</div>';                

    }
}		
//==============================================================================


