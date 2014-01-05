package environment {
	import basics.entities.Entity;
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.*;
	
	/**
	 * Basic Environment class. Starts playing a random frame when it is constructed.
	 * @author Gabriel
	 */
	public dynamic class Environment extends Entity {
		
		public function Environment() {
			super();
			this.gotoAndPlay(Random.random(this.totalFrames));
		}
		
		override public function pause(e:Event) 
		{
			super.pause(e);
			stop();
		}
		
		override public function resume(e:Event) 
		{
			super.resume(e);
			this.gotoAndPlay(this.currentFrame);
		}
	}
}