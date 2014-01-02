package {
	
	import basics.entities.Entity;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.display.StageQuality;
	import basics.BasicInfo;
	import basics.Darkness;
	import enemies.base.Enemy;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import interfaces.HealthBar;
	import utilities.*;
	import vendor.KeyObject;
	
	[SWF(width="1920",height="1080")] // Override document window size with SWF Metadata Tags [SWF(width='400', height='300', backgroundColor='#ffffff', frameRate='30')]
	
	/**
	 * This is the document class of the project. It also serves as a coordinator between player, enemies and environment.
	 */
	public class Root extends MovieClip {
		
		var healthbar:HealthBar;
		
		public var keyPresses:KeyObject;
		private var _leftPressed:Boolean = false; //keeps track of whether the left arrow key is pressed
		private var _rightPressed:Boolean = false; //same, but for right key pressed
		private var _upPressed:Boolean = false; //...up key pressed
		private var _downPressed:Boolean = false; //...down key pressed
		private var _attackPressed:Boolean = false; //...down key pressed
		
		public var scrollRectWidth:Number = 1920;
		public var scrollRectHeight:Number = 1080;
		
		public var player:Player;
		
		public var darkness:Darkness;
		
		public var world:World;
		
		private var timesToSort:Number = 3;
		
		private var easing:Number = 10;
		
		public function Root() {
			super();
			stage.displayState = StageDisplayState.FULL_SCREEN;
			stage.quality = StageQuality.MEDIUM;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			StageQuality.LOW;
			if (player != null) {
				this.scrollRect = new Rectangle(this.player.x - scrollRectWidth / 2, this.player.y - scrollRectHeight / 2, scrollRectWidth, scrollRectHeight);
			}
			healthbar = new HealthBar(new Point(300, 1000), new Point(1, 1));
			stage.addChild(healthbar);
			keyPresses = new KeyObject(this.stage);
			this.darkness = this.world.darkness;
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);		
			stage.addChild(new BasicInfo());
		}

		public function get Enemies() :Vector.<Enemy>{
			return this.world.Enemies;
		}
		
		
		public function addEntity(entity:Entity) {
			this.world.addChild(entity);
			this.world.addChild(world.darkness);
		}
		
		// Keys
		
		public function get downPressed():Boolean {
			return _downPressed;
		}
		
		public function get upPressed():Boolean {
			return _upPressed;
		}
		
		public function get rightPressed():Boolean {
			return _rightPressed;
		}
		
		public function get leftPressed():Boolean {
			return _leftPressed;
		}
		
		public function get attackPressed():Boolean {
			return _attackPressed;
		}
		
		public function get movementPressed():Boolean {
			return _downPressed || _upPressed || _leftPressed || _rightPressed;
		}
		
		public function loop(e:Event):void {
			
			this.checkKeypresses();
			if (player != null) {
				healthbar.currentHealth = player.HealthPercentage;
				scaleAndSetPlayerPosition();
			}
		}
		
		
		public function scaleAndSetPlayerPosition() {
			if (keyPresses.isDown(KeyCodes.PageUp)) {
				this.world.scaleX += (this.world.scaleX / 10);
				this.world.scaleY += (this.world.scaleY / 10);
			} else if (keyPresses.isDown(KeyCodes.PageDown)) {
				this.world.scaleX -= (this.world.scaleX / 10);
				this.world.scaleY -= (this.world.scaleY / 10);
			}
			var c:Rectangle = this.scrollRect;
			var nextX:int = (this.player.x * this.world.scaleX) - c.width / 2;
			var nextY:int = (this.player.y * this.world.scaleY) - c.height / 2;
			
			var xdiff = nextX - this.scrollRect.x; 
			var ydiff = nextY - this.scrollRect.y;
			var eased_xdiff:int =(xdiff* 1/this.easing);
			var eased_ydiff:int = (ydiff * 1/this.easing);
			this.scrollRect = new Rectangle( this.scrollRect.x + eased_xdiff ,  this.scrollRect.y + eased_ydiff, c.width, c.height);
		}
		
		public function checkKeypresses():void {
			if (keyPresses.isDown(KeyCodes.LeftArrow) || keyPresses.isDown(KeyCodes.a)) { // if left arrow or A is pressed
				_leftPressed = true;
			} else {
				_leftPressed = false;
			}
			if (keyPresses.isDown(KeyCodes.UpArrow) || keyPresses.isDown(KeyCodes.w)) { // if up arrow or W is pressed
				_upPressed = true;
			} else {
				_upPressed = false;
			}
			
			if (keyPresses.isDown(KeyCodes.RightArrow) || keyPresses.isDown(KeyCodes.d)) { //if right arrow or D is pressed
				_rightPressed = true;
			} else {
				_rightPressed = false;
			}
			
			if (keyPresses.isDown(KeyCodes.DownArrow) || keyPresses.isDown(KeyCodes.s)) { //if down arrow or S is pressed
				_downPressed = true;
			} else {
				_downPressed = false;
			}
			
			if (keyPresses.isDown(KeyCodes.Spacebar)) { //if down arrow or S is pressed
				_attackPressed = true;
			} else {
				_attackPressed = false;
			}
		}
		
		public function collidesWithEnvironment(next:Point):Boolean {
			return this.world.collidesWithEnvironment(next);
		}
		
		private var areHitboxesVisible = false;
		private var canSwapVisiblityOfHitboxes = false;
		
		public function get shouldHitboxBeVisible() {
			if (this.keyPresses == null)
				return false;
			if (this.keyPresses.isDown(KeyCodes.H)) {
				if (this.canSwapVisiblityOfHitboxes) {
					areHitboxesVisible = !areHitboxesVisible;
					this.canSwapVisiblityOfHitboxes = false;
				}
			} else {
				this.canSwapVisiblityOfHitboxes = true;
			}
			return areHitboxesVisible;
		}
	}

}
