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
			this.rootRef = root as Root;
			this.setVisibility()
			addEventListener(Event.ENTER_FRAME, debugLoop, false, 0, true);
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
	