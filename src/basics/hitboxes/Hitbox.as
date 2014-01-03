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
		
		protected var rootRef:Root;
		
		public function Hitbox() {
			super();
			addEventListener(Event.REMOVED_FROM_STAGE, cleanup, false); 
			addEventListener(Event.ENTER_FRAME, init, false);
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
		
		override public function init(e:Event) {
			if (e.type == Root.EVENT_STARTED) {
				return;
			}
			if (this.root != null) {
				this.rootRef = root as Root;
				this.setVisibility()
				addEventListener(Event.ENTER_FRAME, debugLoop, false, 0, true);
				stage.removeEventListener(Event.ENTER_FRAME, init, false);
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
