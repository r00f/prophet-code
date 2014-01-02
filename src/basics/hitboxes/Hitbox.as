package basics.hitboxes {
	import flash.display.MovieClip;
	import flash.events.Event;
	import vendor.KeyObject;
	import utilities.KeyCodes;
	
	/**
	 * Sets itself to the visibility which root dictates with rootref.shouldHitboxBeVisible.
	 */
	public class Hitbox extends MovieClip {
		
		protected var rootRef:Root;
		
		public function Hitbox() {
			super();
			addEventListener(Event.ENTER_FRAME, init, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, cleanup, false);
		}
		
		public function cleanup(e:Event) {
		}
		
		public function init(e:Event) {
			if (this.root != null) {
				this.rootRef = root as Root;
				this.setVisibility()
				addEventListener(Event.ENTER_FRAME, debugLoop, false, 0, true);
				removeEventListener(Event.ENTER_FRAME, init, false);
			}
		}
		
		
		
		
		public function debugLoop(e:Event) {
			setVisibility();
		}
		
		private function setVisibility() {
			if (this.rootRef != null) {
				this.alpha = rootRef.shouldHitboxBeVisible ? 1 : 0;
			}
		}
	
	}

}
