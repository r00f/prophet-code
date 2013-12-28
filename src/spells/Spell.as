package spells {
	import basics.entities.Entity;
	import basics.hitboxes.DamageBox;
	import enemies.Enemy;
	import flash.events.Event;
	import utilities.interfaces.IDamageTrigger;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Spell extends Entity implements IDamageTrigger {
		
		protected var manaCost:Number;
		
		protected var rootRef:Root;
		
		public function Spell() {
			super();
			this.rootRef = root as Root;
			addEventListener(Event.ENTER_FRAME, eventLoop, false, 0, true);
		}
		
		/**
		 * Triggeres when an enemy is hit by the spell. should be overridden by subclasses.
		 * @param	box The box that triggered
		 * @param	enemy the enemy that triggered the box
		 */
		public function damageAppliedToEnemy(box:DamageBox, enemy:Enemy) {
		}
		
		/**
		 * Triggeres when a player is hit by the spell. should be overridden by subclasses.
		 * @param	box The box that triggered
		 * @param	enemy the player that triggered the box
		 */
		public function damageAppliedToPlayer(box:DamageBox, player:Player) {
		}
		
		
		private function eventLoop(e:Event) {
			this.setDamageBoxDelegate(this);
		}
	
	}

}