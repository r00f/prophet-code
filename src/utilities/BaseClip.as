package utilities 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * BaseClip is the baseclass for this game. It is a clip which pauses and resumes itself when it catches an event of Type Root.EVENT_PAUSED;
	 * @author Gabriel
	 */
	public class BaseClip extends MovieClip 
	{
				
		protected var rootRef:Root;
		public function BaseClip() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, setListeners, false, 0, true);
		}
		
		public function setListeners(e:Event) {
			if (this.root != null) {
				this.rootRef = root as Root;
				root.addEventListener(Root.EVENT_PAUSED, pause, false);
				root.addEventListener(Root.EVENT_RESUMED, resume, false);
				removeEventListener(Event.ADDED_TO_STAGE, setListeners, false);
				this.init();
			}
		}
		
		/**
		 * Override this function and initialize the Movieclip within it. 
		 * Will be called once as soon as the root is available (happens in an Event.ADDED_TO_STAGE event).
		 */
		public function init() {
			if (this.root != null) {
				this.rootRef = root as Root;
			}
		}
		
		/**
		 * Override this function and remove any eventlisteners to "pause" the class
		 * @param	e: The event, type will be Root.EVENT_PAUSED.
		 */
		public function pause(e:Event) {
			stop();
		}
		/**
		 * Override this function and re-add any eventlisteners removed in the pause function.
		 * @param	e: The event, type will be Root.EVENT_PAUSED.
		 */
		public function resume(e:Event) {
			this.gotoAndPlay(this.currentFrame);
		}
		
	}

}