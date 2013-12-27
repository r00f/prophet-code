package environment {
	import flash.display.MovieClip;
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
	}
}