package spells {
	import basics.entities.Entity;
	import basics.entities.ManaEntity;
	import basics.hitboxes.DamageBox;
	import enemies.base.Enemy;
	import flash.events.Event;
	import utilities.interfaces.IDamageTrigger;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Spell extends Entity implements IDamageTrigger {
		
		public var manaCost:Number;
		
		public function Spell() {
			super();
			addEventListener(Event.ENTER_FRAME, eventLoop, false, 0, true);
		}
		
		/**
		 * Triggeres when an enemy is hit by the spell. should be overridden by subclasses.
		 * @param	box The box that triggered
		 * @param	enemy the enemy that triggered the box
		 */
		public function damageAppliedToEnemy(box:DamageBox, enemy:Enemy):void {
		}
		
		/**
		 * Triggeres when a player is hit by the spell. should be overridden by subclasses.
		 * @param	box The box that triggered
		 * @param	enemy the player that triggered the box
		 */
		public function damageAppliedToPlayer(box:DamageBox, player:Player):void {
		}
		
		public function useMana(mana:Number) {
			mana = manaCost;
		}
		
		public function damagePlayerHitbox(box:DamageBox):String {
			return Player.HITBOX_BODY;
		}
		
		
		private function eventLoop(e:Event) {
			this.setDamageBoxDelegate(this);
		}
	
	}

}