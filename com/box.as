package com{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class box extends MovieClip {
		
		public function box() {
			// constructor code
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(eve:Event)
		{
			tip.visible = false;
			tip.mouseEnabled = false;
			//txt.visible = false;
			addEventListener(Event.ENTER_FRAME,ctrl);
			addEventListener(MouseEvent.MOUSE_OVER,over);
			addEventListener(MouseEvent.MOUSE_OUT,out);
		}
		private function over(eve:MouseEvent)
		{tip.visible = true;}
		private function out(eve:MouseEvent)
		{tip.visible = false;}
		public function showResult(str)
		{
			/*
			txt.textColor = 0x000000;
			//this.gotoAndPlay(1);
			txt.visible = true;
			txt.text = str;
			trace(txt.text)
			*/
		}
		private function ctrl(eve:Event)
		{
			if(this.currentFrame == this.totalFrames)
			{
				dispatchEvent(new Event("end"));
			}
		}
		public function reset()
		{
			this.gotoAndStop(1);
			//this.txt.visible = false;
		}
		public function resetNew() {
			this.gotoAndPlay(1);
		}
	}
	
}
