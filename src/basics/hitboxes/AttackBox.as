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
		}
		
		override public function init(e:Event) {
			super.init(e);
			addEventListener(Event.ENTER_FRAME, checkForPlayer, false, 0, true);
		}
		
		override public function cleanup(e:Event) {
			super.cleanup(e);
			this.delegate = null;
			removeEventListener(Event.ENTER_FRAME, checkForPlayer, false);
		}
		
		public function checkForPlayer(e:Event) {
			if (this.delegate != null && this.root != null) {
				if (this.hitTestObject(super.rootRef.player.feet_hit)) {
					this.delegate.attackBoxTriggeredByPlayer(this);
				}
			}
		}
	}
}
