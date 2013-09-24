package  {
	import flash.display.MovieClip;
	
	public class MarioGift extends MovieClip {
		
		private var gift:GiftShow;
		
		public function MarioGift() {
			// constructor code
			initGift();
		}
		
		private function initGift():void {
			gift = new GiftShow();
			this.addChild(gift);
			gift.x = 181;
			gift.y = 146;
		}
		//初始化礼物
		public function initStart():void {
			gift.initStart();
		}
		///////////////////////////////////5个
		//玫瑰
		public function showRose():void {
			gift.showRose();
		}
		//么么
		public function showKiss():void {
			gift.showKiss();
		}
		//猪头
		public function showPig():void {
			gift.showPig();
		}
		//小色娃
		public function showBoy():void {
			gift.showBoy();
		}
		//单车
		public function showBicycle():void {
			gift.showBicycle();
		}
		///////////////////////////////////////////////////
		//10个
		//跑车
		public function showCar():void {
			gift.showCar();
		}
		//飞机
		public function showAir():void {
			gift.showAir();
		}
		//航母
		public function showCarrier():void {
			gift.showCarrier();
		}
		//求婚
		public function showPropose():void {
			gift.showPropose();
		}
		//紫宝石
		public function showGem():void {
			gift.showGem();
		}
		/////////////////////////////////////////
		//15个
		//钱袋
		public function showPurse():void {
			gift.showPurse();
		}
		//草莓
		public function showStraw():void {
			gift.showStraw();
		}
		//红酒
		public function showWine():void {
			gift.showWine();
		}
		//奶瓶
		public function showBottle():void {
			gift.showBottle();
		}
		//项链
		public function showNecklace():void {
			gift.showNecklace();
		}
		/////////////////////////////////////////
		//20个
		//钻戒
		public function showRing():void {
			gift.showRing();
		}
		//比基尼
		public function showBikini():void {
			gift.showBikini();
		}
		//要抱抱
		public function showHug():void {
			gift.showHug();
		}
		//绿帽子
		public function showHat():void {
			gift.showHat();
		}
		//啤酒
		public function showBeer():void {
			gift.showBeer();
		}
		//////////////////////////////////////////
		//25个
		//游艇
		public function showYacht():void {
			gift.showYacht();
		}
		//鼓掌
		public function showClap():void {
			gift.showClap();
		}
		//金玫瑰
		public function showGoldRoss():void {
			gift.showGoldRoss();
		}
		//喜欢你
		public function showLikeYou():void {
			gift.showLikeYou();
		}
		//小样儿
		public function showSample():void {
			gift.showSample();
		}
		//////////////////////////////////////////
		//27个
		//荷花
		public function showLotus():void {
			gift.showLotus();
		}
		//锄头
		public function showHoe():void {
			gift.showHoe();
		}
		
	}
	
}
