package interfaces {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * HealthBar implements the display of a healthbar, divided into 10 steps.
	 */
	public class ManaBar extends MovieClip {
		private var _currentMana:Number;
		
		public function ManaBar(position:Point, scale:Point) {
			super();
			this.currentMana = 1;
			this.x = position.x;
			this.y = position.y;
			this.scaleX = scale.x;
			this.scaleY = scale.y;
		}
		
		private function get ManaFrame():int {
			return (int)(_currentMana * (this.totalFrames -1)) + 1;
		}
		
		/**
		 * Set the current health percentage of the healthbar between 0 and 1
		 */
		public function set currentMana(value:Number):void {
			_currentMana = value;
			this.gotoAndStop(this.ManaFrame);
		}
	
	}

}
