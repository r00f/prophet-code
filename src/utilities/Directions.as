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
		
		public static const _up:Number = 1;
		public static const _down:Number = 2;
		public static const _left:Number = 4;
		public static const _right:Number = 8;
		
		public var current:Number;
		
		public function Directions(current:Number = 0) {
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
			var dirs:Object = decompose();
			
			var string:String = "";
			if (dirs[Directions.strLEFT] != 0) {
				string += Directions.strLEFT;
			} else if (dirs[Directions.strRIGHT] != 0) {
				string += Directions.strRIGHT;
			}
			if (dirs[Directions.strUP] != 0) {
				if (string != "") {
					string += Utilities.ANIMATION_SEPERATOR;
				}
				string += Directions.strUP;
			} else if (dirs[Directions.strDOWN] != 0) {
				if (string != "") {
					string += Utilities.ANIMATION_SEPERATOR
				}
				string += Directions.strDOWN;
			}
			return string;
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
			var dirs:Object = decompose();
			this.current = 0;
			if (dirs[Directions.strLEFT] != 0) {
				this.current |= Directions._right;
			} else if (dirs[Directions.strRIGHT] != 0) {
				this.current |= Directions._left;
			}
			if (dirs[Directions.strUP] != 0) {
				this.current |= Directions._down;
			} else if (dirs[Directions.strDOWN] != 0) {
				this.current |= Directions._up
			}
		}
		
		private function decompose():Object {
			var returnObject = new Object();
			returnObject[Directions.strLEFT] = this.current & Directions._left;
			returnObject[Directions.strRIGHT] = this.current & Directions._right;
			returnObject[Directions.strUP] = this.current & Directions._up;
			returnObject[Directions.strDOWN] = this.current & Directions._down;
			return returnObject;
		}
	}
}