package utilities {
	import basics.hitboxes.InteractionBox;
	
	/**
	 * Helper functions to generate random numbers.
	 * @author Gabriel
	 */
	public class Random {
		
		public function Random() {
		
		}
		
		/**
		 *
		 * @param	n Upper Bound
		 * @return An int between 0 and n (excluding)
		 */
		public static function random(n:Number):Number {
			return ((int)(Math.random() * 1000)) % n;
		}
	
	}

}