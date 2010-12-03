package com.db.pages
{
	import com.db.pages.NecklaceColour;
	import com.db.pages.NecklaceLetter;
	
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	import flash.text.TextFormat;
	
	import com.greensock.*;
	import com.greensock.plugins.*;
	
	public class NecklaceText extends Sprite
	{
		private var _lettersArray	:Array = new Array();
		private var _totalCoord		:Number = 0;
		private var _name			:String = new String();
		private var _charmX			:Number = new Number();
		private var _charmY			:Number = new Number();
		
		private var _letterHolder:Sprite = new Sprite();
		
		public function NecklaceText()
		{
		}
		
		public function generateText(styleName:String)
		{  
		
			var _textArray:Array = namenecklace.necklace.necklaceName.split('');
			
			
	  
			PageEngine._necklaceHolder.alpha = 0;
			
			
			
			
			for (var key:String in _textArray)
			{
				var newLetter:NecklaceLetter = new NecklaceLetter();
			
				
				_name = styleName;
				
			
				
				
				if(Number(key)>0){
					_totalCoord+=_lettersArray[Number(key)-1].COORD;
				}
				
				
				newLetter.generateLetter(key, _textArray[key], _totalCoord, _name);
				
				
				_lettersArray.push(newLetter);
				
				if(_name == namenecklace.necklace.getStyle) {
					
					_letterHolder.addChild(newLetter);
				
				}
				if(Number(key)==0)
				{
					_charmX = newLetter.CHARMX;
					_charmY = newLetter.CHARMY;
				}	
				
				
			}
			
			
			
			addChild(_letterHolder);
			
			
			var newColour:NecklaceColour = new NecklaceColour();
			
			
			newColour.applyColour(_letterHolder, namenecklace.necklace.getColour, true, false);
				

			TweenLite.to(PageEngine._necklaceHolder, 0.3, {alpha: 1, delay: 0.2});
			//namenecklace.necklace.style

			
			//namenecklace.necklace.colour
		}
		
		public function generateFontText(styleName:String)
		{  
			
			
			PageEngine._necklaceHolder.alpha = 0;
			
			
			
			_charmX = 20;
			_charmY = 41;
			var myFormat:TextFormat = new TextFormat();
			var theText		:	TextField 	= new TextField();
			switch(styleName)
			{
				case "Bloody":
					var myFont:Font = new Bloody(); 
					myFormat.font = myFont.fontName;
					myFormat.letterSpacing = -5;
					break;
				case "Billboard":
					var myFont2:Font = new Billboard(); 
					myFormat.font = myFont2.fontName; 
					myFormat.letterSpacing = -3;
					myFormat.leftMargin = 10;
					break;
			}
			
			
				
				myFormat.size = 58; 				
				
			 
			
			 theText = createTextField(0, 0, 600, 80);			
			 theText.defaultTextFormat = myFormat; 			
			 theText.text = namenecklace.necklace.necklaceName;
			 theText.antiAliasType = AntiAliasType.ADVANCED; 
			 theText.embedFonts = true; 
			 theText.maxChars = 9;
			 
			
			 theText.x=25;
			 theText.y=-25;
			 
			 
			 var textHolder:Sprite = new Sprite();
			 var textHolder2:Sprite = new Sprite();
			 
			 textHolder.addChild(theText);
			 textHolder2.addChild(textHolder)
			 
			 var newColour:NecklaceColour = new NecklaceColour();
			 
			 newColour.applyColour(textHolder2, namenecklace.necklace.getColour, true, true, true);
			 
			 addChild(textHolder2);
			 TweenLite.to(PageEngine._necklaceHolder, 0.3, {alpha: 1 , delay: 0.2});
			
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

		
		public function get CHARMX()
		{
			return _charmX;
		}
		
		public function get CHARMY()
		{
			return _charmY;
		}
		
	
		
	} 
}