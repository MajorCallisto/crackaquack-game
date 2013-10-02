package com.cttoronto.game.crackaquack.model
{
	import com.cttoronto.mobile.crackaquack.model.DataModel;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class DataModel extends EventDispatcher
	{
		
		private static var instance:DataModel;
		private static var allowInstantiation:Boolean = true;
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

	}
}