package utilities.interfaces {
	import basics.hitboxes.DamageBox;
	import enemies.Enemy;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public interface IDamageTrigger {
		function damageAppliedToEnemy(box:DamageBox, enemy:Enemy);
		function damageAppliedToPlayer(box:DamageBox, player:Player);
	}

}