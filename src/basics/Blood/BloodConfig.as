package basics.Blood {
	import utilities.Random;
	
	/**
	 * Configuration class for the bloodsplatter in the healthentity.
	 * @author Gabriel
	 */
	public class BloodConfig {
		public var xOffset = 10;
		public var xRange = 20;
		public var yOffset = 0;
		public var yRange = 50;
		
		/**
		 * Returns a BloodSplatter configured with the current values of this config.
		 */
		public function get Splatter():BloodSplatter {
			var blood:BloodSplatter = new BloodSplatter();
			blood.y -= Random.random(this.yRange) - this.yOffset;
			blood.x -= Random.random(this.xRange) - this.xOffset;
			return blood;
		}
	}

}