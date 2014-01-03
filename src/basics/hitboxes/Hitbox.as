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
			addEventListener(Event.REMOVED_FROM_STAGE, cleanup, false);
			
			addEventListener(Event.ADDED_TO_STAGE, setListeners, false, 0, true);
			
		}
		
		public function setListeners(e:Event) {
			if (this.stage != null) {
				stage.addEventListener(Root.EVENT_STARTED, init, false);
				stage.addEventListener(Root.EVENT_PAUSED, pause, false);
				stage.addEventListener(Root.EVENT_RESUMED, resume, false);
				removeEventListener(Event.ADDED_TO_STAGE, setListeners, false);
			}
			
		}
		
		public function cleanup(e:Event) {
		}
		
		public function pause(e:Event) {
			removeEventListener(Event.ENTER_FRAME, debugLoop, false);
		}
		
		public function resume(e:Event) {
			addEventListener(Event.ENTER_FRAME, debugLoop, false, 0, true);
		}
		
		public function init(e:Event) {
			if (this.root != null) {
				this.rootRef = root as Root;
				this.setVisibility()
				addEventListener(Event.ENTER_FRAME, debugLoop, false, 0, true);
				stage.removeEventListener(Root.EVENT_STARTED, init, false);
			}
		}
		
		
		
		
		public function debugLoop(e:Event) {
			setVisibility();
		}
		
		private function setVisibility() {
			if (this.rootRef != null) {
				this.visible = rootRef.shouldHitboxBeVisible;
			}
		}
	
	}

}
