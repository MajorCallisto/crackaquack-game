package
{
	import com.cttoronto.game.crackaquack.events.BaseEvent;
	import com.cttoronto.game.crackaquack.model.DataModel;
	import com.cttoronto.game.crackaquack.view.DuckSprite;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	import flash.ui.Keyboard;
	
	[SWF(backgroundColor="#000000")]
	public class Main extends Sprite
	{
		private var duck_01:DuckSprite = new DuckSprite("green");
		private var duck_02:DuckSprite = new DuckSprite("red");
		private var duck_03:DuckSprite = new DuckSprite("yellow");
		private var duck_04:DuckSprite = new DuckSprite("magenta");
		
		private var data:DataModel = DataModel.getInstance();
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			flash.system.Security.allowDomain("*");
			data.init();
		}
		private function onAdded(e:Event):void{
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var bg:mc_bg = new mc_bg();
			addChild(bg);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKey);
			
			addChild(duck_01);
			addChild(duck_02);
			addChild(duck_03);
			addChild(duck_04);
			
//			stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		private function onClick(e:Event):void{
			
			data.dispatchEvent(new BaseEvent(BaseEvent.DUCK_FLAP, {duck_color:"green", direction:Math.random()*360}));
			data.dispatchEvent(new BaseEvent(BaseEvent.DUCK_KILL, {duck_color:"red"}));
			data.dispatchEvent(new BaseEvent(BaseEvent.DUCK_SPAWN, {duck_color:"yellow", flag_label:"Trevor"}));
		}
		private function onKey(e:KeyboardEvent):void{
			if (e.keyCode == Keyboard.F){;
				stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			}
		}
	}
}