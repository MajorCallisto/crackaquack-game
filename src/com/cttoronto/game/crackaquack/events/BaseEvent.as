package com.cttoronto.game.crackaquack.events
{
	import flash.events.Event;
	
	public class BaseEvent extends Event
	{
		public static const DUCK_KILL:String = "DUCK_KILL";
		public static const DUCK_SPAWN:String = "DUCK_SPAWN";
		public static const DUCK_FLAP:String = "DUCK_FLAP";
		
		public var data:Object;
		public var id:String;
		public function BaseEvent(type:String, obj:Object=null, bubbles:Boolean=false, cancelable:Boolean=false, _id:String="")
		{
			data = obj;
			if (_id){
				id = _id;
			}
			super(type, bubbles, cancelable);
		}
	}
}