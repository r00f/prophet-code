package collectibles {
	import basics.entities.Entity;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Dominik Würsch
	 */
	public class ManaBauble extends Entity {
		
		public var regenAmount:Number = 2;
		protected var waitFrames:int = 10;
		
		public function ManaBauble() {
			super();
			addEventListener(Event.ENTER_FRAME, loop2, false, 0, false);

		}
		
		public function loop2(e:Event) {
			if (this.hitTestObject(rootRef.player.feet_hit)) {
				addEventListener(Event.ENTER_FRAME, wait, false, 0, false);
				
			}
		
		}
		
		public function wait(e:Event) {
			if (this.waitFrames > 0) {
				rootRef.player.manaRegen = this.regenAmount;
				this.waitFrames--;
			} else if (parent != null) {
				rootRef.player.manaRegen = 0;
				parent.removeChild(this);
				removeEventListener(Event.ENTER_FRAME, loop2, false)
			}
		}
	
	}

}