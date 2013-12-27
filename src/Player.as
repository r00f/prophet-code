package {
	
	import basics.hitboxes.BodyBox;
	import basics.Light;
	import enemies.Baby;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import utilities.*;
	
	/**
	 * The player class controls the player movieclip. The Player is controlled by the keyboard.
	 */
	public class Player extends HealthEntity {
		
		private var speed:Number = 5;
		private var rootRef:Root;
		public var animations:MovieClip;
		public var feet_hit:BodyBox;
		public var body_hit:BodyBox;
		private var _direction;
		
		public var offsetx:Number;
		public var offsety:Number;
		
		public function Player() {
			super();			
			this.rootRef = root as Root;
			this.rootRef.player = this;
			this.offsetx = this.x + 50;
			this.offsety = this.y + 80;
			_direction = Directions.DOWN;
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			addEventListener(Event.ENTER_FRAME, checkIfDead, false, 0, true);		
		}
		
		public function get light():Light {
			return this.Lights[0];
		}
		
		public function get Direction():String {
			
			if (this.rootRef.upPressed) {
				_direction = Directions.UP;
			}
			if (this.rootRef.downPressed) {
				_direction = Directions.DOWN;
			}
			if (this.rootRef.leftPressed) {
				_direction = Directions.LEFT;
			}
			if (this.rootRef.rightPressed) {
				_direction = Directions.RIGHT;
			}
			
			return _direction;
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
				this.gotoAndStop(Actions.DEATH + "_" + this._direction);
				super.death_animation.delegate = this;
				removeEventListener(Event.ENTER_FRAME, loop, false);
				removeEventListener(Event.ENTER_FRAME, checkIfDead, false);
			}
		}
		
		public function loop(e:Event):void {
			var xchange = 0;
			var ychange = 0;
			if (this.rootRef.leftPressed) {
				xchange -= speed;
			} else if (this.rootRef.rightPressed) {
				xchange += speed;
			}
			
			if (this.rootRef.upPressed) {
				ychange -= speed;
			} else if (this.rootRef.downPressed) {
				ychange += speed;
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
			
			this.gotoAndPlay(this.Action + "_" + this.Direction);
			this.light.scaleX = this.HealthPercentage;
			this.light.scaleY = this.HealthPercentage;
		}
	}

}

