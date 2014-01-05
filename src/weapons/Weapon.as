package weapons {
	
	import basics.entities.Entity;
	import basics.hitboxes.DamageBox;
	import enemies.base.Enemy;
	import flash.events.Event;
	import utilities.interfaces.IDamageTrigger;
	
	/**
	 * ...
	 * @author Dominik
	 */
	public class Weapon extends Entity implements IDamageTrigger {
		
		public function Weapon() {
			super();
			addEventListener(Event.ENTER_FRAME, eventLoop, false, 0, false)
		}
		
		public function damageAppliedToEnemy(box:DamageBox, enemy:Enemy):void {
		}
		
		public function damageAppliedToPlayer(box:DamageBox, player:Player):void {
		}
		
		public function damagePlayerHitbox(box:DamageBox):String {
			return Player.HITBOX_BODY;
		}
		
		private function eventLoop(e:Event) {
			this.setDamageBoxDelegate(this);
		}
	
	}

}