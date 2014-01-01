package spells {
	import basics.hitboxes.DamageBox;
	import enemies.base.Enemy;
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.Directions;
	import utilities.interfaces.ILastFrameTrigger;
	import utilities.LastFrameTrigger;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Fireball extends Spell implements ILastFrameTrigger {
		private var spellDamage:Number = 50;
		private var moveDistance:Number = 7.6; // in pseudo-meters, 1 pixel = 1cm, must be > 0
		
		
		private var enemiesHit:Object;
		private var direction:Directions = Directions.LEFT;
		private var speed;
		
		private var startx:Number;
		private var starty:Number;
		
		private var maxDistanceSquared:Number;
		private var maxDistancePixel:Number;
		
		public var explosion:LastFrameTrigger;
		
		public function Fireball(direction:Directions, x:Number, y:Number, speed:Number = 8) {
			super();
			this.x = x;
			this.y = y;
			this.direction = direction;
			this.speed = 350/24;
			this.gotoAndStop(this.direction);
			this.enemiesHit = new Object();
			
			this.startx = x;
			this.starty = y;
			
			maxDistancePixel = this.moveDistance * 100;
			maxDistanceSquared = Math.pow(maxDistancePixel, 2);
			addEventListener(Event.ENTER_FRAME, move, false, 0, true);
		}
		
		public function move(e:Event) {
			if (this.rootRef == null) {
				this.rootRef = root as Root;
			}
			var nextx:Number = this.x;
			var nexty:Number = this.y;
			if (this.direction.isLeft) {
				nextx -= this.speed;
			} else if (this.direction.isRight) {
				nextx += this.speed;
			}
			if (this.direction.isUp) {
				nexty -= this.speed;
			} else if (this.direction.isDown) {
				nexty += this.speed;
			}
			if (this.rootRef.collidesWithEnvironment(nextx, nexty) || travelledTooFar(nextx, nexty) ) {
				this.gotoAndPlay("explode");
				this.explosion.delegate = this;
			} else {
				this.x = nextx;
				this.y = nexty;
			}
		
		}
		
		public function travelledTooFar(nextx, nexty) {
			var xdiff:Number = Math.abs(nextx - this.startx);
			var ydiff:Number = Math.abs(nexty - this.starty);
			var distance_squaredx = Math.pow(xdiff, 2);
			var distance_squaredy = Math.pow(ydiff, 2);
			if (ydiff > this.maxDistancePixel || xdiff > this.maxDistancePixel || distance_squaredx + distance_squaredy > maxDistanceSquared) {
				return true;
			}
			return false;
		}
		
		public function lastFrameEnded(mv:MovieClip) {
			removeEventListener(Event.ENTER_FRAME, move, false);
			this.parent.removeChild(this);
		}
		
		override public function damageAppliedToEnemy(box:DamageBox, enemy:Enemy):void {
			super.damageAppliedToEnemy(box, enemy);
			if (!enemiesHit[enemy.name]) {
				enemy.applyDamage(spellDamage);
				enemiesHit[enemy.name] = true;
			}
		}
	
	}

}