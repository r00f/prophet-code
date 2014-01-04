package basics.hitboxes {
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.BaseClip;
	import vendor.KeyObject;
	import utilities.KeyCodes;
	
	/**
	 * Sets itself to the visibility which root dictates with rootref.shouldHitboxBeVisible.
	 */
	public class Hitbox extends BaseClip {
		
		public function Hitbox() {
			super();
			addEventListener(Event.REMOVED_FROM_STAGE, cleanup, false); 
			this.visible = false;
			
		}
		
		public function cleanup(e:Event) {
		}
		
		override public function pause(e:Event) {
			super.pause(e),
			removeEventListener(Event.ENTER_FRAME, debugLoop, false);
		}
		
		override public function resume(e:Event) {
			super.resume(e);
			if (this.root != null) {
				addEventListener(Event.ENTER_FRAME, debugLoop, false, 0, true);
			}
		}
		
		override public function init() {
			super.init();
			this.setVisibility()
			addEventListener(Event.ENTER_FRAME, debugLoop, false, 0, true);
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
