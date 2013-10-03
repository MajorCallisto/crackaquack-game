package com.cttoronto.game.crackaquack.view
{
	import com.cttoronto.game.crackaquack.events.BaseEvent;
	import com.cttoronto.game.crackaquack.model.DataModel;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class DuckSprite extends MovieClip
	{
		private var assets_duck:mc_duck_sprite = new mc_duck_sprite();
		private var _angle:Number = 0;
		private var _distance:Number =10;
		private var last_x:Number = 0;
		private var _live:Boolean = true;
		private var _radian:Number;
		private var asset_flag:mc_flag = new mc_flag();
		private var _duck_color:String;
		private var data:DataModel;
		private var _flag_label:String;
		
		public function DuckSprite($color:String = "green"):void
		{
			super();
			if ($color){
				duck_color = $color;
			}
			data = DataModel.getInstance();
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		private function onAdded(e:Event):void{
			
			addChild(asset_flag);
			addChild(assets_duck);
			this.x = stage.fullScreenWidth>>2;
			this.y = -assets_duck.height;
			TweenMax.to(this, 1, {y: 200});
			
			data.addEventListener(BaseEvent.DUCK_FLAP, onFlap);
			data.addEventListener(BaseEvent.DUCK_SPAWN, onSpawn);
			data.addEventListener(BaseEvent.DUCK_KILL, onKill);
			if (data.randomFly == true){
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		private function onEnterFrame(e:Event):void{
			if (Math.random() < 0.1){
				angle = Math.random()*360;
			}
			flap();
		}
		private function onFlap(e:BaseEvent):void{
			if (e.data.duck_color == duck_color){
				this.angle = e.data.direction;
				flap();	
			}
		}
		private function onSpawn(e:BaseEvent):void{
			if (e.data.duck_color == duck_color){
				flag_label = e.data.flag_label;
				resurrect();
			}
		}
		private function onKill(e:BaseEvent):void{
			if (e.data.duck_color == duck_color){
				kill();	
			}
		}
		private function flap():void{
			if (live == true){
				if (alpha ==0){
					TweenMax.to(this, 1, {alpha:1});
				}
				var xstep:Number = Math.cos(radian) * distance;
				var ystep:Number = Math.sin(radian) * distance;
				
				this.x += xstep;
				this.y += ystep;
				if (this.x < assets_duck.width/2 || this.x > stage.fullScreenWidth - this.width){
					this.x -= xstep*1.1;
				}
				if (this.y < 150|| this.y >stage.fullScreenHeight-this.height/2){
					this.y -= ystep*1.1;
				}
				
				if (last_x < this.x){
					assets_duck.scaleX = -1;
				}else{
					assets_duck.scaleX = 1;
				}
				
				if (Math.random()<0.2){
					//angle = Math.random()*360;
				}
				last_x = this.x;
			}
		}
		private function onMouseUp(e:Event):void{
			kill();
		}
		private function kill():void{
			live = false;
//			angle = Math.random()*360;
			assets_duck.gotoAndStop("shot");
			TweenMax.to(this, 1.5,{ease:Linear.easeNone, onStart:setDeadSprite, delay:0.5, y:this.x + stage.stageHeight+this.height, onComplete:resurrect});
		}
		private function setDeadSprite():void{
			assets_duck.gotoAndStop("dead");
		}
		private function resurrect():void{
			live = true;
			assets_duck.gotoAndPlay(1);
			this.x = stage.stageWidth/2;
			this.y = stage.stageHeight/2;
			this.alpha = 0;
		}
		private function get live():Boolean{
			return _live;
		}
		private function set live($live:Boolean):void{
			_live = $live;
		}
		private function get angle():Number{
			return _angle;
		}
		private function set angle($angle:Number):void{
			_angle = $angle;
		}
		private function get radian():Number{
			return _angle*(Math.PI/180);
		}
		private function set radian($radian:Number):void{
			_radian = $radian;
		}
		private function get distance():Number{
			return _distance;
		}
		private function set distance($distance):void{
			_distance = $distance;
		}
		private function get duck_color():String{
			return _duck_color;
		}
		private function set duck_color($duck_color):void{
			asset_flag.gotoAndStop($duck_color);
			_duck_color = $duck_color;
		}
		private function get flag_label():String{
			return _flag_label;
		}
		private function set flag_label($label:String):void{
			_flag_label = $label;
			asset_flag.username.text = $label;
		}
	}
}