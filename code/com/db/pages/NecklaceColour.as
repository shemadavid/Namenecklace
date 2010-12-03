package com.db.pages
{
	import be.viplib.util.ColorUtil;
	
	import com.greensock.*;
	import com.greensock.plugins.*;
import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.TextField;
	public class NecklaceColour extends Sprite
	{
		
		private var stroke: GlowFilter = new GlowFilter();
		private var _name		:String		= new String();
		private var _type 		:String		= new String();
		private var _colour		:Number 	= new Number();
		private var _colour2		:Number 	= new Number();
	
		
		private var	_texture	:String		= new String();
		private var _mask		:heartMC	= new heartMC();

		private var loader		:Loader 	= new Loader();
		private var _clip		:Sprite		= new Sprite();
		private var _text		:TextField 	= new TextField();
		private var _textLayer 	:Boolean	= new Boolean();
		
		
		public function NecklaceColour()
		{
			TweenPlugin.activate([TintPlugin]);
			
			stroke.alpha = 0.5;
			stroke.blurX = 1.1;
			stroke.blurY = 1.1;
			stroke.color = 0x555555;
			stroke.strength = 10;
			stroke.quality = 3;
			
		}
		


		

		public function applyColour(clip:*, name: String, first:Boolean = true, textLayer: Boolean = false, swatch:Boolean = false, charm:Boolean = false)
		{
			
			var _colourRGB	:Object		= new Object();
			
	
				_clip = clip;
			
			
			for(var i=0; i<namenecklace.totalColours;i++)
			{
		
			
				if(namenecklace.coloursArray[i].name == name)
				{
					_name 		=	namenecklace.coloursArray[i].name;
					_type 		=	namenecklace.coloursArray[i].colourType;
					_colour 	=	parseInt("0x"+namenecklace.coloursArray[i].colourHex);
					_colour2	= 	ColorUtil.brightenColor(parseInt("0x"+namenecklace.coloursArray[i].colourHex), 30);
					_texture	= 	namenecklace.coloursArray[i].colourTexture;
					_textLayer  = textLayer;
	
				}
			}	
			
			
		 
			
			switch(_type)
			{
				case "plain":
					
					
					if(_clip != null)
					{
					
						
						var rect:Rectangle = getRectangle(_clip, swatch);
						
						
						
						var fType:String = GradientType.LINEAR;
	
						var colors:Array = [ _colour2, _colour ];
						var alphas:Array = [ 1, 1 ];
						var ratios:Array = [ 0, 255 ];
						var matr:Matrix = new Matrix();
						matr.createGradientBox( rect.width, rect.height, 0, 0, 0 );
						var sprMethod:String = SpreadMethod.PAD;
						var sprite:Sprite = new Sprite();
						var g:Graphics = sprite.graphics;
						g.beginGradientFill( fType, colors, alphas, ratios, matr, sprMethod );
						
						
					
					
								if(swatch)
								{
									
									g.drawRect( rect.left-1, rect.top, rect.width+1, rect.height+1);
									
								_clip.addChild(sprite);
								sprite.mask = _clip.getChildAt(0);
								} 
								else if(charm)
								{	
									
								g.drawRect( -50, -100, 90, 200);
									
								_clip.parent.addChild(sprite);
								sprite.mask = _clip;
								
								} 
								else {
								g.drawRect( rect.left-1, rect.top, rect.width+1, rect.height);
					
								
								_clip.x = 0;
								_clip.y = 0;
								
								//_clip.parent.addChildAt(sprite, 0);
								
						
								var source:BitmapData = new BitmapData(rect.width+3,rect.height+4, true,0x00000000);
								
								var ma:Matrix=new Matrix()
								ma.tx=-rect.left;
								ma.ty=-rect.top;
					
								source.draw(_clip, ma); //draw contents of sprite to bitmpData
				
								
								
								/*
								// Creates a new transparent BitmapData (in case the source is opaque)
								var dest:BitmapData = new BitmapData(source.width,source.height,true,0x00000000);
								
								// Copies the source pixels onto it
								dest.draw(source);
								
								// Replaces all the pixels greater than 0xf1f1f1 by ransparent pixels
								dest.threshold(source, source.rect, new Point(), ">", 0xfff5f5f5,0x00000000);
								
								// And here you go ...  
								
								
								*/
							
								
								var myBitmap:Bitmap = new Bitmap(source);			
								
								
								
								myBitmap.x = rect.left-1;
								myBitmap.y = rect.top;
								
								_clip.alpha = 0;
								
								
								
								_clip.cacheAsBitmap = true;
								_clip.parent.cacheAsBitmap = true;
								sprite.cacheAsBitmap = true;
								myBitmap.cacheAsBitmap = true;
								_clip.parent.addChild(myBitmap); 
							
								
								_clip.parent.addChild(sprite);
							
	
							
									
								sprite.mask = myBitmap;
							
								
								}
						
						
				
						
					} 
					
					
					
			
							
					
					break;
				case "glitter":
					
					createTexture(_texture);
					
					break;
				case "mirror":
					createTexture(_texture);
					break;
				
			}
			
			
		
		}
		
		
		private static function RGBToHex(c:Object):uint
		{
			var ct:ColorTransform = new ColorTransform(0, 0, 0, 0, c.r, c.g, c.b, 100);
			return ct.color as uint
		}
		
		private static function hexToRGB(hex:uint):Object
		{
			var c:Object = {};
			
			c.a = hex >> 24 & 0xFF;
			c.r = hex >> 16 & 0xFF;
			c.g = hex >> 8 & 0xFF;
			c.b = hex & 0xFF;
			
			return c;
		}
		
			
		private function getRectangle(clip:Sprite, swatch:Boolean):Rectangle
		{
			if(swatch)
			{
				return clip.getBounds(this);	
			} else
			{
				return clip.getBounds(this);
			}
		}
		private function strokeIt()
		{
			//this._clip.filters = [stroke];
		}
		

		
		private function createTexture(url:String) {
			
			var request:URLRequest = new URLRequest("images/colours/glitter/"+url);			
			loader.load(request);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, drawImage);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
	
		}
		
		private function drawImage(event:Event):void {
			
			
			
			if(_clip != null)
			{
				var mySprite:Sprite = new Sprite();
				var myBitmap:BitmapData = new BitmapData(loader.width, loader.height, false);
				var rect:Rectangle = getRectangle(_clip, false);
				
				
				
				
				
				myBitmap.draw(loader, new Matrix());
				
				var matrix:Matrix = new Matrix();
				matrix.scale(0.6, 0.6);
				matrix.translate(-30, -60);
				
				var g:Graphics = mySprite.graphics;
				
				g.beginBitmapFill(myBitmap, matrix, true, true);
				
				g.drawRect(-20, -25, 600, 200);
				g.endFill();
				
				
				
				
				
				
				
				trace(_clip);
				if(_textLayer)
				{
					_clip.addChild(mySprite);
					mySprite.mask = _clip.getChildAt(0);
					
				} else {
					_clip.parent.addChild(mySprite);
					mySprite.mask = _clip;
				}

				
				//mySprite.filters = [stroke];
			}
			
		}

		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("Unable to load texture");
		}
		
	
		
	}
}