package weapons {
	
	import basics.hitboxes.DamageBox;
	import enemies.base.Enemy;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Dominik
	 */
	public class Sword extends Weapon {
		
		private var swordDmg:int = 25;
		private var enemiesHit:Object;
		
		public function Sword() {
			super();
		
		}
		
		override public function init() {
			super.init();
			if (this.rootRef != null) {
				this.enemiesHit = new Object();
			}
		}
		
		override public function damageAppliedToEnemy(box:DamageBox, enemy:Enemy):void {
			super.damageAppliedToEnemy(box, enemy);
			if (!enemiesHit[enemy.name]) {
				enemy.applyDamage(swordDmg);
				enemiesHit[enemy.name] = true;
			}
		}
	}

}