package enemies 
{
	import enemies.base.Enemy;
	import enemies.base.Mover;
	import flash.events.Event;
	import utilities.Directions;
	import utilities.Utilities;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Zombie extends Mover 
	{
		private var nearLimit = 20;
		private var directions:Directions;
		public function Zombie() 
		{
			super();
			this.directions = new Directions();
			// Do not just reverse direction
			this.FixPositionX = 0;
			this.FixPositionY = 0;
			this.HorizontalLimit = Number.MAX_VALUE;
			this.VerticalLimit = Number.MAX_VALUE;
			
		}
		
		private function updateDirection():void {
			var xdiff = this.x - this.rootRef.player.x;
			var ydiff = this.y - this.rootRef.player.y;
			if (xdiff > nearLimit) {
				this.directions.current += Directions._left;
			} else if (xdiff < -nearLimit) {
				directions.current += Directions._right;
			}
			
			if (ydiff > nearLimit) {
				directions.current += Directions._up;
			} else if (ydiff < -nearLimit) {
				directions.current += Directions._down;
			}
		}
		
		override public function walk(e:Event):void 
		{
			trace("walking");
			this.updateDirection();
			super.walk(e);
			this.gotoAndPlay("idle" + Utilities.ANIMATION_SEPERATOR + this.direction);
		}
		
		
		
	}

}