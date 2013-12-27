package spells {
	import enemies.Enemy;
	import basics.hitboxes.DamageBox;
	import flash.events.Event;
	import utilities.Directions;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Fireball extends Spell {
		private var spellDamage:Number = 10;
		private var enemiesHit:Object = new Object();
		private var direction:String = Directions.LEFT;
		private var speed;
		
		public function Fireball(direction:String, speed:Number = 8) {
			super();
			this.direction = direction;
			this.speed = speed;
			this.gotoAndPlay(this.direction);
		}
		
		public function move(e:Event) {
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
			} else {
				this.x = nextx;
				this.y = nexty;
			}
		}
		
		override public function damageAppliedToEnemy(box:DamageBox, enemy:Enemy) {
			super.damageAppliedToEnemy(box, enemy);
			if (!enemiesHit[enemy]) {
				enemy.applyDamage(spellDamage);
				enemiesHit[enemy] = true;
			}
		}
	
	}

}