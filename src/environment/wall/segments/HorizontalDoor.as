package environment.wall.segments {
	import basics.hitboxes.CollisionBox;
	import basics.hitboxes.InteractionBox;
	import utilities.Random;
	import flash.events.Event;
	
	/**
	 * Horizontal Door has a lot more hitboxes than the basesegment and can be opened.
	 */
	public dynamic class HorizontalDoor extends BaseSegment {
		public var DoorTrigger:InteractionBox;
		
		private static const LABEL_OPEN:String = "open";
		private static const LABEL_CLOSED:String = "closed";
		
		private var doorOpening:Boolean = false;
		private var open:Boolean = false;
		
		public function get isDoorOpen():Boolean {
			return this.doorOpening;
		}
		
		public function HorizontalDoor() {
			super();
			this.gotoAndStop(HorizontalDoor.LABEL_CLOSED);
		}
		
		override public function resume(e:Event) {
			super.resume(e);
			if (this.open) {
				this.gotoAndStop(this.currentFrame);
			} else if (!doorOpening) {
				this.gotoAndStop(LABEL_CLOSED);
			} else {
				this.gotoAndPlay(this.currentFrame);
			}
		}
		
		override public function cleanup(e:Event) {
			super.cleanup(e);
			removeEventListener(Event.ENTER_FRAME, loop, false);
		}
		
		override public function init() {
			super.init();
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
		public function loop(e:Event):void {
			
			if (DoorTrigger.hitTestObject(rootRef.player) && !this.doorOpening && this.rootRef.attackPressed) {
				this.gotoAndPlay(HorizontalDoor.LABEL_OPEN);
				this.doorOpening = true;
			}
			
			if (this.currentFrame == this.totalFrames && this.doorOpening) {
				stop();
				this.open = true;
			}
		}
	}
}