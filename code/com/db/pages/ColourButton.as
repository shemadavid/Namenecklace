package com.db.pages
{
	import com.db.pages.NecklaceColour;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	
	public class ColourButton extends Sprite
	{
		private var _name		:String		= new String();
		private var _type 		:String		= new String();
		private var _colour		:String		= new String();
		private var	_texture	:String		= new String();
		public var _shape		:heartMC	= new heartMC();
		private var _bg			:heartBackMC = new heartBackMC();
		
		public function ColourButton()
		{
		}
		
		public function createButton(name:String, type:String, colour, texture: String = "")
		{
			_name = name;
			_type = type;
			_colour = colour;
			_texture = texture;
			
			
			addChild(_bg);
			
			this.buttonMode = true;
			var newColour:NecklaceColour = new NecklaceColour();
			
			newColour.applyColour(_shape, _name, true, false, true);			
			addChild(_shape);
			
			this.addEventListener(MouseEvent.CLICK, updateColour);
						
		}
		
				
		public function get NAME():String
		{
			return _name;
		}
		
		public function get TYPE():String
		{
			return  _type;
		}
		
		public function get COLOUR():String
		{
			return _colour;
		}
		
		public function get TEXTURE():String
		{
			return _texture;
		}
		
		private function updateColour(name: String)
		{
			namenecklace.necklace.setColour = _name;
		}
		
		
	}
}