package
{

	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.media.SoundLoaderContext;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	import flash.utils.setTimeout;
	import com.greensock.TweenLite;
	import flash.system.LoaderContext;
	import bmhBase.woo.Debug;

	public class main extends MovieClip
	{
		private var speed = 6;
		private var leftPos:int = 80;
		private var middPos:int = 205;
		private var rightPos:int = 320;
		private var timeDelay:int = 20;
		private var target:String;
		private var mro:MovieClip;	//玛丽
		private var btnL:MovieClip;	//小箱
		private var btnM:MovieClip;	//中箱
		private var btnR:MovieClip;	//大箱
		private var soundMC:MovieClip;	//声音
		private var isSound:Boolean = true;
		private var giftid = 0;
		private var str:String;
		
		private var isErr:Boolean = false;
		private var errTimer:Timer = new Timer(3500, 1);
		
		private var loader:Loader
		private var loadURL:URLRequest;
		
		private var jumpStr:String = "http://static.show.baomihua.com/flash/bocai/music/jump.mp3";
		private var bgStr:String = "http://static.show.baomihua.com/flash/bocai/music/bg.mp3";
		private var url:String = "http://static.show.baomihua.com/flash/bocai/gift.swf";
		/*
		private var url:String = "gift.swf";
		private var jumpStr:String = "music/jump.mp3";
		private var bgStr:String = "music/bg.mp3";
		*/
		private var giftObj:Object;
		private var lockRun:Boolean = true;
		
		//音乐
		private var soundJump:Sound;
		private var soundBG:Sound;
		private var jumpURL:URLRequest;
		private var bgURL:URLRequest;
		private var channel:SoundChannel;
		
		
		public function main()
		{
			flash.system.Security.allowDomain("*");
			flash.system.Security.allowInsecureDomain("*");
			loadGift();
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function loadGift():void {
			loader = new Loader();
			loadURL = new URLRequest(url);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoaderError);
			loader.load(loadURL, new LoaderContext(true));
			this.addChild(loader);
		}
		
		private function onComplete(evt:Event):void {
			trace("加载礼物成功");
			Debug.trace("幸运玛丽", "---加载礼物完成---");
			giftObj = loader.content;
		}
		
		private function onLoaderError(evt:IOErrorEvent):void {
			trace("加载礼物出错");
			Debug.trace("幸运玛丽", "---加载礼物出错---");
		}
		
		private function init(eve:Event)
		{
			initMusic();
			if (ExternalInterface.available) {
				ExternalInterface.addCallback("flashCallBack",flashCallGift);
				ExternalInterface.call("Room.UI.bocaiProxy.init");
			}
			resetBtn.addEventListener(MouseEvent.CLICK, resetFunc);
			//resetBtn.buttonMode = true;
			btnL = Lbtn as MovieClip;
			btnM = Mbtn as MovieClip;
			btnR = Rbtn as MovieClip;
			soundMC = soundMc as MovieClip;
			soundMC.addEventListener(MouseEvent.MOUSE_OVER, soundOver);
			soundMC.addEventListener(MouseEvent.MOUSE_OUT, soundOut);
			soundMC.addEventListener(MouseEvent.CLICK, soundChange);
			mro = mariao as MovieClip;
			reSet();
			mro.addEventListener("dumped",function(){
			 	run();
			});
		}
		
		private function initMusic():void {
			jumpURL = new URLRequest(jumpStr);
			soundJump = new Sound(jumpURL, new SoundLoaderContext(1000, true));
			soundJump.addEventListener(Event.COMPLETE, soundComplete);
			trace("isBuffer: "+soundJump.isBuffering);
			bgURL = new URLRequest(bgStr);
			soundBG = new Sound(bgURL, new SoundLoaderContext(1000, true));
			channel = soundBG.play(0, 100000);
		}
		
		private function soundOver(evy:MouseEvent):void {
			Mouse.cursor = MouseCursor.BUTTON;
		}
		
		private function soundOut(evt:MouseEvent):void {
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		private function soundChange(evt:MouseEvent):void {
			if (isSound) {
				soundMC.sound.gotoAndStop(1);
				channel.stop();
				trace("无声");
			}else {
				soundMC.sound.gotoAndPlay(1);
				channel = soundBG.play(0, 100000);
				trace("有声");
			}
			isSound  = !isSound;
		}
		
		private function soundComplete(evt:Event):void {
			trace("声音加载完成");
		}
		
		private function resetFunc(eve:MouseEvent)
		{
			TweenLite.killTweensOf(winInfo);
			lockRun = true;
			reSet();
			giftObj.initStart();
		}
		private function reSet()
		{
			try
			{
				mro.x = 260;
				target = "";
				//////////-------------------------
				btnL.removeEventListener(MouseEvent.CLICK,leftHandle);
				btnM.removeEventListener(MouseEvent.CLICK,middleHandle);
				btnR.removeEventListener(MouseEvent.CLICK, rightHandle);
				this.removeEventListener(Event.ENTER_FRAME, startRunHandler);
				errTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, errorFunc);
				isErr = false;
			}
			catch (e)
			{
				trace(e);
			}
			resetBtn.mouseEnabled = false;
			winInfo.x = 15;
			winInfo.y = -70;
			winInfo.txt.text = "";
			winInfo.visible = false;
			btnL.reset();
			btnM.resetNew();
			btnR.resetNew();
		
			btnL.addEventListener(MouseEvent.CLICK,leftHandle);
			btnM.addEventListener(MouseEvent.CLICK,middleHandle);
			btnR.addEventListener(MouseEvent.CLICK,rightHandle);
			btnL.stop();
			//btnM.stop();
			//btnR.stop();
			this.btnUnlock();
			if (!this.hasEventListener(Event.ENTER_FRAME)) {
				this.addEventListener(Event.ENTER_FRAME, startRunHandler);
			}
		}
		
		//_winInfo
		public function flashCallGift(id, num):void {
			Debug.trace("幸运玛丽", "---礼物ID：" + id + "---");
			isErr = false;
			resetBtn.mouseEnabled = true;
			if (id == 20000) {
				resetBtn.mouseEnabled = false;
			}
			var winID:int = int(id);
			giftNum = winID;
			winInfo.info.visible = true;
			var winStr:String;
			switch(winID) {
				case 1001:
					winStr = num + "朵玫瑰";
					break;
				case 3100:
					winStr = num + "个奶瓶";
					break;
				case 3042:
					winStr = num + "个么么";
					break;
				case 1002:
					winStr = num + "个草莓";
					break;
				case 3103:
					winStr = num + "个猪头";
					break
				case 3070:
					winStr = num + "个鼓掌";
					break;
				case 3023:
					winStr = num + "杯红酒";
					break;
				case 3034:
					winStr = num + "个绿帽子";
					break;
				case 3053:
					winStr = num + "个要抱抱";
					break;
				case 3073:
					winStr = num + "件比基尼";
					break;
				case 3016:
					winStr = num + "个钻戒";
					break;
				case 3058:
					winStr = num + "条项链";
					break;
				case 3054:
					winStr = num + "辆爱的单车";
					break;
				case 3008:
					winStr = num + "艘游艇";
					break;
				case 3078:
					winStr = num + "辆跑车";
					break;
				case 1009:
					winStr = num + "架飞机";
					break;
				case 3004:
					winStr = num + "艘航母";
					break;
				case 3005:
					winStr = num + "个求婚";
					break;
				case 3093:
					winStr = num + "个小色娃";
					break;
				case 3131:
					winStr = num + "个钱袋";
					break;
				case 3096:
					winStr = num + "颗紫宝石";
					break;
				case 3021:
					winStr = num + "杯啤酒";
					break;
				case 3154:
					winStr = num + "朵金玫瑰";
					break;
				case 3127:
					winStr = num + "个喜欢你";
					break;
				case 3146:
					winStr = num + "个小样儿";
					break;
				case 3162:
					winStr = num + "朵荷花";
					break;
				case 3138:
					winStr = num +"把锄头";
					break;
				case 10000:
					winInfo.info.visible = false;
					winInfo.x = -140;
					winStr = "提示：玛丽打酱油了";
					break;
				case 20000:
					winStr = "砸中空箱子";
					break;
				case 30000:
					winInfo.x = -110;
					winInfo.info.visible = false;
					winStr = "提示：秀币不足";
					break;
				case 40000:
					winInfo.x = -90;
					winInfo.info.visible = false;
					winStr = "提示：未登录";
					break;
				default :
					winStr = "玛丽罢工中!";
					break;
			}
			showResult(giftid, winStr);
		}
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
			winInfo.visible = true;
			TweenLite.to(winInfo, 1, { y:35 , onComplete:showMarioGift } );
			resetBtn.visible = true;
		}
		
		private function showMarioGift():void {
			trace("展示礼物咯");
			resetBtn.mouseEnabled = true;
			showGift(giftNum);
		}
		
		private function showGift(type):void {
			trace("type: " + type);
			switch(type) {
				case 1001:
					//01玫瑰
					giftObj.showRose();
					break;
				case 3042:
					//02么么
					giftObj.showKiss();
					break;
				case 3103:
					//03猪头
					giftObj.showPig();
					break;
				case 3093:
					//04小色娃
					giftObj.showBoy();
					break;
				case 3054:
					//05爱的单车
					giftObj.showBicycle();
					break;
				case 3078:
					//06跑车
					giftObj.showCar();
					break;
				case 1009:
					//07飞机
					giftObj.showAir();
					break;
				case 3004:
					//08航母
					giftObj.showCarrier();
					break;
				case 3005:
					//09求婚
					giftObj.showPropose();
					break;
				case 3096:
					//10紫宝石
					giftObj.showGem();
					break;
				case 3131:
					//11钱袋
					giftObj.showPurse();
					break;
				case 1002:
					//12草莓
					giftObj.showStraw();
					break;
				case 3023:
					//13红酒
					giftObj.showWine();
					break;
				case 3100:
					//14奶瓶
					giftObj.showBottle();
					break;
				case 3058:
					//15项链
					giftObj.showNecklace();
					break;
				case 3016:
					//16钻戒
					giftObj.showRing();
					break;
				case 3073:
					//17比基尼
					giftObj.showBikini();
					break;
				case 3053:
					//18要抱抱
					giftObj.showHug();
					break;
				case 3034:
					//19绿帽子
					giftObj.showHat();
					break;
				case 3021:
					//20啤酒
					giftObj.showBeer();
					break;
				case 3008:
					//21游艇
					giftObj.showYacht();
					break;
				case 3070:
					//22鼓掌
					giftObj.showClap();
					break;
				case 3154:
					//23金玫瑰
					giftObj.showGoldRoss();
					break;
				case 3127:
					//喜欢你
					giftObj.showLikeYou();
					break;
				case 3146:
					//小样儿
					giftObj.showSample();
					break;
				case 3162:
					//荷花
					giftObj.showLotus();
					break;
				case 3138:
					//锄头
					giftObj.showHoe();
					break;
				default:
					//giftObj.showHug();
					break;
			}
		}
		
		private function startRunHandler(eve:Event):void {
			if (lockRun) {
				if (mro.x < this.leftPos || mro.x > this.rightPos)
				{
					mro.scaleX *=  -1;
				}
			}
			mro.x -=  speed * this.directions;
			//mro.x -=  speed * -1;
			if (mro.x < -35 || mro.x > 450) {
				btnLock();
				flashCallGift(10000,1);
			}
			switch (target)
			{
				case "left" :
					if (Math.abs(mro.x - this.leftPos) <= speed)
					{
						if (isSound) {
							soundJump.play(0);
						}
						dump();
						giftid = 1001;
						sendBocai(giftid);
						btnL.gotoAndPlay(2);
						this.removeEventListener(Event.ENTER_FRAME, startRunHandler);
						target = "";
					}
					break;
				case "middle" :
					if (Math.abs(mro.x - this.middPos) <= speed)
					{
						if (isSound) {
							soundJump.play(0);
						}
						dump();
						giftid = 1002;
						sendBocai(giftid);
						btnM.gotoAndPlay(26);
						this.removeEventListener(Event.ENTER_FRAME, startRunHandler);
						target = "";
					}
					break;
				case "right" :
					if (Math.abs(mro.x - this.rightPos) <= speed)
					{
						if (isSound) {
							soundJump.play(0);
						}
						btnR.gotoAndPlay(26);
						dump();
						giftid = 1003;
						sendBocai(giftid);
						this.removeEventListener(Event.ENTER_FRAME, startRunHandler);
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
			gotoR();
			btnLock();
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
			//flashCallGift(3138, 100);
		}
		
		
		private function gotoL()
		{
			trace("××××××××××砸玛丽咯×××××××××");
			run();
			lockRun = false;
			if (Math.abs(mro.x - this.leftPos) <= speed)
			{
				if (isSound) {
					soundJump.play(0);
				}
				dump();
				giftid = 1001;
				sendBocai(giftid);
				btnL.gotoAndPlay(2);
				this.removeEventListener(Event.ENTER_FRAME, startRunHandler);
				target = "";
				return;
			}
			target = "left";
			mro.scaleX = 0.58;
		}
		private function gotoM()
		{
			run();
			target = "middle";
			lockRun = false;
			if (Math.abs(mro.x - this.middPos) <= speed)
			{	
				trace("临界点");
				if (isSound) {
					soundJump.play(0);
				}
				dump();
				giftid = 1002;
				sendBocai(giftid);
				btnM.gotoAndPlay(26);
				this.removeEventListener(Event.ENTER_FRAME, startRunHandler);
				target = "";	
				return;
			}
			if (mro.x > this.middPos)
			{
				mro.scaleX = 0.58;
			}
			if (mro.x < this.middPos)
			{
				mro.scaleX = -0.58;
			}
		}
		private function gotoR()
		{
			run();
			lockRun = false;
			if (Math.abs(mro.x - this.rightPos) <= speed)
			{
				if (isSound) {
					soundJump.play(0);
				}
				btnR.gotoAndPlay(26);
				dump();
				giftid = 1003;
				sendBocai(giftid);
				this.removeEventListener(Event.ENTER_FRAME, startRunHandler);
				target = "";
				return;
			}
			target = "right";
			mro.scaleX = -0.58;
		}
		private function get directions()
		{
			if (mro.scaleX > 0) {
				return 1;
			}else {
				return -1;
			}
		}
		private function btnUnlock()
		{
			btnL.mouseEnabled = true;
			btnL.buttonMode = true;
			btnM.mouseEnabled = true;
			btnM.buttonMode = true;
			btnR.mouseEnabled = true;
			btnR.buttonMode = true;
		}
		private function btnLock()
		{
			btnL.mouseEnabled = false;
			btnL.mouseChildren = false;
			btnR.mouseChildren = false;
			btnM.mouseChildren = false;
			btnL.buttonMode = false;
			btnM.mouseEnabled = false;
			btnM.buttonMode = false;
			btnR.mouseEnabled = false;
			btnR.buttonMode = false;
			//计时器
			if (!errTimer.hasEventListener(TimerEvent.TIMER)) {
				errTimer.addEventListener(TimerEvent.TIMER_COMPLETE, errorFunc);
			}
			isErr = true;
			errTimer.reset();
			errTimer.start();
		}
		private function errorFunc(evy:TimerEvent):void {
			errTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, errorFunc);
			if (isErr) {
				flashCallGift(20000, 1);
			}
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