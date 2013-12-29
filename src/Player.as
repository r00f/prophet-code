package {
	
	import basics.entities.HealthEntity;
	import basics.hitboxes.BodyBox;
	import basics.Light;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import spells.Fireball;
	import utilities.*;
	
	/**
	 * The player class controls the player movieclip. The Player is controlled by the keyboard.
	 */
	public class Player extends HealthEntity {
		
		private var speed:Number = 5;
		public var animations:MovieClip;
		public var feet_hit:BodyBox;
		public var body_hit:BodyBox;
		private var direction:Directions;
		
		public var offsetx:Number;
		public var offsety:  Number;
		
		public function Player() {
			super();
			this.blood.yRange = 70;
			this.rootRef.player = this;
			this.offsetx = this.x + 50;
			this.offsety = this.y + 80;
			this.direction = Directions.DOWN;
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			addEventListener(Event.ENTER_FRAME, checkIfDead, false, 0, true);		
		}
		
		public function get light():Light {
			return this.Lights[0];
		}
		
		private function updateDirection():void {
			if (this.rootRef.movementPressed()) {
				direction.current = Directions._none;
				if (this.rootRef.upPressed) {
					direction.current += Directions._up;
				} else if (this.rootRef.downPressed) {
					direction.current += Directions._down;
				}
				
				if (this.rootRef.leftPressed) {
					direction.current += Directions._left;
				} else if (this.rootRef.rightPressed) {
					direction.current += Directions._right;
				}
			}
		}
		
		public function get Action():String {
			if (this.rootRef.leftPressed || this.rootRef.upPressed || this.rootRef.rightPressed || this.rootRef.downPressed) {
				return Actions.WALK;
			} else if (this.rootRef.attackPressed) {
				return Actions.HIT;
			} else {
				return Actions.IDLE;
			}
		}
		
		public function checkIfDead(e:Event) {
			
			if (this.HealthPercentage == 0) {
				this.gotoAndStop(Actions.DEATH + Utilities.ANIMATION_SEPERATOR + this.direction);
				super.death_animation.delegate = this;
				this.blood.yRange = 36;
				removeEventListener(Event.ENTER_FRAME, loop, false);
				removeEventListener(Event.ENTER_FRAME, checkIfDead, false);
			}
		}
		private var cooldown = 20;
		
		private function shootFireball() {
			this.rootRef.addChild(new Fireball(this.direction.copy, x,y-20));
		}
		
		public function loop(e:Event):void {
			this.updateDirection();
			var xchange = 0;
			var ychange = 0;
			if (this.rootRef.keyPresses.isDown(KeyCodes.Control) && cooldown <= 0) {
				this.shootFireball();
				cooldown = 20;
			}
			cooldown--;
			if (this.rootRef.movementPressed()) {
				if (this.direction.isLeft) {
					xchange -= speed;
				} else if (this.direction.isRight) {
					xchange += speed;
				}
				
				if (this.direction.isUp) {
					ychange -= speed;
				} else if (this.direction.isDown) {
					ychange += speed;
				}
			}
			
			var c:Rectangle = this.rootRef.scrollRect;
			if (!this.rootRef.collidesWithEnvironment(this.x + xchange, this.y + ychange)) {
				this.rootRef.scrollRect = new Rectangle(c.x += xchange, c.y += ychange, c.width, c.height);
			} else if (!this.rootRef.collidesWithEnvironment(this.x, this.y + ychange)) {
				this.rootRef.scrollRect = new Rectangle(c.x, c.y += ychange, c.width, c.height);
				
			} else if (!this.rootRef.collidesWithEnvironment(this.x + xchange, this.y)) {
				this.rootRef.scrollRect = new Rectangle(c.x += xchange, c.y, c.width, c.height);
			}
			c = this.rootRef.scrollRect;
			this.x = c.width / 2 + c.x;
			this.y = c.height / 2 + c.y;
			this.gotoAndPlay(this.Action + Utilities.ANIMATION_SEPERATOR + this.direction);
			this.light.scaleX = this.HealthPercentage + 0.4;
			this.light.scaleY = this.HealthPercentage + 0.4;
		}
	}

}

