package enemies.base {
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	import utilities.Directions;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Mover extends Enemy {
		protected var limit:Point = new Point(100, 50);
		
		protected var speed:Point;
		
		protected var fixedPoint:Point;
		
		protected var direction:Directions;
		
		protected var wait:int = 0;
		
		protected var moving:Boolean = false;
		
		public function Mover() {
			super();
		}
		
		override public function init() {
			super.init();
			this.fixedPoint = new Point(int(this.x), int(this.y));
			direction = new Directions();
			this.speed = new Point();
			addEventListener(Event.ENTER_FRAME, wait, false, 0, true);
		}
		
		override public function pause(e:Event) {
			super.pause(e);
			removeEventListener(Event.ENTER_FRAME, wait, false);
			removeEventListener(Event.ENTER_FRAME, walk, false);
		}
		
		override public function resume(e:Event) {
			super.resume(e);
			if (!this.dead) {  {
				addEventListener(Event.ENTER_FRAME, this.moving ? walk : wait, false, 0, true);
			}
		}
		
		public function wait(e:Event) {
			if (this.wait > 0) {
				this.wait--;
			} else {
				removeEventListener(Event.ENTER_FRAME, wait, false)
				addEventListener(Event.ENTER_FRAME, walk, false, 0, true);
				this.moving = true;
			}
		}
		
		override protected function die():void {
			super.die();
			removeEventListener(Event.ENTER_FRAME, wait, false);
			removeEventListener(Event.ENTER_FRAME, walk, false);
		}
		
		public function walk(e:Event):void {
			var next:Point = this.point;
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
			if (this.outsideAnyLimit(next) || this.rootRef.collidesWithEnvironment(next.add(new Point(-this.width / 2, 0))) || this.rootRef.collidesWithEnvironment(next.add(new Point(this.width / 2, 0)))) {
				this.direction.reverse();
			} else {
				this.x = next.x;
				this.y = next.y;
			}
		}
		
		private function outsideAnyLimit(position:Point) {
			return this.outsideLimit(position.x, this.fixedPoint.x, this.limit.x) || this.outsideLimit(position.y, this.fixedPoint.y, this.limit.y);
		}
		
		private function outsideLimit(value:Number, fix:Number, limit:Number) {
			return value < (fix - limit) || value > (fix + limit);
		}
	}

}