package basics.hitboxes {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.interfaces.IAttackTrigger;
	
	/**
	 * Triggers if the player is within the attackbox (if the delegate which implements IAttackTrigger is set).
	 * @author Gabriel Nadler
	 */
	public class AttackBox extends Hitbox {
		
		public var delegate:IAttackTrigger;
		
		public function AttackBox() {
			super()
			addEventListener(Event.ENTER_FRAME, checkForPlayer, false, 0, true);
		}
		
		public function checkForPlayer(e:Event) {
			if (this.delegate != null) {
				if (this.hitTestObject(super.rootRef.player.feet_hit)) {
					this.delegate.attackBoxTriggeredByPlayer(this);
				}
			}
		}
	}
}
