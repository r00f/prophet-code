package interfaces {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * HealthBar implements the display of a healthbar, divided into 10 steps.
	 */
	public class HealthBar extends MovieClip {
		private var _currentHealth:Number;
		
		public function HealthBar(position:Point, scale:Point) {
			super();
			this.currentHealth = 1;
			this.x = position.x;
			this.y = position.y;
			this.scaleX = scale.x;
			this.scaleY = scale.y;
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
