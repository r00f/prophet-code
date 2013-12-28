package spells {
	import basics.Light;
	import enemies.Enemy;
	import basics.hitboxes.DamageBox;
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
		private var enemiesHit:Object;
		private var direction:String = Directions.LEFT;
		private var speed;
		
		public var explosion:LastFrameTrigger;
		
		public function Fireball(direction:String, x:Number, y:Number, speed:Number = 8) {
			super();
			this.x = x;
			this.y = y;
			this.direction = direction;
			this.speed = speed;
			this.gotoAndStop(this.direction);
			this.enemiesHit = new Object();
			addEventListener(Event.ENTER_FRAME, move, false, 0, true);
		}
		
		public function move(e:Event) {
			if (this.rootRef == null) {
				this.rootRef = root as Root;
			}
			var nextx:Number = this.x;
			var nexty:Number = this.y;
			if (this.direction == Directions.LEFT) {
				nextx -= this.speed;
			} else if (this.direction == Directions.RIGHT) {
				nextx += this.speed;
			} else if (this.direction == Directions.UP) {
				nexty -= this.speed;
			} else if (this.direction == Directions.DOWN) {
				nexty += this.speed;
			}
			if (this.rootRef.collidesWithEnvironment(nextx, nexty)) {
				this.gotoAndPlay("explode");
				this.explosion.delegate = this;
			} else {
				this.x = nextx;
				this.y = nexty;
			}
		
		}
		
		public function lastFrameEnded(mv:MovieClip) {
			removeEventListener(Event.ENTER_FRAME, move, false);
			this.parent.removeChild(this);
		}
		
		override public function damageAppliedToEnemy(box:DamageBox, enemy:Enemy) {
			super.damageAppliedToEnemy(box, enemy);
			if (!enemiesHit[enemy.name]) {
				enemy.applyDamage(spellDamage);
				enemiesHit[enemy.name] = true;
			}
		}
	
	}

}