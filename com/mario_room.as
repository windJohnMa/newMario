package com
{

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.external.ExternalInterface;
	import com.hexagonstar.util.debug.*;
	import flash.system.Security;
	import flash.utils.setTimeout;
	import com.greensock.TweenLite;

	public class mario_room extends MovieClip
	{
		private var speed = 8;
		private var leftPos:int = 80;
		private var middPos:int = 205;
		private var rightPos:int = 320;
		private var timeDelay:int = 20;
		private var target:String;
		private var mro:MovieClip;	//玛丽
		private var btnL:MovieClip;	//小箱
		private var btnM:MovieClip;	//中箱
		private var btnR:MovieClip;	//大箱
		private var giftid = 0;
		private var str:String;
		private var timer:Timer;
		
		public function mario_room()
		{
			trace("坑爹啊");
			flash.system.Security.allowDomain("*");
			flash.system.Security.allowInsecureDomain("*");
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(eve:Event)
		{
			//stage.addEventListener(MouseEvent.MOUSE_MOVE,function(){resetBtn.x = mouseX;resetBtn.y = mouseY});
			if (ExternalInterface.available) {
				ExternalInterface.addCallback("flashCallBack",flashCallBack);
				ExternalInterface.call("Room.UI.bocaiProxy.init");
			}
			resetBtn.addEventListener(MouseEvent.CLICK,resetFunc);
			//resetBtn.buttonMode = true;
			btnL = Lbtn as MovieClip;
			btnM = Mbtn as MovieClip;
			btnR = Rbtn as MovieClip;
			mro = mariao as MovieClip;
			reSet();
			trace("坑爹啊");
			mro.addEventListener("dumped",function(){
			 	run();
			});
		}
		private function resetFunc(eve:MouseEvent)
		{
			reSet();
		}
		private function reSet()
		{
			try
			{
				mro.x = 260;
				target = "";
				winInfo.x = 15;
				winInfo.y = -70;
				winInfo.txt.text = "";
				//////////-------------------------
				timer.removeEventListener(TimerEvent.TIMER,timerHandle);
				btnL.removeEventListener(MouseEvent.CLICK,leftHandle);
				btnM.removeEventListener(MouseEvent.CLICK,middleHandle);
				btnR.removeEventListener(MouseEvent.CLICK,rightHandle);
				timer = null;
			}
			catch (e)
			{
				trace(e);
			}
			btnL.reset();
			btnM.reset();
			btnR.reset();
			timer = new Timer(timeDelay,0);
			timer.addEventListener(TimerEvent.TIMER,timerHandle);			
			btnL.addEventListener(MouseEvent.CLICK,leftHandle);
			btnM.addEventListener(MouseEvent.CLICK,middleHandle);
			btnR.addEventListener(MouseEvent.CLICK,rightHandle);
			btnL.stop();
			btnM.stop();
			btnR.stop();
			this.btnUnlock();
			timer.start();
		}
		/*private function alert(obj:Object)
		{
			trace("收到扣费结果");
		}*/
		private function trace(str)
		{
			Debug.trace(str)
		}
		
		//_winInfo
		//x:15 Y:32
		//x:15 Y:-70
		public function flashCallBack(_str:String = "操作错误")
		{
			str = _str;
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
			winInfo.txt.text = str;
			TweenLite.to(winInfo, 1, { y:35 } );
			resetBtn.visible = true;
		}
		
		private function showResetBtn()
		{
			
		}
		private function timerHandle(eve:TimerEvent)
		{
			if (mro.x < this.leftPos || mro.x > this.rightPos)
			{
				mro.scaleX *=  -1;
			}
			trace("direction: "+this.directions);
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
		
		private var  giftNum:int = 0;
		private function sendBocai(giftid)
		{
			trace("向js发送博彩信息，giftid=" + giftid);
			try
			{
				if (ExternalInterface.available) {
					ExternalInterface.call("Gift.Socket.sendBocaiOperation","mrio",giftid);
				}
			}
			catch (e)
			{
				trace(e);
			}
			switch(giftNum) {
				case 0:
					flashCallBack("2朵玫瑰");
					break;
				case 1:
					flashCallBack("3辆单车");
					break;
				case 2:
					flashCallBack("2辆跑车");
					break;
				case 3:
					flashCallBack("3艘航母");
					break;
				case 4:
					flashCallBack("10个么么");
					break;
				case 5:
					flashCallBack("5个猪头");
					break;
				case 6:
					flashCallBack("2个小色娃");
					break;
				case 7:
					flashCallBack("1个求婚");
					break;
			}
			if (giftNum < 7) {
				giftNum++;
			}else {
				giftNum = 0;
			}
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
			mro.width = 62;
			mro.height  104.7;
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
				mro.width = 62;
				mro.height  104.7;
			}
			if (mro.x < this.middPos)
			{
				mro.scaleX = -1;
				mro.width = 62;
				mro.height  104.7;
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
			mro.width = 62;
			mro.height  104.7;
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