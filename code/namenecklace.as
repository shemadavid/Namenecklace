package
{
	import com.db.pages.Necklace;
	import com.db.pages.PageEngine;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class namenecklace extends Sprite
	{
	
		public static var xmlProperties	:XML;
		
		public static var totalPages	:uint;
		public static var totalStyles	:uint;
		public static var totalColours	:uint;
		public static var totalCharms	:uint;
		public static var totalSizes	:uint;
		public static var totalEarrings	:uint;
		public static var totalChains	:uint;
		public static var pagesArray	:Array = new Array();
		public static var stylesArray	:Array = new Array();
		public static var coloursArray	:Array = new Array();
		public static var charmsArray	:Array = new Array();
		public static var earringsArray	:Array = new Array();		
		public static var sizesArray	:Array = new Array();
		public static var chainsArray	:Array = new Array();
		public static var necklace		:Necklace;
		public static var settingsArray :Array = new Array();
		public static var baseCost		:Number = new Number;
		
		
		public function namenecklace()
		{
			stage.scaleMode			= StageScaleMode.NO_SCALE;
			stage.align				= StageAlign.TOP; 
			
			
			var sitefile:String 	= "xml/site.xml";
			
			var xmlLoader:URLLoader = new URLLoader();
			
			necklace = Necklace.getInstance();			
			
			xmlLoader.addEventListener( Event.COMPLETE, xmlLoadedHandler, false, 0, true );
			xmlLoader.load( new URLRequest ( sitefile ) );
			
		}
		
		
	
		
		
		
		
		private function xmlLoadedHandler( e:Event ):void
		{
			
			
			// Load xml/site.xml into globally accessible arrays test
			
			xmlProperties			= new XML( e.target.data );
			
			var pages:XMLList		= xmlProperties.pages.page;  	
			
			totalPages				= pages.length();
			
	
			
			var item:XML;
			
			var counter:int			= 0;
			
			
			var settings:XMLList		= xmlProperties.settings;  	
			var setting: XML;
			
			for each( setting in settings )
			{
				 
				baseCost = setting.cost;
				
				
			}
			for each( item in pages )
			{
				
				var obj:Object=new Object;
				
				obj.title=item.title;				
				obj.type=item.type;    
				obj.line1=item.line1; 
				obj.line2=item.line2; 
				obj.line3=item.line3;
				obj.defaultThumb=item.defaultThumb;
				
				
				pagesArray.push(obj);        	
				
			
				
				if(obj.type=="step2")
				{	
				
					
					var s2:XMLList		= item.styles.style;
					totalStyles = s2.length();    
				
					var style:XML;  					
					for each(style in item.styles.style)
					{										
						stylesArray.push({name:style.name, id: style.id, isDefault:style.isDefault, thumb:style.thumb, cost: style.cost, earring:style.earring});
					
						if(style.isDefault=="true")
						{
								necklace.setStyle = style.name;
								
						}
					}
				
				}
				
			
				
				if(obj.type=="step3")
				{	
					
					
					var s3:XMLList		= item.styles.style;
					totalColours = s3.length();    
					
					var colour:XML;  	
	
					
					for each(colour in item.styles.style)
					{		
							
						coloursArray.push({name:colour.name, id:colour.id, isDefault:colour.isDefault, thumb:colour.thumb, cost: colour.cost, colourType:colour.colour.type, colourHex:colour.colour.hex, colourTexture:colour.colour.texture, Anchor:colour.earrings.Anchor, Star: colour.earrings.Star, Bolt: colour.earrings.Bolt, Anchor:colour.earrings.Anchor, None: colour.earrings.None });
						
						if(colour.isDefault=="true")
						{
							necklace.setColour = colour.name;
							trace(colour.name);
						}
						
						
					}
					
				}
				
				if(obj.type=="step4")
				{	
					
					
					var s4:XMLList		= item.styles.style;
					totalCharms = s4.length();    
					
					var charm:XML;  						
					
					
					for each(charm in item.styles.style)
					{		
						
						charmsArray.push({name:charm.name, id:charm.id, isDefault:charm.isDefault, thumb:charm.thumb, cost: charm.cost });
						
						if(charm.isDefault=="true")
						{
							necklace.setCharm = charm.name;
							
						}
						
					}
					
				}
				
				if(obj.type=="step5")
				{	
					
					
					var s5:XMLList		= item.styles.style;
					totalSizes = s5.length();    
					
					var size:XML;  						
					
					
					for each(size in item.styles.style)
					{		
						
						
						sizesArray.push({name:size.name, id:size.id, isDefault:size.isDefault, thumb:size.thumb, cost: size.cost });
						
						if(size.isDefault=="true")
						{
							necklace.setSize = size.name;
							
						}
						
					}
					
					
					
				}
				
				if(obj.type=="step6")
				{	
					
					
					var s6:XMLList		= item.styles.style;
					totalChains = s6.length();    
					
					var chain:XML;  						
					
					for each(chain in item.styles.style)
					{		
						
						
						chainsArray.push({name:chain.name, id:chain.id, isDefault:chain.isDefault, thumb:chain.thumb, cost: chain.cost });
						
						if(chain.isDefault=="true")
						{
							necklace.setChain = chain.name;
							
						}
						
					}
					
					
					
				}
				
				if(obj.type=="step7")
				{	
					
					
					var s7:XMLList		= item.styles.style;
					totalEarrings= s7.length();    
					
					var earring:XML;  						
					
					
					for each(earring in item.styles.style)
					{		
						
						
						earringsArray.push({name:earring.name, isDefault:earring.isDefault, thumb:earring.thumb, cost: earring.cost });
						
						if(earring.isDefault=="true")
						{
							necklace.setEarring = earring.name;
							
						}
						
					}
					
					
					
				}
				
							

			}
			necklace.setCost = baseCost;
			
			initView();
		}
		
		private function initView():void
		{
			
			
			var pageengine:PageEngine = new PageEngine();
			
			addChild( pageengine );		

		}
		
		
	
		
		
	}
}