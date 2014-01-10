package basics.regen {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.Random;
	
	/**
	 * ...
	 * @author ...
	 */
	public class RegenerationEffect extends MovieClip {
		
		public function RegenerationEffect() {
			
			setup();
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		
		}
		
		private function setup():void {
			this.gotoAndPlay(Random.random(40));
		}
		
		public function loop(e:Event):void {
			if (this.currentFrame == this.totalFrames) {
				removeEventListener(Event.ENTER_FRAME, loop, false);
				parent.removeChild(this);
				this.stop();
			}
		
		}
	
	}
}