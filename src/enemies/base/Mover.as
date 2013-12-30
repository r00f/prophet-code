package enemies.base 
{
	import flash.events.Event;
	import utilities.Directions;
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Mover extends Enemy 
	{
		protected var HorizontalLimit:Number = 100;
		protected var VerticalLimit:Number = 50;
		
		protected var speed:Number
		protected var xspeed:Number;
		protected var yspeed:Number;
		
		protected var FixPositionX:Number;
		protected var FixPositionY:Number;
		
		protected var direction:Directions;
		
		public function Mover() 
		{
			super();
			this.FixPositionX = int(this.x);
			this.FixPositionY = int(this.y);
			direction = new Directions();
			
		}
		public function walk(e:Event):void {			
			var nextx:Number = this.x;
			var nexty:Number = this.y;
			if (this.direction.isLeft) {
				nextx -= this.speed;
			} else if (this.direction.isRight) {
				nextx += this.speed;
			}
			if (this.direction.isUp) {
				nexty -= this.speed;
			} else if (this.direction.isDown) {
				nexty += this.speed;
			}
			if (this.outsideAnyLimit(nextx, nexty) || this.rootRef.collidesWithEnvironment(this.x + xspeed, this.y + yspeed) || this.rootRef.collidesWithEnvironment(this.x + xspeed + this.width * 2 / 3, this.y + yspeed)) {
				xspeed = -xspeed;
				yspeed = -yspeed;
				this.direction.reverse();
			} else {
				this.x = nextx;
				this.y = nexty;
			}
			}
		
		private function outsideAnyLimit(x:Number, y:Number) {
			return this.outsideLimit(x,FixPositionX, HorizontalLimit) || this.outsideLimit(y,FixPositionY, VerticalLimit);
		}
		
		private function outsideLimit(value:Number, fix:Number, limit:Number) {
			return value < (fix - limit) ||  value > (fix + limit);
		}
	}

}