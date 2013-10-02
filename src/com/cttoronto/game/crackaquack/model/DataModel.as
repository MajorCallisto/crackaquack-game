package com.cttoronto.game.crackaquack.model
{
	import com.cttoronto.game.crackaquack.events.BaseEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.external.ExternalInterface;
	
	public class DataModel extends EventDispatcher
	{
		
		private static var instance:DataModel;
		private static var allowInstantiation:Boolean = true;
		private var _randomFly:Boolean = true;
		
		public function DataModel(target:IEventDispatcher=null)
		{
			super(target);
		}
		public static function getInstance() : DataModel
		{
			if (DataModel.instance == null)
			{
				DataModel.instance = new DataModel();
				allowInstantiation = false;
			}
			return DataModel.instance;
		}// end function
		public function init():void{
			ExternalInterface.addCallback("JSMessage", JSMessage);
		}
		public function JSMessage($msg:Object):void{
			var be:BaseEvent = new BaseEvent($msg.event_type);
			be.data = $msg.event_obj;
			dispatchEvent(be);
			trace("JSMESSAGE", $msg.event_obj.direction);
		}

		public function get randomFly():Boolean
		{
			return _randomFly;
		}

		public function set randomFly(value:Boolean):void
		{
			_randomFly = value;
		}

		/*
		JSMessage({event_type:"DUCK_FLAP", 
		event_obj:{direction:35, duck_color:"green"}});
		JSMessage({event_type:"DUCK_KILL", 
		event_obj:{duck_color:"magenta"}});
		JSMessage({event_type:"DUCK_SPAWN", 
		event_obj:{duck_color:"green", flag_label:"Peter"}});
		*/
	}
}