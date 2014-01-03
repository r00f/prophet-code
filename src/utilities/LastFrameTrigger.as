package utilities {
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.interfaces.ILastFrameTrigger;
	
	/**
	 * Triggers the delegate (must implement ILastFrameTrigger) when the last frame is exiting.
	 * Set this class as the BaseClass in the Symbol-Properties in Flash Professional. No Need to implement the subclass for simple animations.
	 * @author Gabriel
	 */
	public class LastFrameTrigger extends BaseClip {
		
		public var delegate:ILastFrameTrigger;
		
		private var alerted:Boolean = false;
		
		public function LastFrameTrigger() {
			super();
			addEventListener(Event.REMOVED_FROM_STAGE, cleanup, false, 0, true);
		}
		
		override public function setListeners(e:Event) 
		{
			super.setListeners(e);
			addEventListener(Event.EXIT_FRAME, checkForLastFrame, false, 0, true);
		}
		
		override public function resume(e:Event) 
		{
			super.resume(e);
			addEventListener(Event.EXIT_FRAME, checkForLastFrame, false, 0, true);
		}
		
		override public function pause(e:Event) 
		{
			super.pause(e);
			removeEventListener(Event.EXIT_FRAME, checkForLastFrame, false);
		}
		
		public function checkForLastFrame(e:Event) {
			if (this.currentFrame == this.totalFrames) {
				if (this.delegate != null && !alerted) {
					this.delegate.lastFrameEnded(this);
					alerted = true;
				}
			} else {
				alerted = false;
			}
		}
		
		public function cleanup(e:Event) {
			removeEventListener(Event.EXIT_FRAME, checkForLastFrame, false);
			removeEventListener(Event.REMOVED_FROM_STAGE, cleanup, false);
		}
	
	}

}