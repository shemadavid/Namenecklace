package com.db.pages
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	public class Chain extends Sprite
	{
		
		private var loader				:Loader 	= new Loader();
		private static var _previous		:Array  	= new Array();
		public function Chain()
		{
			
			
		}
		
		public function createChain(url:String)
		{
			for each (var binJuice:Loader in _previous)
			{
				binJuice.unload();
			}
	
			addChild(loader);
			
			var request:URLRequest = new URLRequest("images/chains/"+url);	
		
			
			loader.load(request);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, drawImage);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			
		}
		
		
		private function drawImage(event:Event):void {
				
				var necklace:Bitmap  = Bitmap(loader.content);
				necklace.smoothing = true;
				necklace.y=445;
				necklace.x=10;
			
			
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("Unable to load chain");
		}
		
	}
}