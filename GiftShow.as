package  {
	import flash.display.MovieClip;
	
	public class GiftShow extends MovieClip {
		
		//礼物
		private var boy:MovieClip;		
		private var bicycle:MovieClip;	
		private var carrier:MovieClip;	
		private var kiss:MovieClip;		
		private var rose:MovieClip;
		private var car:MovieClip;
		private var propose:MovieClip;
		private var pig:MovieClip;
		private var aircraft:MovieClip;
		private var gem:MovieClip;
		private var purse:MovieClip;
		private var strawberries:MovieClip;
		private var wine:MovieClip;
		private var bottle:MovieClip;
		private var necklace:MovieClip;
		private var ring:MovieClip;
		private var bikini:MovieClip;
		private var hug:MovieClip;
		private var hat:MovieClip;
		private var beer:MovieClip;
		private var yacht:MovieClip;
		private var clap:MovieClip;
		private var goldRoss:MovieClip;
		private var likeYou:MovieClip;
		private var sample:MovieClip;
		private var lotus:MovieClip;
		private var hoe:MovieClip;
		//礼物数组
		private var giftArr:Array = new Array();
		
		public function GiftShow() {
			// constructor code
			initGift();
		}
		
		private function initGift():void {
			boy = gift_Boy;				//小色娃
			bicycle = gift_Bicycle;		//爱单车
			carrier = gift_Carrier;		//航母
			kiss = gift_Kiss;			//么么
			rose = gift_Rose;			//玫瑰
			car = gift_RacingCar;		//跑车
			propose = gift_Propose;		//求婚
			pig = gift_Pig;				//猪头
			aircraft = gift_Aircraft;	//飞机
			gem = gift_Gem;				//紫宝石
			purse = gift_Purse;			//钱袋
			strawberries = gift_Strawberries;	//草莓
			wine = gift_Wine;			//红酒
			bottle = gift_Bottle;		//奶瓶
			necklace = gift_Necklace;	//项链
			ring = gift_Ring;			//钻戒
			bikini = gift_Bikini;		//比基尼
			hug = gift_Hug;				//要抱抱
			hat = gift_Hat;				//绿帽子
			beer = gift_Beer;			//啤酒
			yacht = gift_Yacht;			//游艇
			clap = gift_Clap;			//鼓掌
			goldRoss = gift_GoldRoss;	//金玫瑰；
			likeYou = gift_LikeYou;		//喜欢你
			sample = gift_Sample;		//小样
			lotus = gift_Lotus;			//荷花
			hoe = gift_Hoe;				//锄头
			//存入数组
			giftArr[0] = kiss;
			giftArr[1] = rose;
			giftArr[2] = pig;
			giftArr[3] = boy;
			giftArr[4] = bicycle;
			giftArr[5] = car;
			giftArr[6] = aircraft;
			giftArr[7] = carrier;
			giftArr[8] = propose;
			giftArr[9] = gem;
			giftArr[10] = purse;
			giftArr[11] = strawberries;
			giftArr[12] = wine;
			giftArr[13] = bottle;
			giftArr[14] = necklace;
			giftArr[15] = ring;
			giftArr[16] = bikini;
			giftArr[17] = hug;
			giftArr[18] = hat;
			giftArr[19] = beer;
			giftArr[20] = yacht;
			giftArr[21] = clap;
			giftArr[22] = goldRoss;
			giftArr[23] = likeYou;
			giftArr[24] = sample;
			giftArr[25] = lotus;
			giftArr[26] = hoe;
			for (var i:int = 0; i < giftArr.length; i++ ) {
				giftArr[i].visible = false;
				giftArr[i].gotoAndStop(1);
			}
		}
		//初始化礼物展示
		public function initStart():void {
			for (var i:int = 0; i < giftArr.length; i++ ) {
				giftArr[i].visible = false;
				giftArr[i].gotoAndStop(1);
			}
		}
		//玫瑰
		public function showRose():void {
			initGift();
			rose.visible = true;
			rose.gotoAndPlay(1);
		}
		//么么
		public function showKiss():void {
			initGift();
			kiss.visible = true;
			kiss.gotoAndPlay(1);
		}
		//猪头
		public function showPig():void {
			initGift();
			pig.visible = true;
			pig.gotoAndPlay(1);
		}
		//小色娃
		public function showBoy():void {
			initGift();
			boy.visible = true;
			boy.gotoAndPlay(1);
		}
		//单车
		public function showBicycle():void {
			initGift();
			bicycle.visible = true;
			bicycle.gotoAndPlay(1);
		}
		//跑车
		public function showCar():void {
			initGift();
			car.visible = true;
			car.gotoAndPlay(1);
		}
		//飞机
		public function showAir():void {
			initGift();
			aircraft.visible = true;
			aircraft.gotoAndPlay(1);
		}
		//航母
		public function showCarrier():void {
			initGift();
			carrier.visible = true;
			carrier.gotoAndPlay(1);
		}
		//求婚
		public function showPropose():void {
			initGift();
			propose.visible = true;
			propose.gotoAndPlay(1);
		}
		//紫宝石
		public function showGem():void {
			initGift();
			gem.visible = true;
			gem.gotoAndPlay(1);
		}
		//钱袋
		public function showPurse():void {
			initGift();
			purse.visible = true;
			purse.gotoAndPlay(1);
		}
		//草莓
		public function showStraw():void {
			initGift();
			strawberries.visible = true;
			strawberries.gotoAndPlay(1);
		}
		//红酒
		public function showWine():void {
			initGift();
			wine.visible = true;
			wine.gotoAndPlay(1);
		}
		//奶瓶
		public function showBottle():void {
			initGift();
			bottle.visible = true;
			bottle.gotoAndPlay(1);
		}
		//项链
		public function showNecklace():void {
			initGift();
			necklace.visible = true;
			necklace.gotoAndPlay(1);
		}
		//钻戒
		public function showRing():void {
			initGift();
			ring.visible = true;
			ring.gotoAndPlay(1);
		}
		//比基尼
		public function showBikini():void {
			initGift();
			bikini.visible = true;
			bikini.gotoAndPlay(1);
		}
		//要抱抱
		public function showHug():void {
			initGift();
			hug.visible = true;
			hug.gotoAndPlay(1);
		}
		//绿帽子
		public function showHat():void {
			initGift();
			hat.visible = true;
			hat.gotoAndPlay(1);
		}
		//啤酒
		public function showBeer():void {
			initGift();
			beer.visible = true;
			beer.gotoAndPlay(1);
		}
		//游艇
		public function showYacht():void {
			initGift();
			yacht.visible = true;
			yacht.gotoAndPlay(1);
		}
		//鼓掌
		public function showClap():void {
			initGift();
			clap.visible = true;
			clap.gotoAndPlay(1);
		}
		//金玫瑰
		public function showGoldRoss():void {
			initGift();
			goldRoss.visible = true;
			goldRoss.gotoAndPlay(1);
		}
		//喜欢你
		public function showLikeYou():void {
			initGift();
			likeYou.visible = true;
			likeYou.gotoAndPlay(1);
		}
		//小样
		public function showSample():void {
			initGift();
			sample.visible = true;
			sample.gotoAndPlay(1);
		}
		//荷花
		public function showLotus():void {
			initGift();
			lotus.visible = true;
			lotus.gotoAndPlay(1);
		}
		//锄头
		public function showHoe():void {
			initGift();
			hoe.visible = true;
			hoe.gotoAndPlay(1);
		}
	}
	
}
