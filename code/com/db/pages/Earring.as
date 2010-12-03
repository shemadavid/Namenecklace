package com.db.pages
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	public class Earring extends Sprite
	{
		
		private var loader				:Loader 	= new Loader();
		private static var _previous		:Array  	= new Array();
		
		public function Earring()
		{
		}
		
		
		public function createEarring(url:String)
		{
			
		
			
			for each (var binJuice:Bitmap in _previous)
			{
				try {
				removeChild(binJuice);
			
				} 
				catch(e:Error)
				{
			
				}
			}
			
			
			
			var request:URLRequest = new URLRequest("images/earrings/"+url+".jpg");	
			
			
			loader.load(request);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, drawImage);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);

		}
		
		
		private function drawImage(event:Event):void {
			
			
			loader.y=0;
			loader.x=0;
			
			var smoother_bm:Bitmap = Bitmap(loader.content);
			smoother_bm.smoothing=true;
			addChild(smoother_bm);
			loader.unload();
		
			_previous.push(smoother_bm);
			
			
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("Unable to load earring");
		}
	}
}