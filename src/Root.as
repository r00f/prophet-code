package {
	
	import basics.Darkness;
	import enemies.Enemy;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import interfaces.HealthBar;
	import utilities.*;
	import vendor.KeyObject;
	
	[SWF(width="600",height="400")] // Override document window size with SWF Metadata Tags [SWF(width='400', height='300', backgroundColor='#ffffff', frameRate='30')]
	
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
		
		public var scrollRectWidth:Number = 600;
		public var scrollRectHeight:Number = 400;
		
		public var player:Player;
		
		public var darkness:Darkness;
		
		public var world:World;
		
		private var timesToSort:Number = 3;
		
		public function Root() {
			super();
			this.scrollRect = new Rectangle(this.player.x - scrollRectWidth / 2, this.player.y - scrollRectHeight / 2, scrollRectWidth, scrollRectHeight);
			healthbar = new HealthBar(100, 100, 0.5, 0.5);
			stage.addChild(healthbar);
			keyPresses = new KeyObject(this.stage);
			this.darkness = this.world.darkness;
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);		
		}

		public function get Enemies() :Vector.<Enemy>{
			return this.world.Enemies;
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
		
		public function loop(e:Event):void {
			this.checkKeypresses();
			healthbar.currentHealth = player.HealthPercentage;
			scale();
		}
		
		
		public function scale() {
			if (keyPresses.isDown(KeyCodes.PageUp)) {
				this.world.scaleX += (this.world.scaleX / 10);
				this.world.scaleY += (this.world.scaleY / 10);
			} else if (keyPresses.isDown(KeyCodes.PageDown)) {
				this.world.scaleX -= (this.world.scaleX / 10);
				this.world.scaleY -= (this.world.scaleY / 10);
			}
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
		
		public function collidesWithEnvironment(x_next:Number, y_next:Number):Boolean {
			return this.world.collidesWithEnvironment(x_next, y_next);
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
