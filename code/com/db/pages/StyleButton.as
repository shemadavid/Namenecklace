package com.db.pages
{
	import com.greensock.*;
	import com.greensock.plugins.*;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class StyleButton extends Sprite
	{
		public var _name		:String = new String();
		public var theCharm		:Sprite = new Sprite();
		
		private var _graphic 	:MovieClip;
		
		private var _active		:Boolean = false;
		
	
		
		public function StyleButton() 
		{
			TweenPlugin.activate([TintPlugin]);
		}
		
		public function get NAME():String
		{
			return _name;
		}
		
		public function get ACTIVE():Boolean
		{
			return _active;
		}
		
		public function set INACTIVE(value:Boolean)
		{
			_active = false;
			inactive();
			
		}
		
		public function createButton(id:Number, buttonMC:MovieClip, name:String, isDefault:String, xCoord:Number, yCoord: Number)
		{
			addChild(buttonMC);
			this.buttonMode = true;
			_name = name;
			_graphic = buttonMC;
			theCharm = buttonMC.charm_MC;
			
			if(isDefault=="true")
			{
				_active = true;
				TweenLite.to(_graphic.bg_mc.frame_mc, 0.25, {tint:0x000000});
				TweenLite.to(_graphic.bg_mc.back_mc, 0.25, {tint:0xF4F4F4});
				
			}
			
		
			
			addEventListener(MouseEvent.CLICK, updateStyle);
			addEventListener(MouseEvent.ROLL_OVER, buttonOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, buttonOutHandler);
		}
		
		public function removeTheEventListener():void
		{
			removeEventListener(MouseEvent.CLICK, updateStyle);
			removeEventListener(MouseEvent.ROLL_OVER, buttonOverHandler);
			removeEventListener(MouseEvent.ROLL_OUT, buttonOutHandler);
		}
		
		public function addTheEventListener():void
		{
			addEventListener(MouseEvent.CLICK, updateStyle);
			addEventListener(MouseEvent.ROLL_OVER, buttonOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, buttonOutHandler);
		}
		
		private function updateStyle(e:Event)
		{
			
			TweenLite.to(_graphic.bg_mc.frame_mc, 0.25, {tint:0x000000});
			TweenLite.to(_graphic.bg_mc.back_mc, 0.25, {tint:0xF4F4F4});
			_active = true;
		}
		
		private function buttonOverHandler(e:MouseEvent)
		{	
			
			TweenLite.to(_graphic.bg_mc.frame_mc, 0.25, {tint:0x000000});
			
		}
		
		private function buttonOutHandler(e:MouseEvent)
		{
			if(!_active)
			{
				TweenLite.to(_graphic.bg_mc.frame_mc, 0.25, {tint:0xFFFFFF});
			}	
		}
		
		private function inactive()
		{
		
			TweenLite.to(_graphic.bg_mc.back_mc, 0.25, {tint:0xFFFFFF});
		}
		
	}
}