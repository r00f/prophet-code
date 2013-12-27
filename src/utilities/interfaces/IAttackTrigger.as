package utilities.interfaces {
	import basics.hitboxes.AttackBox;
	
	/**
	 * Interface for the AttackBox. When the delegate (which has type IAttackTrigger) is set, this function is called whenever the attackBox hits the player.
	 * @author Gabriel
	 */
	public interface IAttackTrigger {
		function attackBoxTriggeredByPlayer(attackBox:AttackBox);
	}

}