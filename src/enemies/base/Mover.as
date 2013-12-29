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
		private var HorizontalLimit = 100;
		private var VerticalLimit = 50;
		
		protected var direction:Directions;
		
		public function Mover() 
		{
			super();
			direction = new Directions();
			
		}
		public function walk(e:Event):void {			
			if (this.x < (FixPositionX - HorizontalLimit)) {
				xspeed = this.speed;
				this.direction = Directions.RIGHT;
			}
			if (this.x > (FixPositionX + HorizontalLimit)) {
				
				xspeed = -this.speed;
				this.direction = Directions.LEFT;
			}
			
			if (this.y > (FixPositionY + VerticalLimit)) {
				yspeed = -this.speed;
				this.direction = Directions.UP;
			}
			
			if (this.y < (FixPositionY - VerticalLimit)) {
				yspeed = this.speed;
				this.direction = Directions.DOWN;
			}
			
			if ((xspeed != 0 || yspeed != 0)) {
				if (this.rootRef.collidesWithEnvironment(this.x + xspeed, this.y + yspeed) || this.rootRef.collidesWithEnvironment(this.x + xspeed + this.width * 2 / 3, this.y + yspeed)) {
					xspeed = -xspeed;
					this.direction = Directions.oppositeOf(this.direction);
				}
				this.x += xspeed;
				this.y += yspeed;
			}
		}
	}

}