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
		public function Zombie() 
		{
			super();
			// Do not just reverse direction
			this.FixPositionX = 0;
			this.FixPositionY = 0;
			this.speed = 2.5;
			this.HorizontalLimit = Number.MAX_VALUE;
			this.VerticalLimit = Number.MAX_VALUE;
			addEventListener(Event.ENTER_FRAME, walk, false, 0, true);
			this.gotoAndPlay("idle");
		}
		
		private function updateDirection():void {
			var xdiff = this.x - this.rootRef.player.x;
			var ydiff = this.y - this.rootRef.player.y;
			this.direction.current = Directions._none;
			if (xdiff > nearLimit) {
				this.direction.current += Directions._left;
			} else if (xdiff < -nearLimit) {
				this.direction.current += Directions._right;
			}
			
			if (ydiff > nearLimit) {
				this.direction.current += Directions._up;
			} else if (ydiff < -nearLimit) {
				this.direction.current += Directions._down;
			}
			
		}
		
		override public function walk(e:Event):void 
		{
			this.updateDirection();
			super.walk(e);
		}
		
		
		
	}

}