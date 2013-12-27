package utilities {
	
	/**
	 * Constants for the Directions.
	 */
	public final class Directions {
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		public static const UP:String = "up";
		public static const DOWN:String = "down";
		public static const NONE:String = "";
		
		/**
		 * Returns the opposite of dir.
		 * @param dir:String The Direction to find the opposite of
		 */
		public static function oppositeOf(dir:String) {
			if (dir == LEFT)
				return RIGHT;
			if (dir == RIGHT)
				return LEFT;
			if (dir == UP)
				return DOWN;
			if (dir == DOWN)
				return UP;
			return NONE;
		}
	}
}