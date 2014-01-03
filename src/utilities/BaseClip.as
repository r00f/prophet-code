package utilities 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class BaseClip extends MovieClip 
	{
		
		public function BaseClip() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, setListeners, false, 0, true);
		}
		
		public function setListeners(e:Event) {
			if (this.stage != null) {
				stage.addEventListener(Root.EVENT_PAUSED, pause, false);
				stage.addEventListener(Root.EVENT_STARTED, init, false);
				stage.addEventListener(Root.EVENT_RESUMED, resume, false);
				removeEventListener(Event.ADDED_TO_STAGE, setListeners, false);
			}
		}
		
		public function init(e:Event) {
			
		}
				
		public function pause(e:Event) {
			stop();
		}
		
		public function resume(e:Event) {
			this.gotoAndPlay(this.currentFrame);
		}
		
	}

}