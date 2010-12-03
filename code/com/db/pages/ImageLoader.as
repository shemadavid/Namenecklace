package com.db.pages
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	public class ImageLoader extends Sprite
	{
		
		private var loader				:Loader 	= new Loader();
		private static var _previous		:Array  	= new Array();
		
		public function ImageLoader()
		{
		}
		
		
		public function createImage(url:String)
		{
			for each (var binJuice:Loader in _previous)
			{
				binJuice.unload();
			}
			
			
			
			var request:URLRequest = new URLRequest(url);	
			
			
			loader.load(request);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, drawImage);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			
		}
		
		
		private function drawImage(event:Event):void {
			
	
			loader.y=0;
			loader.x=0;
			addChild(loader);
			var smoother_bm = Bitmap(loader.content);
			smoother_bm.smoothing=true;
			_previous.push(loader);
			
			
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("Unable to load image");
		}
	}
}