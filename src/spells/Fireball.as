package spells {
	import enemies.Enemy;
	import basics.hitboxes.DamageBox;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Fireball extends Spell {
		private var spellDamage:Number = 10;
		private var enemiesHit:Object = new Object();
		
		public function Fireball() {
			super();
		}
		
		override internal function damageAppliedToEnemy(box:DamageBox, enemy:Enemy) {
			super.damageAppliedToEnemy(box, enemy);
			if (!enemiesHit[enemy]) {
				enemy.applyDamage(spellDamage);
				enemiesHit[enemy] = true;
			}
		}
	
	}

}