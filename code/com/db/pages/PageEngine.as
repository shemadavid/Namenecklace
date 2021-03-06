﻿package com.db.pages
{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.events.HTTPStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.display.Bitmap;
	import flash.net.URLLoaderDataFormat;
	import flash.display.Loader;
	import flash.net.navigateToURL;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;

	public class PageEngine extends Sprite
	{
		

		
		private var _container		:Sprite		= new Sprite();
		private var _slideContainer	:Sprite		= new Sprite();
		
		private var _nameInput		:TextField 	= new TextField();
		
		private var _next			:NextMC		= new NextMC();
		private var _back			:BackMC		= new BackMC();
		private var _addToBag		:AddToBag	= new AddToBag();
		
		
		private var _colourButtons 	:Array		= new Array();
	  	private var _currentSlide	:uint	    = 0;
		private var chain:Chain = new Chain(); 
		private var _buttons		:Array		= new Array();
		private var _charmButtons	:Array		= new Array();
		private var _earringsButtons:Array		= new Array();
		private var _textStrings	:Array		= new Array();
		private var _charmsArray	:Array		= new Array();
		private var _sizeButtons	:Array		= new Array();
		private var _chainButtons	:Array		= new Array();
		private	var step1			:Step1MC 	= new Step1MC();
		private	var step2			:Step2MC 	= new Step2MC();		
		private	var step3			:Step3MC 	= new Step3MC();
		private	var step4			:Step4MC 	= new Step4MC();
		private	var step5			:Step5MC 	= new Step5MC();
		private	var step6			:Step6MC 	= new Step6MC();
		private	var step7			:Step7MC 	= new Step7MC();
		private	var step8			:Step8MC 	= new Step8MC();
		
		private var _menu			:menuMC	 	= new menuMC();
		
		private	var _cost			:cost_hldr 	= new cost_hldr();
		
		private var earring:Earring = new Earring(); 
		public static var _necklaceHolder	:Sprite		= new Sprite();
		
		private var _charmAlert		:moBloodyMC = new moBloodyMC();
		
		private var _prevSize:Number  =  new Number();
		
		private var _anchorCharm		:anchorCharmMC;
		private var _starCharm		:starCharmMC;
		private var _heartCharm		:heartCharmMC; 	
		private var	_boltCharm		:boltCharmMC; 	
		public function PageEngine()
		{
		
			addEventListener( Event.ADDED_TO_STAGE, onStageHandler, false, 0, true );
			
			
		}
		
		private function onStageHandler( e:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onStageHandler );
			addEventListener(KeyboardEvent.KEY_DOWN, carriageReturn);
			var _xmlProperties		= namenecklace.xmlProperties;
			var frame:FrameMC 		= new FrameMC();
			
			_prevSize = 1;
		
			_cost.y = 54;
			_cost.x = 520;
			addChild(_cost);
			
			frame['next_mc'].visible=false;
			frame['back_mc'].visible=false;
			frame['addToBag_btn'].visible = false;
			
			_addToBag.x	= frame['addToBag_btn'].x;
			_addToBag.y	= frame['addToBag_btn'].y;
			_addToBag.alpha = 0;
			_addToBag.visible = false;
			
			
			_next.x	= frame['next_mc'].x;
			_next.y	= frame['next_mc'].y;
			_next.alpha = 0;
			_next.visible = false;
			
			_back.x	= frame['back_mc'].x;
			_back.y	= frame['back_mc'].y;
			_back.alpha = 0;
			_container.addChild(frame);
			_next.buttonMode = true;
			_container.addChild(_addToBag);
			_addToBag.buttonMode = true;
			_container.addChild(_next);			
			_back.buttonMode = true;
			_container.addChild(_back);
		
			var mainmask:Sprite = new Sprite();
			mainmask.graphics.beginFill(0x000000);
			mainmask.graphics.drawRect(5, 0, 624, 900);
			mainmask.graphics.endFill();
			
			_slideContainer.mask = mainmask;
			
			_necklaceHolder.y=405;
			_necklaceHolder.x=10;
			
			// don't forget tabs
			
			_next.addEventListener(MouseEvent.CLICK, nextSlide);
			
			_back.addEventListener(MouseEvent.CLICK, previousSlide);
			
			_addToBag.addEventListener(MouseEvent.CLICK, checkout);
			
			_menu.x= 30;
			_menu.y = 53;
			addChild(_menu);
			_container.y= -50;
			
			for(var v=1; v<namenecklace.totalPages; v++){
				setupMenu(_menu.getChildByName('step'+v+'Btn') as Sprite, v);
				
				
			}
			
			addChild( _container );
			addChild(mainmask);
			
			
			
			for(var i=0; i<namenecklace.totalPages; i++){
				generatePage(i);
			}
		
			
			this.addEventListener(MouseEvent.CLICK, priceUpdate);
			
			
		}
		
		
		private function checkout(e:MouseEvent)
		{
		
			
			
			var url:String = "http://www.tattydevine.com/boutique/product_info.php?cPath=83&products_id=987&action=add_product";
			
			var request:URLRequest = new URLRequest(url);
			
			var theVariables:String = "";
			
			
			theVariables += "id[txt_4]=" + namenecklace.necklace.getName;
			
			
		
			
			
			for ( var key in namenecklace.stylesArray )
			{
				if(namenecklace.stylesArray[key].name== namenecklace.necklace.getStyle)
				{
					theVariables += "&id[28]=" + namenecklace.stylesArray[key].id;
				}
				
			}	
			
			for ( var charm in namenecklace.charmsArray )
			{
				if(namenecklace.charmsArray[charm].name== namenecklace.necklace.getCharm)
				{
					theVariables += "&id[7]=" +  namenecklace.stylesArray[charm].id;
				}
				
			}	
			
			
			
			
			for ( var color in namenecklace.coloursArray )
			{
				if( namenecklace.coloursArray[color].name == namenecklace.necklace.getColour)
				{
					
					theVariables += "&id[18]=" + namenecklace.coloursArray[color].id;
					theVariables += "&id[30]=" + namenecklace.coloursArray[color][namenecklace.necklace.getEarring];
					
				}
				
			}	
			
			for ( var chains in namenecklace.chainsArray )
			{
				if(namenecklace.chainsArray[chains].name == namenecklace.necklace.getChain)
				{
					theVariables += "&id[10]=" + namenecklace.chainsArray[chains].id;
				}
				
			}	
			

			
			for ( var sizes in namenecklace.sizesArray )
			{
				if(namenecklace.sizesArray[sizes].name == namenecklace.necklace.getSize)
				{
					theVariables += "&id[29]=" + namenecklace.sizesArray[sizes].id;
				}
				
			}	
			
			theVariables+="&products_id=987&x=13&y=29";
			
			var requestVars:URLVariables = new URLVariables(theVariables);
			
			request.data = requestVars;
			
			request.method = URLRequestMethod.POST;
			
						
						
			var urlLoader:URLLoader = new URLLoader();
				urlLoader = new URLLoader();
				urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
				urlLoader.addEventListener(Event.COMPLETE, loaderCompleteHandler, false, 0, true);
				urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true);
				urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true);
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR, checkoutIoErrorHandler, false, 0, true);
				
			for (var prop:String in requestVars) {
				//trace("Sent: " + prop + " is: " + requestVars[prop]);
			}
			try {
				navigateToURL(request, "_blank");
			} catch (e:Error) {
				trace(e);
			}
				
		
		}
		
		private function loaderCompleteHandler(e:Event):void {
	var responseVars = URLVariables( e.target.data );
	trace( "responseVars: " + responseVars );
	
	}
	private function httpStatusHandler( e:HTTPStatusEvent ):void {
		//trace("httpStatusHandler:" + e);
	}
	private function securityErrorHandler( e:SecurityErrorEvent ):void {
		trace("securityErrorHandler:" + e);
	}
	private function checkoutIoErrorHandler( e:IOErrorEvent ):void {
		//trace("ORNLoader:ioErrorHandler: " + e);
		dispatchEvent( e );
	}
		
		
		private function setupMenu(item:Sprite, v:Number)
		{
			//this.buttonMode = true;
			
			this.addEventListener(MouseEvent.CLICK,
				function(evt:MouseEvent){menuGo(evt, v)});

			
		}
		
		private function menuGo(e:MouseEvent, v:Number) 
		{	
		
		}
		
		private function priceUpdate(e:Event)
		{
			updatePrice();
		}
		
		private function generatePage(pageNum:Number)
		{
			
		
			var imageFrame:smallFrameMC = new smallFrameMC();
			
			var imageMask:smallFrameMask = new smallFrameMask();
			imageFrame.x = 445;
			imageFrame.y = 145;
			
			
			
			
			var largeFrame:largeFrameMC = new largeFrameMC();
			
			var largeImageMask:largeFrameMask = new largeFrameMask();
			
			largeFrame.x = -130;
			largeFrame.y = 178;
		
			largeFrame.cacheAsBitmap = true;
			
			
			var largeFrameImage:ImageLoader = new ImageLoader();
			var closeButton:closeMC = new closeMC();
			largeFrameImage.createImage("images/Step"+(pageNum+1)+"/large/"+namenecklace.pagesArray[pageNum].defaultThumb);
			
			closeButton.x = 105;
			closeButton.y = -150;
			largeFrame.addChild(largeFrameImage);
			largeFrame.addChild(closeButton);
			largeFrame.visible = false;

			largeFrame.alpha = 0;
			largeFrameImage.x = -160;
			largeFrameImage.y = -200;
			largeFrameImage.mask = largeImageMask;
			largeFrame.addChild(largeImageMask);
			
			
			imageFrame.addChild(imageMask);
			var frameImage:ImageLoader = new ImageLoader();
			
			imageFrame.buttonMode = true;
			frameImage.mask = imageMask;
			
			imageFrame.cacheAsBitmap = true;
			
			frameImage.createImage("images/Step"+(pageNum+1)+"/thumb/"+namenecklace.pagesArray[pageNum].defaultThumb);
			imageFrame.addChild(frameImage);
			
			largeFrame.name = "largeFrame";
			
			imageFrame.addChild(largeFrame);
			
			
			imageFrame.addEventListener(MouseEvent.ROLL_OVER, frameHandler, false);
			imageFrame.addEventListener(MouseEvent.ROLL_OUT, frameHandler, false);
			imageFrame.addEventListener(MouseEvent.CLICK, frameHandler);
			
			switch (pageNum)
			{
				case 0:
							
					var myFont:Font = new accent(); 
					var myFormat:TextFormat = new TextFormat(); 
					myFormat.font = myFont.fontName; 
					myFormat.size = 41; 				
					myFormat.color = 0xaaaaaa;
					_nameInput = createTextField(20, 455, 600, 80);
					_nameInput.type = TextFieldType.INPUT;
					_nameInput.defaultTextFormat = myFormat; 				
					_nameInput.antiAliasType = AntiAliasType.ADVANCED; 
					_nameInput.embedFonts = true; 
					_nameInput.maxChars = 9;
					_nameInput.restrict = "a-zA-Z";
					step1.addChildAt(_nameInput,5);
					
					step1.addChildAt(imageFrame,6);
					_nameInput.text = "click to enter any name or word";
					_nameInput.addEventListener(Event.CHANGE, updateText, false);
					_nameInput.addEventListener(FocusEvent.FOCUS_IN, updateText, false);
					// Add Event Forcarriage return here for next frame
					step1.line3_txt.htmlText = "Order today for dispatch by "+ dispatchDate(14) +".";
					
					
					
					_slideContainer.addChild(step1);						
				
					break;
				
				case 1:
					
					
					step2.x = 620;					
					updateSpec();
					_slideContainer.addChild(step2);		
					step2.addChildAt(imageFrame,3);
					generateButtons(step2);
								
					break;
				
				case 2:
					
					
					step3.x = 1240;					
					updateSpec();
					step3.addChild(imageFrame);
					_slideContainer.addChild(step3);		
					generateColourButtons(step3);
					
								
					break;
				
				case 3:
					
					
					step4.x = 1860;					
					updateSpec();
					step4.addChild(imageFrame);
					_slideContainer.addChild(step4);		
					generateCharmButtons(step4);
					
					
					
					break;
				
				case 4:
					
					
					step5.x = 2480;		
					step5.addChild(imageFrame);
					updateSpec();
					_slideContainer.addChild(step5);		
					generateSizeButtons(step5);				
					
					break;
				
				case 5:				
				
					step6.x = 3100;			
					
					_slideContainer.addChild(step6);		
					generateChainButtons(step6);	
					step6.addChildAt(imageFrame,9);
					updateSpec();
					break;
					
				case 6:				
					
					step7.x = 3720;					
					_slideContainer.addChild(step7);	
				
					generateEarringButtons(step7);	
					step7.addChildAt(imageFrame,10);
					updateSpec();
					break;
					
						
				case 7:			
					
					step8.x = 4340;	
					step8.style.autoSize = TextFieldAutoSize.LEFT
					step8.orderTxt.htmlText = "Because we make it especially for you, your necklace will be ready for dispatch " + dispatchDate(14) + "."
					_slideContainer.addChild(step8);		
					break;
					
				
			
			}
			
		
			
		
			
			_container.addChild(_slideContainer);
			
		}
		
		
		
		private function frameHandler(e:MouseEvent)
		{
			switch(e.type){
				case "rollOver":
					TweenLite.to(e.target.bgBTN, 0.5, {tint: 0x000000});
				break;
				case "rollOut":
					TweenLite.to(e.target.bgBTN, 0.5, {tint: null});
				break;
				case "click":
					
					trace("clicked");
					trace(e.currentTarget.getChildByName("largeFrame"))
				try{
					if(e.currentTarget.getChildByName("largeFrame").alpha == 0) {
						
						e.currentTarget.getChildByName("largeFrame").visible = true;
						e.currentTarget.getChildByName("largeFrame").scaleX = 1;
						e.currentTarget.getChildByName("largeFrame").scaleY = 1;
						TweenLite.to(e.currentTarget.getChildByName("largeFrame"), 0.5, {alpha:1, ease:Expo.easeOut});
						
					}
					else
					{
						TweenLite.to(e.currentTarget.getChildByName("largeFrame"), 0.5, {scaleX:0.1, scaleY:0.1, alpha:0, ease:Expo.easeOut, onComplete: displayNone, onCompleteParams:[e.currentTarget.getChildByName("largeFrame")]});
						
					}
						
					
				}	
				
				catch (errObject:Error) {
				
				}
				
		
			}
				

		}
		
		private function displayNone(movie:*)
		{
			movie.visible = false;
		}
		
		

		
		private function generateEarringButtons(slide:Sprite)
		{
			for(var i=0; i<namenecklace.totalEarrings; i++)
			{
				
				var earringsButton:StyleButton = new StyleButton();
				earringsButton.createButton(i,slide[namenecklace.earringsArray[i].name+'_mc'], namenecklace.earringsArray[i].name, namenecklace.earringsArray[i].isDefault, slide[namenecklace.earringsArray[i].name+'_mc'].x, slide[namenecklace.earringsArray[i].name+'_mc'].y);  
				earringsButton.name = namenecklace.earringsArray[i].name;
				slide.addChildAt(earringsButton, 1);
				earringsButton.addEventListener(MouseEvent.CLICK, earringsHandler, false);	
				_earringsButtons.push(earringsButton);
			}
			
			
		}
		
		
		private function earringsHandler(e:MouseEvent)
		{	
			
			doEarringsChange(e.currentTarget.getChildByName(e.currentTarget.NAME), e.currentTarget.NAME )
			
		}
		
		private function doEarringsChange(currentEarring:Sprite, earringType:String){
			
			namenecklace.necklace.setEarring = earringType;
			
			
			
			for(var i=0; i<namenecklace.totalEarrings; i++)
			{
				
				
				if(_earringsButtons[i].ACTIVE == true && _earringsButtons[i].name != earringType)
				{	
					_earringsButtons[i].INACTIVE = true;
				}
	
			}
			
						var charmLC:String = namenecklace.necklace.getEarring.toLowerCase();
						
						earring.createEarring(stripspaces(namenecklace.necklace.getColour)+"_"+charmLC+"_earring");
						step7.earring_hldr.addChild(earring);
						
	
			
			
			updateSpec();
		}
		
		private function stripspaces(originalstring:String):String
		{
			var original:Array=originalstring.split(" ");
			return(original.join(""));
		}
		
		private function generateChainButtons(slide:Sprite)
		{

			
			for(var i=0; i<namenecklace.totalChains; i++)
			{
				
				var chainButton:StyleButton = new StyleButton();
				chainButton.createButton(i,slide[namenecklace.chainsArray[i].name+'_mc'], namenecklace.chainsArray[i].name, namenecklace.chainsArray[i].isDefault, slide[namenecklace.chainsArray[i].name+'_mc'].x, slide[namenecklace.chainsArray[i].name+'_mc'].y);  
				chainButton.name = namenecklace.chainsArray[i].name; 
				slide.addChildAt(chainButton, 0);
				chainButton.addEventListener(MouseEvent.CLICK, chainHandler, false);	
				_chainButtons.push(chainButton);
			}
			
			for(var j=0; j<namenecklace.totalChains; j++)
			{
				
				if(namenecklace.chainsArray[j].name == namenecklace.necklace.getChain)
				{
					
					chain.createChain(namenecklace.chainsArray[j].thumb)
					step6.addChildAt(chain, 7);
				}
			}

			
			
		}
		

		
		private function chainHandler(e:MouseEvent)
		{
			
						
				doChainChange(e.currentTarget.getChildByName(e.currentTarget.NAME) , e.currentTarget.NAME);
						
				
		
		
		}
		
		private function doChainChange(currentChain:*, chainType:String){
			
			for(var i=0; i<namenecklace.totalChains; i++)
			{
				if(_chainButtons[i].ACTIVE == true && _chainButtons[i].name != chainType)
				{
					_chainButtons[i].INACTIVE = true;
				}
				
				if(namenecklace.chainsArray[i].name == chainType)
				{
					
					chain.createChain(namenecklace.chainsArray[i].thumb)
					step6.addChildAt(chain, 7);
				}
					
					
			}
			
			
			namenecklace.necklace.setChain = chainType;
			
		
	
			updateSpec();
		}
		
		
		private function generateSizeButtons(slide:Sprite)
		{
			for(var i=0; i<namenecklace.totalSizes; i++)
			{
				
				var sizeButton:StyleButton = new StyleButton();
				sizeButton.createButton(i,slide[namenecklace.sizesArray[i].name+'_mc'], namenecklace.sizesArray[i].name, namenecklace.sizesArray[i].isDefault, slide[namenecklace.sizesArray[i].name+'_mc'].x, slide[namenecklace.sizesArray[i].name+'_mc'].y);  
				slide.addChildAt(sizeButton, 0);
				sizeButton.addEventListener(MouseEvent.CLICK, sizeHandler, false);	
				_sizeButtons.push(sizeButton);
			}
			
			
		}
		
		private function sizeHandler(e:MouseEvent)
		{
			doSizeChange(e.target.parent.parent.parent, e.target.parent.parent.parent.NAME )
	
		}
		
		private function doSizeChange(currentSize:Sprite, charmSize:String){
		
			for(var i=0; i<namenecklace.totalSizes; i++)
			{
				if(_sizeButtons[i].ACTIVE == true && _sizeButtons[i] != currentSize)
				{
					_sizeButtons[i].INACTIVE = true;
				}
			}
			
			
			namenecklace.necklace.setSize = charmSize;
			
			updateSpec();
			
			if(charmSize == "Big")
			{
				TweenLite.to(_necklaceHolder, 0.5, {scaleX:1.4, scaleY:1.4, y:400,  ease:Bounce.easeOut});
				_prevSize=1.4;


			}
			else 
			{
				TweenLite.to(_necklaceHolder, 0.5, {scaleX:1, scaleY:1, y: 415,  ease:Bounce.easeOut});
				_prevSize=1;
			}
		}
		
		private function generateCharmButtons(slide:Sprite)
		{
			for(var i=0; i<namenecklace.totalCharms; i++)
			{
				
				var charmButton:StyleButton = new StyleButton();
				charmButton.createButton(i,slide[namenecklace.charmsArray[i].name+'_mc'], namenecklace.charmsArray[i].name, namenecklace.charmsArray[i].isDefault, slide[namenecklace.charmsArray[i].name+'_mc'].x, slide[namenecklace.charmsArray[i].name+'_mc'].y);  
				charmButton.name = namenecklace.charmsArray[i].name;
			//	var newColour:NecklaceColour = new NecklaceColour();				
			//	newColour.applyColour(charmButton, namenecklace.necklace.getColour);			
				
		
				slide.addChildAt(charmButton, 0);
				charmButton.addEventListener(MouseEvent.CLICK, charmHandler, false);	
				_charmButtons.push(charmButton);
			}
			
	
		}
		
		private function updateSpec()
		{
			step2.selected_txt.text = namenecklace.necklace.getStyle;
			step3.selected_txt.htmlText = "<font color='#666666'>" + namenecklace.necklace.getStyle + " / </font><font color='#000000'>" + namenecklace.necklace.getColour + "</font>";
			step4.selected_txt.htmlText = "<font color='#666666'>" + namenecklace.necklace.getStyle + " / " + namenecklace.necklace.getColour + " / </font><font color='#000000'> Charm: " + namenecklace.necklace.getCharm + "</font>";					
			step5.selected_txt.htmlText = "<font color='#666666'>" + namenecklace.necklace.getStyle + " / " + namenecklace.necklace.getColour + " / Charm: " + namenecklace.necklace.getCharm + " / </font><font color='#000000'> Size: " + namenecklace.necklace.getSize + "</font>";	
			step6.selected_txt.htmlText = "<font color='#666666'>" + namenecklace.necklace.getStyle + " / " + namenecklace.necklace.getColour + " / Charm: " + namenecklace.necklace.getCharm + " / Size: " + namenecklace.necklace.getSize + " / </font><font color='#000000'> Chain: " + namenecklace.necklace.getChain  + "</font>";
			step7.selected_txt.htmlText = "<font color='#666666'>" + namenecklace.necklace.getStyle + " / " + namenecklace.necklace.getColour + " / Charm: " + namenecklace.necklace.getCharm + " / Size: " + namenecklace.necklace.getSize + " / Chain: " + namenecklace.necklace.getChain + " / </font><font color='#000000'>Earring: " + namenecklace.necklace.getEarring + "</font>";
			
			
			step8.style.htmlText = "&#8226; A " +namenecklace.necklace.getSize+ " size necklace in "+namenecklace.necklace.getStyle+" lettering in " +namenecklace.necklace.getColour;

			if(namenecklace.necklace.getCharm != "None"){
		
				step8.style.htmlText += "&#8226; "+namenecklace.necklace.getCharm + " charm";
			}
	
			step8.style.htmlText += "&#8226; "+namenecklace.necklace.getChain + " chain";
			if(namenecklace.necklace.getEarring != "None"){
				step8.style.htmlText += "&#8226; "+namenecklace.necklace.getEarring + " matching earrings";
			} 
	
			if(_currentSlide!=7){
				TweenLite.to(_menu.background_mc, 0.5, {x: _currentSlide*68, width:54.5 ,  ease:Expo.easeOut});
			} else {
				TweenLite.to(_menu.background_mc, 0.5, {x: (_currentSlide*68), width:124,  ease:Expo.easeOut});
			}
			
			trace(namenecklace.necklace.getColour);
			
			if(namenecklace.necklace.getColour=="Clear"){
				step7.Star_mc.visible = false;
				step7.Heart_mc.visible = false;
				step7.Hider_mc.visible = false;
			} else {
				step7.Star_mc.visible = true;
				step7.Heart_mc.visible = true;
				step7.Hider_mc.visible = true;
			}
			
			updatePrice();
			
		}
		
		
		
		private function removeCharmEventListener():void
		{
			
			for each ( var charmButton:StyleButton in _charmButtons ) {
				charmButton.removeEventListener(MouseEvent.CLICK, charmHandler);	
				charmButton.removeTheEventListener();
				
				if(charmButton.NAME=="None")
				{
					doCharmChange(charmButton, "None");
					
				}
			}
			_charmAlert.x = step4.x;
			

			_slideContainer.addChild(_charmAlert);
			
		}

		private function addCharmEventListener():void
		{
			
			for each ( var charmButton:StyleButton in _charmButtons ) {
				if(!charmButton.addEventListener(MouseEvent.CLICK, charmHandler, false)){	
					charmButton.addEventListener(MouseEvent.CLICK, charmHandler, false);	
				}
				charmButton.addTheEventListener();
			
			}
			
			
			if(_slideContainer.getChildByName(_charmAlert.name) != null){
				_slideContainer.removeChild(_charmAlert);
			}
		}
		
		
		private function charmHandler(e:MouseEvent=null)
		{
	
			doCharmChange(e.target.getChildByName(e.currentTarget.NAME),e.currentTarget.NAME);
		
			generateText();	

		}
		
		private function doCharmChange(currentCharm:Sprite, charmName:String){
		
			for(var i=0; i<namenecklace.totalCharms; i++)
			{
				
				
				if(_charmButtons[i].ACTIVE == true && _charmButtons[i].name != charmName)
				{
				
					_charmButtons[i].INACTIVE = true;
				}
			}
			
			namenecklace.necklace.charm = charmName;
			updateSpec();	
			
			
		}
		
		private function createTextField(x:Number, y:Number, width:Number, height:Number):TextField {
			var result:TextField = new TextField();
			result.x = x;
			result.y = y;
			result.width = width;
			result.height = height;
			addChild(result);
			return result;
		}

		
		private function updateText(e:Event)
		{
			namenecklace.necklace.setName = _nameInput.text;
		
			if(_nameInput.text=="click to enter any name or word")
			{
				
				var myFormat2:TextFormat = new TextFormat(); 
				
				myFormat2.size = 61; 				
				_nameInput.y = 445;
				_nameInput.defaultTextFormat = myFormat2; 		
				_nameInput.text = "";
				
					
				
			}
				

			
			if(_nameInput.text=="") {
				TweenLite.to(_next, 0.75, {alpha:0, onComplete: hide});
				
			} else {
				_next.visible=true;
				TweenLite.to(_next, 0.75, {alpha:1});
				
			}
			
			generateText();
			
		}
		
		private function hide() {
			_next.visible=false;
		}
		
		
		private function nextSlide(e:*)
		{
			
		
			if(_currentSlide<(namenecklace.totalPages-1)){
				_currentSlide++;
				TweenLite.to(_slideContainer, 0.75, {x:-618.65*_currentSlide, ease:Cubic.easeOut});
			} else 
			{
				TweenLite.to(_next, 0.75, {alpha:0});
				
			
			}
			
			if(_currentSlide>0)
			{
				TweenLite.to(_back, 0.75, {alpha:1});
		
			} else {
		
				TweenLite.to(_back, 0.75, {alpha:0});
			}
			
			if(_currentSlide != 0 && _currentSlide != 5 && _currentSlide !=6)
			{
				this["step"+(_currentSlide+1)].addChildAt(_necklaceHolder, 5);
				
			}
			if(_currentSlide ==7)
			{	
				TweenLite.to(_next, 0.25, {alpha:0, onComplete:function(){_next.visible=false;}});
				TweenLite.to(_back, 0.25, {alpha:0.5});
				
				_addToBag.visible = true;
				TweenLite.to(_addToBag, 0.25, {alpha:1});
				
				step8.earring_hldr.addChild(earring);
				step8.chain_hldr.addChild(chain);
				step8.chain_hldr.scaleX = 0.75;
				step8.chain_hldr.scaleY = 0.75;
				step8.chain_hldr.x = 130;
				step8.chain_hldr.y = 175;
				_necklaceHolder.y = step8.style.y+step8.style.height+85;
				_necklaceHolder.scaleX = 1;
				_necklaceHolder.scaleY = 1;
				_necklaceHolder.x = 10;

			} else {
				
				TweenLite.to(_addToBag, 0.25, {alpha:0, onComplete:function(){_addToBag.visible=false;}});
				
				_necklaceHolder.x = 10;	
				step7.earring_hldr.addChild(earring);
				step6.addChildAt(chain, 7);
				if(namenecklace.necklace.getSize == "Big"){
					_necklaceHolder.y = 400;
				} else {
					_necklaceHolder.y = 415;
				}
			}
			
			updateSpec();
			
		}
		
		
		private function updatePrice()
		{
			
/*
			public static var coloursArray	:Array = new Array();
			public static var charmsArray	:Array = new Array();
			public static var earringsArray	:Array = new Array();		
			public static var sizesArray	:Array = new Array();
			public static var chainsArray	:Array = new Array();
	*/
			var cost:Number = 0;
			
			for ( var key in namenecklace.stylesArray )
			{
					if(namenecklace.stylesArray[key].name== namenecklace.necklace.getStyle)
					{
						cost += Number(namenecklace.stylesArray[key].cost);
					}
			
			}	
			 
			
			
			for ( var color in namenecklace.coloursArray )
			{
				if( namenecklace.coloursArray[color].name == namenecklace.necklace.getColour)
				{
					cost += Number(namenecklace.coloursArray[color].cost);
				
				}
				
			}	
			
			for ( var chains in namenecklace.chainsArray )
			{
				if(namenecklace.chainsArray[chains].name == namenecklace.necklace.getChain)
				{
					cost += Number(namenecklace.chainsArray[chains].cost);
				}
				
			}	
			
			for ( var earrings in namenecklace.earringsArray )
			{
				if(namenecklace.earringsArray[earrings].name == namenecklace.necklace.getEarring)
				{
					cost += Number(namenecklace.earringsArray[earrings].cost);
				}
				
			}	
			
			for ( var sizes in namenecklace.sizesArray )
			{
				if(namenecklace.sizesArray[sizes].name == namenecklace.necklace.getSize)
				{
					cost += Number(namenecklace.sizesArray[sizes].cost);
				}
				
			}	
			
			
			namenecklace.necklace.setCost = namenecklace.baseCost + cost;
			_cost.total.text = "£"+truncate(namenecklace.necklace.getCost, 2);
			
		}
		
		function truncate(initial_value:Number, decimal_places:Number):String
		{
			var str_value:String = initial_value.toString();	
			var decimal_pos:Number = str_value.indexOf(".");
			
			// We use these to pad numbers that are too short.  Can have up to 20 zeroes after the decimal point.
			// Add more zeroes if you want it longer.
			var zeroes:String = "00000000000000000000";
			
			if(decimal_pos == -1)
			{
				// IF we didn't find a decimal place at all then add it along with two zeros.
				return str_value + "." + zeroes.substr(0, decimal_places);
			}
			else if(decimal_pos + decimal_places > str_value.length - 1)
			{
				// ELSE IF we did find a decimal point but there aren't enough numbers after it then add them.
				return str_value + zeroes.substr(0, decimal_pos + decimal_places - str_value.length + 1);
			}
			else if(decimal_pos + decimal_places < str_value.length - 1)
			{
				// ELSE IF we did find a decimal point but there are too many numbers after it then remove them.		
				return str_value.substr(0, decimal_pos + decimal_places);
				
				// Note that we also remove the decimal point.  If you want that then comment out the above line and uncomment this one.
				// return str_value.substr(0, decimal_pos + decimal_places + 1);
			}
			
			// ELSE the value was already in the right format so just return it.
			return str_value;
		}
		
		private function previousSlide(e:Event)
		{
			if(_currentSlide>0)
			{
				_currentSlide--;
				TweenLite.to(_slideContainer, 0.75, {x:-618.65*_currentSlide, ease:Cubic.easeOut});
			} 
			if(_currentSlide==0)
			{TweenLite.to(_back, 0.25, {alpha:0});
				
			}
		
			if(_currentSlide<(namenecklace.totalPages-1)){
				TweenLite.to(_next, 0.75, {alpha:1});
			
			} else {
				TweenLite.to(_next, 0.75, {alpha:0});
			}
			if(_currentSlide != 0 && _currentSlide != 5 && _currentSlide !=6)
			{
				this["step"+(_currentSlide+1)].addChildAt(_necklaceHolder, 5);
			}
			
			if(_currentSlide ==7)
			{	
				_addToBag.visible = true;
				TweenLite.to(_addToBag, 0.25, {alpha:1});
				step8.earring_hldr.addChild(earring);
			
				step8.chain_hldr.addChild(chain);
				step8.chain_hldr.scaleX = 0.75;
				step8.chain_hldr.scaleY = 0.75;
				step8.chain_hldr.x = 130;
				step8.chain_hldr.y = 150;
				
				_necklaceHolder.x = 10;

		
			} else {
				TweenLite.to(_addToBag, 0.25, {alpha:0, onComplete:function(){_addToBag.visible=false;}});
				_next.visible=true;
				TweenLite.to(_next, 0.25, {alpha:1, onComplete:function(){}});
				TweenLite.to(_back, 0.25, {alpha:1});
				_necklaceHolder.scaleY = _prevSize;
				_necklaceHolder.scaleX = _prevSize;
				step7.earring_hldr.addChild(earring);
				step6.addChildAt(chain, 7);
				
				step7.earring_hldr.addChild(earring);
							if(namenecklace.necklace.getSize == "Big"){
						_necklaceHolder.y = 400;
					} else {
						_necklaceHolder.y = 415;
					}
			}
			updateSpec();
		}
		
		
		
		private function carriageReturn(keyEvent:KeyboardEvent) {

			if(keyEvent.keyCode.toString() == "13")
			{
				if(_nameInput.text!="click to enter any name or word" && _nameInput.text!="")
				{
				
					nextSlide(keyEvent);
				}
			}
		}
		
		
		
		private function generateColourButtons(slide:Sprite)
		{
			var plainCounter:Number = 0;
			var fancyCounter:Number = 0;
			var colourHolder:Sprite = new Sprite();
			var stroke: GlowFilter = new GlowFilter();
			
			stroke.alpha = 0.5;
			stroke.blurX = 1.1;
			stroke.blurY = 1.1;
			stroke.color = 0x555555;
			stroke.strength = 10;
			stroke.quality = 3;

			
			
			for(var i=0; i<namenecklace.totalColours;i++)
			{
				
				
				var type:String = namenecklace.coloursArray[i].cost;
				var _highlight: buttonCircle = new buttonCircle();
				var _highlight2: buttonCircle = new buttonCircle();
						
				
				
				var _colourName:colorBubble = new colorBubble();
				_colourName.name = "p"+namenecklace.coloursArray[i].name;
				_colourName.alpha = 0;
				_colourName.color.text = namenecklace.coloursArray[i].name;
				
				
				_highlight.alpha = 0;
				_highlight2.alpha = 0
				_highlight.x = -18;
				_highlight.y = -19;
				_highlight2.x = -18;
				_highlight2.y = -19;
				
				switch(type)
				{
					
					case "0":
						
						var _colourButton:ColourButton = new ColourButton();
						_colourButton.addChild(_highlight);
						_colourButton.addChild(_highlight2);
						_colourButton.createButton(namenecklace.coloursArray[i].name, namenecklace.coloursArray[i].colourType, namenecklace.coloursArray[i].colourHex, namenecklace.coloursArray[i].colourTexture);
						_colourButton.x = plainCounter % 9 * 41;  
						_colourButton.y = Math.floor(plainCounter / 9) * 37;
						_colourButton.addEventListener(MouseEvent.CLICK, changeColour, false);
						_colourButton.addEventListener(MouseEvent.ROLL_OVER, colourOn, false);
						_colourButton.addEventListener(MouseEvent.ROLL_OUT, colourOff, false);
						_colourButton.name = namenecklace.coloursArray[i].name;
						
					
						
						if(namenecklace.coloursArray[i].name==namenecklace.necklace.getColour){
							_highlight2.alpha=1;
							
						}
						
						
						_colourName.x = plainCounter % 9 * 41;  
						_colourName.y = Math.floor(plainCounter / 9) * 37;
						_colourName.visible = false;
						colourHolder.addChild(_colourButton);
						colourHolder.addChild(_colourName);
						
						_colourButtons.push(_colourButton);
						plainCounter++;
					
						break;
					
					default:
				
						var _glitterButton:ColourButton = new ColourButton();
						_glitterButton.addChild(_highlight);
						_glitterButton.addChild(_highlight2);
						_glitterButton.createButton(namenecklace.coloursArray[i].name, namenecklace.coloursArray[i].colourType, namenecklace.coloursArray[i].colourHex, namenecklace.coloursArray[i].colourTexture);
						_glitterButton.x = fancyCounter % 10 * 41;  
						_glitterButton.y = Math.floor(fancyCounter / 10) * 37+97;
						_glitterButton.addEventListener(MouseEvent.CLICK, changeColour, false);
						_glitterButton.addEventListener(MouseEvent.ROLL_OVER, colourOn, false);
						_glitterButton.addEventListener(MouseEvent.ROLL_OUT, colourOff, false);
					
						if(namenecklace.coloursArray[i].name==namenecklace.necklace.getColour){
							_highlight2.alpha=1;
						}
						
						_glitterButton.name = namenecklace.coloursArray[i].name;
				
						
						_colourName.x = fancyCounter % 10 * 41; 
						_colourName.y = Math.floor(fancyCounter / 10) * 37+97;
						_colourName.visible = false;
					
						
						_colourButtons.push(_glitterButton);
						colourHolder.addChild(_glitterButton);		
						colourHolder.addChild(_colourName);
						
						fancyCounter++;
		
					break;
				
				
				}
					
				colourHolder.y = 200;
				colourHolder.x = 38;
				slide.addChildAt(colourHolder, 4);
			}
		}
		
		private function generateButtons(slide:Sprite) 
		{
			
		
			
			for(var i=0; i<namenecklace.totalStyles; i++)
			{
				
				var styleButton:StyleButton = new StyleButton();
				
				styleButton.createButton(i,slide[namenecklace.stylesArray[i].name+'_btn'], namenecklace.stylesArray[i].name, namenecklace.stylesArray[i].isDefault, slide[namenecklace.stylesArray[i].name+'_btn'].x, slide[namenecklace.stylesArray[i].name+'_btn'].y);  
				slide.addChildAt(styleButton,1);
				styleButton.addEventListener(MouseEvent.CLICK, clickHandler, false);	
				_buttons.push(styleButton);
			
				
				
			}
		}
		
		
		private function colourOn(e:MouseEvent)
		{
				
			TweenLite.to(e.target.getChildAt(1), 0.5, {alpha:1});
			e.currentTarget.parent.getChildByName("p"+e.currentTarget.name).visible = true;
			TweenLite.to(e.currentTarget.parent.getChildByName("p"+e.currentTarget.name), 0.4, {alpha:1,y: e.currentTarget.y+20});
	
		}
		
		private function hideIt(e:Sprite)
		{
			e.visible=false;
		}
		
		
		private function colourOff(e:MouseEvent)
		{
	
			TweenLite.to(e.target.getChildAt(1), 0.5, {alpha:0});
			trace(e.currentTarget.parent.getChildByName("p"+e.currentTarget.name));
			
			TweenLite.to(e.currentTarget.parent.getChildByName("p"+e.currentTarget.name), 0.7, {alpha:0,y: e.currentTarget.y, onComplete:hideIt, onCompleteParams:[e.currentTarget.parent.getChildByName("p"+e.currentTarget.name)]});
			
			
		
		}
		
		
		
		
		private function imagePreLoader(url:String) 
		{
			var loader:Loader = new Loader();
			var request:URLRequest = new URLRequest(url);		
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);

			loader.load(request);
		}

		
		private function changeColour(e:Event)
		{

		
			
			
			for(var i=0; i < namenecklace.totalEarrings; i++)
			{
				imagePreLoader("images/earrings/"+stripspaces(namenecklace.necklace.getColour)+"_" + namenecklace.earringsArray[i].name + "_earring.jpg");
				
				
			}
			
			for (var key in _colourButtons){
				if(e.currentTarget ==  _colourButtons[key]){
					TweenLite.to(e.target.parent.getChildAt(0), 0.5, {alpha:1});
				
				} else {
					TweenLite.to(_colourButtons[key].getChildAt(0), 0.5, {alpha:0});
					TweenLite.to(_colourButtons[key].getChildAt(1), 0.5, {alpha:0});
				}
			}
			
			var charmLC:String = namenecklace.necklace.getEarring.toLowerCase();
			
			earring.createEarring(stripspaces(namenecklace.necklace.getColour)+"_"+charmLC+"_earring");
			step7.earring_hldr.addChild(earring);

				
			generateText();
			step3.selected_txt.text = namenecklace.necklace.getStyle + " / " + namenecklace.necklace.getColour;
			step4.selected_txt.text = namenecklace.necklace.getStyle + " / " + namenecklace.necklace.getColour + " / Charm: " + namenecklace.necklace.getCharm;					
			step5.selected_txt.text = namenecklace.necklace.getStyle + " / " + namenecklace.necklace.getColour + " / Charm: " + namenecklace.necklace.getCharm + " / Size: " + namenecklace.necklace.getSize;	
			step6.selected_txt.text = namenecklace.necklace.getStyle + " / " + namenecklace.necklace.getColour + " / Charm: " + namenecklace.necklace.getCharm + " / Size: " + namenecklace.necklace.getSize + " / Chain: " + namenecklace.necklace.getChain;
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {

		}
		
		private function generateText() 
		{
			
			// garbage collection
	
			while(_textStrings.length>0)
			{
				removeChildren(_textStrings[_textStrings.length-1]);
				_textStrings.pop();
			}
			
			while(_charmsArray.length>0)
			{
				removeChildren(_charmsArray[_charmsArray.length-1]);
				_charmsArray.pop();
			}
		
			for(var i=0; i<namenecklace.totalStyles; i++)
			{
				if(namenecklace.necklace.getStyle==namenecklace.stylesArray[i].name)
				{
				
		
					var necklaceText:NecklaceText = new NecklaceText();
					var _charmHolder	:Sprite		= new Sprite();
					var dropShadow:DropShadowFilter = new DropShadowFilter();
					var dropShadow2:DropShadowFilter = new DropShadowFilter();
					
					var stroke: DropShadowFilter = new DropShadowFilter();
					
					for(var j=0; j<namenecklace.totalColours; j++)
					{					
						if(namenecklace.necklace.getColour == namenecklace.coloursArray[j].name)
						{
							var shadowColour:Number = parseInt("0x"+namenecklace.coloursArray[j].colourHex, 16);
						}
						
					}
				
					
					dropShadow.distance = 3;
					dropShadow.alpha = .6;
					dropShadow.blurX = 0;
					dropShadow.blurY = 0;
					dropShadow.angle = 162;
					dropShadow.color = shadowColour;
					
					
					dropShadow2.distance =2;
					dropShadow2.alpha = .6;
					dropShadow2.blurX = 0;
					dropShadow2.blurY = 0;
					dropShadow2.angle = 162;
					dropShadow2.color = shadowColour;
					
				
					stroke.alpha = .63;
					stroke.blurX = 1;
					stroke.blurY = 1;
					stroke.color = 0xAAAAAA;
					stroke.distance = 1;
					stroke.quality = 3;
					stroke.angle = 300;
					
					var colourName:String = namenecklace.necklace.getColour;
					
					switch(colourName)
					{
						case "White":
							dropShadow.color = 0XAAAAAA;
							necklaceText.filters = [dropShadow, dropShadow2, stroke];
							_charmHolder.filters  = [dropShadow, dropShadow2, stroke];
							break;
						case "Cream":
							dropShadow.color = 0XCECDAE;
							necklaceText.filters = [dropShadow, stroke];
							_charmHolder.filters  = [dropShadow, dropShadow2, stroke];
							break;
						case "Clear":
							dropShadow.color = 0Xe9f3f3;
							necklaceText.filters = [dropShadow, dropShadow2, stroke];
							_charmHolder.filters  = [dropShadow, dropShadow2, stroke];
							break;
						case "Mirror Silver":
							stroke.color = 0x444444;
							necklaceText.filters = [dropShadow, dropShadow2, stroke];
							_charmHolder.filters  = [dropShadow, dropShadow2, stroke];
							break;
						case "Mirror Gold":
							stroke.color = 0x444444;
							necklaceText.filters = [dropShadow, dropShadow2, stroke];
							_charmHolder.filters  = [dropShadow, dropShadow2, stroke];
							break;
						default:
							necklaceText.filters = [dropShadow, dropShadow2]; 
							_charmHolder.filters  = [dropShadow, dropShadow2]; 

							break;
						
					}
					
		
	
					necklaceText.scaleX = 1;
					necklaceText.scaleY = 1;
					
					
					
					
					
					
					
					
					_charmsArray.push(_charmHolder);
		
					if(namenecklace.stylesArray[i].name=="Original" || namenecklace.stylesArray[i].name=="Ladybug" || namenecklace.stylesArray[i].name=="Sundae")
					{
						necklaceText.generateText(namenecklace.stylesArray[i].name);
					} else {
						necklaceText.generateFontText(namenecklace.stylesArray[i].name);

					
					}
					
					_charmHolder.x=necklaceText.CHARMX+25;
				
					_charmHolder.y=necklaceText.CHARMY+10;
					_charmHolder.scaleX = 0.894;
					_charmHolder.scaleY = 0.894;
					
					
					
					
					
					if(namenecklace.necklace.charmLocked == false)
					{
						_necklaceHolder.addChild(_charmHolder);
						addCharmEventListener();
					} 
					else 
					{
						removeCharmEventListener();
					}
					
					_necklaceHolder.addChild(necklaceText);
					_textStrings.push(necklaceText);
					
					
					
					
					switch(namenecklace.necklace.getCharm)
					{
						case "Bolt":
							var _boltcharm = new boltCharmMC();
							_charmHolder.addChild(_boltcharm);
							
							break;
						case "Heart":
							var _heartCharm = new heartCharmMC();
							_charmHolder.addChild(_heartCharm);
							break;
						case "Star":
							var _starCharm = new starCharmMC();
							_charmHolder.addChild(_starCharm);
							break;
						case "Anchor":
							var _anchorCharm = new anchorCharmMC();
							_charmHolder.addChild(_anchorCharm);
							break;
						case "None":
							var _noneCharm:noneMC = new noneMC();
							_charmHolder.addChild(_noneCharm);
							
							break;
						
					}
					
					
					
					
					
					if(namenecklace.necklace.charmLocked == false)
					{
						
						var charmToColour:Sprite = _charmHolder.getChildAt(0) as Sprite;

						
						var charmColour:NecklaceColour = new NecklaceColour();
						charmColour.applyColour(charmToColour, namenecklace.necklace.getColour, true, false, false, true);
					}
				}
			}
			
			

			
			
			
			
			
			if (_currentSlide!=0)
			{
				this["step"+(_currentSlide+1)].addChildAt(_necklaceHolder, this["step"+(_currentSlide+1)].numChildren-3);
			}
		}
		
		private function clickHandler(e:MouseEvent)
		{
			
			 
			for(var i=0; i<namenecklace.totalStyles; i++)
			{
				if(_buttons[i].ACTIVE == true && _buttons[i] != e.target.parent.parent.parent)
				{
					_buttons[i].INACTIVE = true;
				}
			}
			namenecklace.necklace.setStyle = e.target.parent.parent.parent.NAME;
			
			generateText();
			updateSpec();
		}
		
		private function dispatchDate(days:Number)
		{
			var d:Date =new Date();
			d.setDate(d.getDate()+days);
			
			var month:String = String(d.getMonth()+1);
			var day:String = String(d.getDate());
			var year:String = String(d.getFullYear());
			var dispatch:String = day+"/"+month+"/"+year;
			return dispatch;
		}
		 
		private function removeChildren(clip:*):void{
			while(clip.numChildren>0){
				clip.removeChildAt(0);
			}
		}
		
	}
}