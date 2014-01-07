package basics.regen {
	import utilities.Random;
	
	/**
	 * ...
	 * @author ...
	 */
	public class RegenerationConfig {
		public var xOffset = 10;
		public var xRange = 20;
		public var yOffset = 0;
		public var yRange = 50;
		
		public function get Regen():RegenerationEffect {
			var regen:RegenerationEffect = new RegenerationEffect();
			regen.y -= Random.random(this.yRange) - this.yOffset;
			regen.x -= Random.random(this.xRange) - this.xOffset;
			return regen;
		
		}
	
	}

}