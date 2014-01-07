package collectibles {
	import basics.entities.Entity;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Dominik Würsch
	 */
	public class HealthBauble extends Entity {
		
		public var healAmount:Number = 2;
		protected var waitFrames:int = 10;
		
		public function HealthBauble() {
			super();
			addEventListener(Event.ENTER_FRAME, loop2, false, 0, false);
		}
		
		public function loop2(e:Event) {
			if (this.hitTestObject(rootRef.player.feet_hit)) {
				if (this.waitFrames > 0) {
					rootRef.player.healthRegen = this.healAmount;
					this.waitFrames--;
				} else {
					rootRef.player.healthRegen = 0;
					parent.removeChild(this);
					removeEventListener(Event.ENTER_FRAME, loop2, false)
				}
				
			}
		
		}
	
	}

}