package interfaces {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * HealthBar implements the display of a healthbar, divided into 10 steps.
	 */
	public class HealthBar extends MovieClip {
		private var _currentHealth:Number;
		
		public function HealthBar(x:Number, y:Number, xscale:Number, yscale:Number) {
			super();
			this.currentHealth = 1;
			this.x = x;
			this.y = y;
			this.scaleX = xscale;
			this.scaleY = yscale;
		}
		
		private function get HealthFrame():int {
			return (int)(_currentHealth * (this.totalFrames -1)) + 1;
		}
		
		/**
		 * Set the current health percentage of the healthbar between 0 and 1
		 */
		public function set currentHealth(value:Number):void {
			_currentHealth = value;
			this.gotoAndStop(this.HealthFrame);
		}
	
	}

}
