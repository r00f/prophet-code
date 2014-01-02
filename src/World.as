package {
	import basics.Darkness;
	import basics.entities.Entity;
	import basics.hitboxes.CollisionBox;
	import enemies.base.Enemy;
	import environment.Environment;
	import environment.wall.segments.HorizontalDoor;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class World extends MovieClip {
		
		public var darkness:Darkness;
		public var player:Player;
		
		public function World() {
			super();
			
			addEventListener(Event.ENTER_FRAME, sort, false, 0, true);
		}
		
		public function get Enemies():Vector.<Enemy> {
			var resultVector:Vector.<Enemy> = new Vector.<Enemy>();
			for (var i:int = 0; i < this.numChildren; i++) {
				var child:DisplayObject = this.getChildAt(i);
				if (child is Enemy) {
					resultVector.push(child as Enemy)
				}
			}
			return resultVector;
		}
		
		public function sort(e:Event) {
			
			//prepare an array
			var sortArray:Array = [];
			;
			//put the children into an array
			for (var i:int = 0; i < this.numChildren; i++) {
				sortArray[i] = this.getChildAt(i);
			}
			//get a sorting function ready
			function customSort(childClip:DisplayObject, childClip2:DisplayObject):int {
				if (childClip is Entity && childClip2 is Entity) {
					var door:HorizontalDoor;
					if (childClip is HorizontalDoor && childClip2 is Player) {
						door = childClip as HorizontalDoor;
						return (door.isDoorOpen && door.y + 25 > childClip2.y) ? 1 : -1;
					} else if (childClip is Player && childClip2 is HorizontalDoor) {
						door = childClip2 as HorizontalDoor;
						return (door.isDoorOpen && door.y + 25 > childClip.y) ? -1 : 1;
					}
					if (childClip.y < childClip2.y) {
						return -1;
					} else if (childClip.y > childClip2.y) {
						return 1;
					} else
						return 0;
				} else {
					if (childClip is Entity)
						return 1;
					else if (childClip2 is Entity)
						return -1;
					else
						return 0;
				}
			}
			
			//sort the array by y value low -> high
			sortArray.sort(customSort);
			//loop through the array resetting indexes
			for (i = 0; i < sortArray.length; i++) {
				this.setChildIndex(sortArray[i], i);
			}
			this.addChild(this.darkness);
		}
		
		public function collidesWithEnvironment(next:Point):Boolean {
			for (var i = 0; i < this.numChildren; i++) {
				var childClip:MovieClip = getChildAt(i) as MovieClip;
				if (childClip is Environment) {
					var env:Environment = childClip as Environment;
					for each (var hitbox:CollisionBox in env.CollisionBoxes) {
						if (hitbox.hitTestPoint(next.x, next.y, false)) {
							return true;
						}
					}
				}
			}
			return false;
		}
	}

}