﻿package {
	
	import basics.Darkness;
	import basics.entities.Entity;
	import basics.hitboxes.CollisionBox;
	import enemies.Baby;
	import enemies.Enemy;
	import enemies.Skull;
	import environment.Environment;
	import environment.nature.Tree;
	import environment.wall.segments.BaseSegment;
	import environment.wall.segments.HorizontalDoor;
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
		
		private var timesToSort:Number = 3;
		
		public function Root() {
			super();
			this.scrollRect = new Rectangle(this.player.x - scrollRectWidth / 2, this.player.y - scrollRectHeight / 2, scrollRectWidth, scrollRectHeight);
			healthbar = new HealthBar(100, 100, 0.5, 0.5);
			stage.addChild(healthbar);
			keyPresses = new KeyObject(this.stage);
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			
			addEventListener(Event.ENTER_FRAME, sort, false, 0, true);
		
		}
		
		public function sort(e:Event) {
			
			//prepare an array
			var sortArray:Array = [];
			;
			//put the children into an array
			for (var i:int = 0; i < this.numChildren; i++) {
				sortArray[i] = this.getChildAt(i);
			}
			//get a sorting function ready
			function customSort(childClip:DisplayObject, childClip2:DisplayObject):int {
				if (childClip is Entity && childClip2 is Entity) {
					var door:HorizontalDoor;
					if (childClip is HorizontalDoor && childClip2 is Player) {
						 door = childClip as HorizontalDoor;
						return (door.isDoorOpen && door.y + 25 > player.y) ? 1 : -1;
					} else if (childClip is Player && childClip2 is HorizontalDoor) {
						door = childClip2 as HorizontalDoor;
						return (door.isDoorOpen && door.y + 25 > player.y) ?  -1 : 1;
					}
					if (childClip.y < childClip2.y) {
						return -1;
					} else if (childClip.y > childClip2.y) {
						return 1;
					} else
						return 0;
				} else {
					if (childClip is Entity)
						return 1;
					else if (childClip2 is Entity)
						return -1;
					else
						return 0;
				}
			}
			
			//sort the array by y value low -> high
			sortArray.sort(customSort);
			//loop through the array resetting indexes
			for (i = 0; i < sortArray.length; i++) {
				this.setChildIndex(sortArray[i], i);
			}
			this.addChild(this.darkness);
		}
		
		var wait = 10;
		
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
		
		public function collidesWithEnvironment(x_next:Number, y_next:Number) {
			for (var i = 0; i < this.numChildren; i++) {
				var childClip:MovieClip = getChildAt(i) as MovieClip;
				if (childClip is Environment) {
					var env:Environment = childClip as Environment;
					for each (var hitbox:CollisionBox in env.CollisionBoxes) {
						if (hitbox.hitTestPoint(x_next, y_next, false)) {
							return true;
						}
					}
				}
			}
			return false;
		
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
