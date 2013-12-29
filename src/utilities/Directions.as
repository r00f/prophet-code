package utilities {
	
	/**
	 * Constants for the Directions.
	 */
	
	public final class Directions extends Object {
		
		public static function get LEFT():Directions {
			return new Directions(Directions._left);
		}
		
		public static function get RIGHT():Directions {
			return new Directions(Directions._right);
		}
		
		public static function get UP():Directions {
			return new Directions(Directions._up);
		}
		
		public static function get DOWN():Directions {
			return new Directions(Directions._down);
		}
		
		public static function get LEFT_UP():Directions {
			return new Directions(Directions._left + Directions._up);
		}
		
		public static function get LEFT_DOWN():Directions {
			return new Directions(Directions._left + Directions._down);
		}
		
		public static function get RIGHT_UP():Directions {
			return new Directions(Directions._left + Directions._up);
		}
		
		public static function get RIGHT_DOWN():Directions {
			return new Directions(Directions._left + Directions._down);
		}
		
		private static const strLEFT:String = "left";
		private static const strRIGHT:String = "right";
		private static const strUP:String = "up";
		private static const strDOWN:String = "down";
		
		public static const _none:Number = 0;
		public static const _up:Number = 1;
		public static const _down:Number = 2;
		public static const _left:Number = 4;
		public static const _right:Number = 8;
		
		public var current:Number;
		
		public function Directions(current:Number = _none) {
			this.current = current;
		}
		
		public function get isUp() {
			return (this.current & _up) != 0;
		}
		
		public function get isDown() {
			return (this.current & _down) != 0;
		}
		
		public function get isLeft() {
				return (this.current & _left) != 0;
		}
		
		public function get isRight() {
			return (this.current & _right) != 0;
		}
		
		public function toString():String {			
			var horizontal:String = "";
			if (this.isLeft()) {
				horizontal += Directions.strLEFT;
			} else if (this.isRight()) {
				horizontal += Directions.strRIGHT;
			}
			var vertical:String = "";
			if (this.isUp()) {
				vertical += Directions.strUP;
			} else if (this.isDown()) {
				vertical += Directions.strDOWN;
			}
			if (vertical != "") {
				horizontal += Utilities.ANIMATION_SEPERATOR
			}
			return horizontal + vertical
		}
		
		public function opposite():Directions {
			var direction = new Directions();
			direction.current = current;
			return direction.reverse();
		}
		
		/**
		 * Reverses the direction
		 */
		public function reverse():void {
			this.current = 0;
			if (this.isLeft()) {
				this.current |= Directions._right;
			} else if (this.isRight()) {
				this.current |= Directions._left;
			}
			if (this.isUp()) {
				this.current |= Directions._down;
			} else if (isDown()) {
				this.current |= Directions._up
			}
		}
	}
}