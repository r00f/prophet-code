package basics.Blood 
{
	/**
	 * Configuration class for the bloodsplatter in the healthentity.
	 * @author Gabriel
	 */
	public class BloodConfig 
	{
		public var xOffset = 10;
		public var xRange = 20;
		public var yOffset = 0;
		public var yRange = 50;
		
		
		public function get Splatter():BloodSplatter {
			var blood:BloodSplatter = new BloodSplatter();
			blood.y -= Random.random(this.blood.yRange) - this.blood.yOffset;
			blood.x -= Random.random(this.blood.xRange) - this.blood.xOffset;
			return blood;
		}
	}

}