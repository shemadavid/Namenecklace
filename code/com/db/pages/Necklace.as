package com.db.pages
{
	public class Necklace
	{
		private static var instance:Necklace;		//This will be the unique instance created by the class
		private static var isOkayToCreate:Boolean=false;	//This variable will help us to determine whether the instance can be created
	
		public var necklaceName:String = "";
		
		public var colour:String = "Baby blue";	
		public var charm:String = "Heart";			
		public var charmLocked:Boolean = false;
		public var chain:String = "Silver";
		
		private var _cost:Number = 0;
		private var _earring: String ="None";
		private var style:String = "Original";
		private var _size:String = "Standard";	
		public function Necklace()
		{
			//If we can't create an instance, throw an error so no instance is created
			if(!isOkayToCreate) throw new Error(this + " is a Singleton. Access using getInstance()");
		}
		
		//With this method we will create and access the instance of the method
		public static function getInstance():Necklace
		{
			//If there's no instance, create it	 
			if (!instance)
			{
				//Allow the creation of the instance, and after it is created, stop any more from being created
				isOkayToCreate = true;
				instance = new Necklace();
				isOkayToCreate = false;
	
			}
			return instance;
		}
		
		public function set setName(newName:String)
		{
			necklaceName = newName;
			
		}
		
		public function get getName()
		{
			return necklaceName;
			
		}
		
		public function set setStyle(newStyle:String)
		{
			style = newStyle;
			if(style=="Bloody")		
			{
				charm = "none";	
				charmLocked = true;
			} else {
				charm = "Heart";	
				charmLocked = false;
				
			}	
			
		}
		
		public function get getStyle()
		{
			return style;
			
		}
		public function set setColour(newColour:String)
		{
			colour = newColour;
			
		}
		
		public function get getSize()
		{
			return _size;
			
		}
		public function set setSize(newSize:String)
		{
			_size = newSize;
			
		}
		
		public function get getColour()
		{
			return colour;
			
		}
		
		public function set setCharm(newCharm:String)
		{
			charm = newCharm;
			
		}
		public function get getCharm()
		{
			return charm;
			
		}
		
		public function set setChain(newChain:String)
		{
			chain = newChain;
			
		}
		public function get getChain()
		{
			return chain;
			
		}
		
		
		
		public function set setEarring(newEarring:String)
		{
			_earring = newEarring;
			
		}
		public function get getEarring()
		{
			return _earring;
			
		}
		
		public function set setCost(newCost:Number)
		{
			_cost = newCost;
			
		}
		public function get getCost()
		{
			return _cost;
			
		}


	}
}
