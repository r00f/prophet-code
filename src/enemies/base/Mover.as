package enemies.base 
{
	import flash.events.Event;
	import flash.geom.Point;
	import utilities.Directions;
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Mover extends Enemy 
	{		
		protected var limit:Point = new Point(100, 50);
		
		protected var speed:Point;
		
		protected var fixedPoint:Point;
		
		protected var direction:Directions;
		
		public function Mover() 
		{
			super();			
			this.fixedPoint = new Point(int(this.x), int(this.y));
			direction = new Directions();
			this.speed = new Point();
			
		}
		public function walk(e:Event):void {				
			var next:Point = new Point(this.x, this.y);
			if (this.direction.isLeft) {
				next.x -= this.speed.x
			} else if (this.direction.isRight) {
				next.x += this.speed.x;
			}
			if (this.direction.isUp) {
				next.y -= this.speed.y;
			} else if (this.direction.isDown) {
				next.y += this.speed.y;
			}
			if (this.outsideAnyLimit(next.x, next.y) || this.rootRef.collidesWithEnvironment(this.x + speed.x, this.y + speed.y) || this.rootRef.collidesWithEnvironment(this.x + speed.x + this.width * 2 / 3, this.y + speed.y)) {
				this.direction.reverse();
			} else {
				this.x = next.x;
				this.y = next.y;
			}
			}
		
		private function outsideAnyLimit(x:Number, y:Number) {
			return this.outsideLimit(x,this.fixedPoint.x, this.limit.x) || this.outsideLimit(y,this.fixedPoint.y, this.limit.y);
		}
		
		private function outsideLimit(value:Number, fix:Number, limit:Number) {
			return value < (fix - limit) ||  value > (fix + limit);
		}
	}

}