package utilities.interfaces {
	import basics.hitboxes.DamageBox;
	import enemies.base.Enemy;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public interface IDamageTrigger {
		function damageAppliedToEnemy(box:DamageBox, enemy:Enemy):void;
		function damageAppliedToPlayer(box:DamageBox, player:Player):void;
		
		function damagePlayerHitbox(box:DamageBox):String;
	}

}