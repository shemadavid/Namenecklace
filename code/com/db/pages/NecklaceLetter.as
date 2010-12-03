package com.db.pages
{
	import com.greensock.*;
	
	import flash.display.Sprite;
	
	public class NecklaceLetter extends Sprite
	{
		
		public static var _rightCoord	:Number = 0;
		
		
		
		private var _alphabetUppercase	:Array 	= new Array;
		private var _alphabetLowercase	:Array 	= new Array;
		private var _lettersUppercase	:Array 	= new Array;
		private var letterCont			:Sprite	= new Sprite();
		private var _charmX				:Number = new Number();
		private var _charmY				:Number = new Number();		
		
		
		public function NecklaceLetter() 
		{
		//	var uppercase: String = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z";
		//	var lowercase: String = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,y,v,w,x,y,z";

			
	
			
		}
		
		public function get COORD():Number
		{
			return _rightCoord;
		}
		
		public function get CHARMX():Number
		{
			return _charmX;
		}
		
		public function get CHARMY():Number
		{
			return _charmY;
		}
		
		
		public function generateLetter(position:String, letter: String, xCoord:Number, style:String)
		{
			
			
			
			
			var original:FontsMC = new FontsMC();
			var letter2:String = new String(); 
		
			
			addChild(letterCont);
			original.visible=false;
			
			letterCont.y = 0;
			letterCont.x = 25;
		
						
			letter2 = style+"_" + letter.toUpperCase();
			
			
			
			
			if(position == "0" && namenecklace.necklace.necklaceName != "" && original[letter2] != null)
			{
				
				
				
				original[letter2].x = 0;
				original[letter2].y = 0;			
				original[letter2].right_reg.visible=false;
				_rightCoord = original[letter2].right_reg.x; 
				
				
				
				if(original[letter2].charmReg != null)
				{
					
					switch(namenecklace.necklace.getStyle)
					{
						case "Original":
							_charmY 	= original[letter2].charmReg.y +5;
							
							break;
						case "Ladybug":
							_charmY 	= original[letter2].charmReg.y +5;
							
							break;
						case "Sundae":
							_charmY 	= original[letter2].charmReg.y +3;
							
							break;
				
						
						
					}
						
					
						
					_charmX 	= original[letter2].charmReg.x;
					
				} 
					
				
				
				letterCont.addChild(original[letter2]);
				
			}
		
			
			letter = style+"_"+letter;
	
		
			
			if(original[letter] != null && position != "0")
			{
				
				
				original[letter].x = 0 + xCoord;
				original[letter].y = 0;
				letterCont.addChild(original[letter]);
				original[letter].right_reg.visible=false;
				_rightCoord = original[letter].right_reg.x;
				
			}
			
			
		//	letterCont.y = -20;
		
		//TweenLite.to(letterCont, 0.2, {alpha: 1,y: 0 , delay: (0.1*Number(position)+0.1)});
			
				
		}
		
	}
}