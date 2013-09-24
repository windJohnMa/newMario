package com
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.external.ExternalInterface;
	import com.hexagonstar.util.debug.*;
	import flash.system.Security;
	import flash.utils.setTimeout;

	public class mario extends MovieClip
	{
		private var speed = 4;
		private var mro:MovieClip;
		private var leftPos:int = 45;
		private var middPos:int = 170;
		private var rightPos:int = 295;
		private var timer:Timer;
		private var timeDelay:int = 20;
		private var target:String;
		private var btnL:MovieClip;
		private var btnM:MovieClip;
		private var btnR:MovieClip;
		private var giftid = 0;
		private var str:String;
		private var closetimer:Timer;
		private var closeDelay:int = 21;//单位：秒
		//private var showTimer:Timer;
		private var showDelay = 15;//单位：分钟
		private var showTimer:Timer;
		public function mario()
		{
			flash.system.Security.allowDomain("*");
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(eve:Event)
		{
			//trace(123)
			ExternalInterface.addCallback("flashCallBack",flashCallBack);
			//ExternalInterface.addCallback("closeMario",closeMario);
			//ExternalInterface.addCallback("showMario",showMario);
			btnL = Lbtn as MovieClip;
			btnM = Mbtn as MovieClip;
			btnR = Rbtn as MovieClip;
			mro = mariao as MovieClip;
			firstRun();
			mro.addEventListener("dumped",function(){
			 run();
			});
		}
		private function firstRun()
		{
			closeMario();
			var nowDta:Date = new Date();
			var min = nowDta.minutes;
			var delay = min%15;
			if(delay==0)
			{
				showMario();
			}
			else
			{
				
				closeMario();
				showTimer = new Timer(60*1000,0);
				showTimer.addEventListener(TimerEvent.TIMER,function(){
										var nowData:Date = new Date();
										if(nowData.minutes%15==0)
										{showMario();}
									});
				setTimeout(function(){
						   			showMario();
									var timer:Timer = new Timer(15*60*1000,0);
									timer.addEventListener(TimerEvent.TIMER,function(){showMario();});
					   },(15-delay)*60*1000);
			}
		}
		private function reSet()
		{
			try
			{
				mro.x = 150;
				target = "";
				tiptxt.text = "20";
				//////////-------------------------
				closetimer.removeEventListener(TimerEvent.TIMER_COMPLETE,function(){closeMario();});
				closetimer.removeEventListener(TimerEvent.TIMER,function(){tiptxt.text = String(closeDelay-closetimer.currentCount);});
				timer.removeEventListener(TimerEvent.TIMER,timerHandle);
				btnL.removeEventListener(MouseEvent.CLICK,leftHandle);
				btnM.removeEventListener(MouseEvent.CLICK,middleHandle);
				btnR.removeEventListener(MouseEvent.CLICK,rightHandle);
				closetimer = null;
				timer = null;
				//////////-------------------------

			}
			catch (e)
			{
				//trace(e);
			}
			btnL.reset();
			btnM.reset();
			btnR.reset();
			closetimer = new Timer(1000,closeDelay);
			closetimer.start();
			closetimer.addEventListener(TimerEvent.TIMER_COMPLETE,function(){closeMario();});
			closetimer.addEventListener(TimerEvent.TIMER,function(){tiptxt.text = String(closeDelay-closetimer.currentCount-1);});
			timer = new Timer(timeDelay,0);
			timer.addEventListener(TimerEvent.TIMER,timerHandle);
			//setTimeout(function(){showMario();},showDelay*60*1000);
			//showTimer = new Timer(showDelay*60*1000,0);
			//showTimer.addEventListener(TimerEvent.TIMER,function(){showMario();});
			//showTimer.start();
			//this.closeMario();
			btnL.addEventListener(MouseEvent.CLICK,leftHandle);
			btnM.addEventListener(MouseEvent.CLICK,middleHandle);
			btnR.addEventListener(MouseEvent.CLICK,rightHandle);
			closebtn.addEventListener(MouseEvent.CLICK,function(){closeMario();});
			closebtn.buttonMode = true;
			btnL.stop();
			btnM.stop();
			btnR.stop();
			this.btnUnlock();
			timer.start();
		}
		public function closeMario()
		{
			this.visible = false;
			ExternalInterface.call("MarioHide");
		}
		public function showMario()
		{
			reSet();
			ExternalInterface.call("MarioShow");
			this.visible = true;
		}
		/*private function alert(obj:Object)
		{
			trace("收到扣费结果");
		}*/
		/*private function trace(str)
		{
			Debug.trace(str)
		}*/
		public function flashCallBack(_str:String = "操作错误")
		{
			str = _str;
			/*switch (giftid)
			{
				case 1001 :
					//gotoL();
					break;
				case 1002 :
					//gotoM();
					break;
				case 1003 :
					//gotoR();
					break;
			}*/
			showResult(giftid,str);
		}
		private function showResult(giftid,str)
		{
			switch(giftid)
			{
				case 1001:
				btnL.showResult(str);
				break;
				case 1002:
				btnM.showResult(str);
				break;
				case 1003:
				btnR.showResult(str);
				break;
				default:
				
				break;
			}
		}
		private function timerHandle(eve:TimerEvent)
		{
			if (mro.x < this.leftPos || mro.x > this.rightPos)
			{
				mro.scaleX *=  -1;
			}
			mro.x -=  speed * this.directions;
			switch (target)
			{
				case "left" :
					if (Math.abs(mro.x - this.leftPos) <= speed)
					{
						dump();
						giftid = 1001;
						sendBocai(giftid);
						btnL.gotoAndPlay(2);
						timer.stop();
						target = "";
					}
					break;
				case "middle" :
					if (Math.abs(mro.x - this.middPos) <= speed)
					{
						dump();
						giftid = 1002;
						sendBocai(giftid);
						btnM.gotoAndPlay(2);
						timer.stop();
						target = "";
					}
					break;
				case "right" :
					if (Math.abs(mro.x - this.rightPos) <= speed)
					{
						btnR.gotoAndPlay(2);
						dump();
						giftid = 1003;
						sendBocai(giftid);
						timer.stop();
						target = "";
					}
					break;
				default :
					break;
			}
		}
		private function leftHandle(eve:MouseEvent)
		{
			gotoL();
			btnLock();
		}
		private function middleHandle(eve:MouseEvent)
		{
			gotoM();
			btnLock();
		}
		private function rightHandle(eve:MouseEvent)
		{
			btnLock();
			gotoR();
		}
		private function sendBocai(giftid)
		{
			trace("向js发送博彩信息，giftid=" + giftid);
			try
			{
				ExternalInterface.call("sendBocai","mrio",giftid);
			}
			catch (e)
			{
				trace(e);
			}
			//flashCallBack();
		}
		private function gotoL()
		{
			//btnLock();
			run();
			if (Math.abs(mro.x - this.leftPos) <= 3)
			{
				timer.stop();
				btnL.gotoAndPlay(1);
				//dump();
				return;
			}
			timer.start();
			target = "left";
			mro.scaleX = 1;
		}
		private function gotoM()
		{
			run();
			//btnLock();
			timer.start();
			target = "middle";
			if (Math.abs(mro.x - this.middPos) <= 3)
			{
				timer.stop();
				btnM.gotoAndPlay(1);
				//dump();
				return;
			}
			if (mro.x > this.middPos)
			{
				mro.scaleX = 1;
			}
			if (mro.x < this.middPos)
			{
				mro.scaleX = -1;
			}
		}
		private function gotoR()
		{
			run();
			//btnLock();
			if (Math.abs(mro.x - this.rightPos) <= 3)
			{
				timer.stop();
				btnR.gotoAndPlay(1);
				//dump();
				return;
			}
			timer.start();
			target = "right";
			mro.scaleX = -1;
		}
		private function get directions()
		{
			return mro.scaleX;
		}
		private function btnUnlock()
		{
			trace("解锁");
			btnL.mouseEnabled = true;
			btnL.buttonMode = true;
			btnM.mouseEnabled = true;
			btnM.buttonMode = true;
			btnR.mouseEnabled = true;
			btnR.buttonMode = true;
		}
		private function btnLock()
		{
			trace("锁定");
			btnL.mouseEnabled = false;
			btnL.mouseChildren = false;
			btnR.mouseChildren = false;
			btnM.mouseChildren = false;
			btnL.buttonMode = false;
			btnM.mouseEnabled = false;
			btnM.buttonMode = false;
			btnR.mouseEnabled = false;
			btnR.buttonMode = false;
		}
		private function dump()
		{
			trace("dump");
			mro.gotoAndPlay(16);
		}
		private function run()
		{
			mro.gotoAndPlay("run");
		}
	}
}