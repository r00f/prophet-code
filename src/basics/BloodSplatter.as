package basics {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.Random;
	/**
	 * BloodSplatter scales randomely when its created and loops once and then removes itself from the stage.
	 */
	public class BloodSplatter extends MovieClip {
		
		public function BloodSplatter() {
			setup();
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
		private function setup():void {
			this.scaleX = Random.random(4) - 2;
			this.scaleY = Random.random(2);
			this.gotoAndPlay(1);
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
