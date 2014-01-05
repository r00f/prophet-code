package enemies.spawners {
	import basics.entities.Entity;
	import enemies.Skull;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class SkullSpawner extends Entity {
		public var spawn_area:MovieClip;
		
		private var spawnRect:Rectangle;
		
		private var spawned:Boolean = false;
		
		[Inspectable(defaultValue=5,name="No. Spawns")]
		public var spawn:Number = 5;
		
		private var Wait = 2 * 24;
		
		public function SkullSpawner() {
			super();
		}
		
		override public function pause(e:Event) {
			removeEventListener(Event.EXIT_FRAME, wait, false)
			removeEventListener(Event.EXIT_FRAME, loop);
		}
		
		override public function resume(e:Event) {
			if (Wait > 0) {
				addEventListener(Event.ENTER_FRAME, debugLoop, false, 0, true);
			} else if (!spawned) {
				addEventListener(Event.EXIT_FRAME, loop, false, 0, true);
			}
		}
		
		override public function init() {
			super.init();
			this.spawnRect = spawn_area.getRect(this.root)
			Wait = 2 * 24;
			addEventListener(Event.EXIT_FRAME, wait, false, 0, true);
			addEventListener(Event.ENTER_FRAME, debugLoop, false, 0, true);
		}
		
		public function wait(e:Event) {
			if (Wait > 0) {
				Wait--;
			} else {
				removeEventListener(Event.EXIT_FRAME, wait, false)
				addEventListener(Event.EXIT_FRAME, loop, false, 0, true);
			}
		}
		
		public function loop(e:Event) {
			for (var i:int = 0; i < spawn; i++) {
				spawnEnemyAtPosition(new Point(spawnRect.x + Math.random() * spawnRect.width, spawnRect.y + Math.random() * spawnRect.height));
			}
			this.spawned = true;
			removeEventListener(Event.EXIT_FRAME, loop);
		}
		
		private function spawnEnemyAtPosition(pos:Point) {
			if (spawnRect.containsPoint(pos)) {
				var skull:Skull = new Skull(root as Root);
				skull.point = pos;
				this.rootRef.addEntity(skull);
			}
		}
		
		public function debugLoop(e:Event) {
			setVisibility();
		}
		
		private function setVisibility() {
			if (this.rootRef != null) {
				this.alpha = rootRef.shouldHitboxBeVisible ? 1 : 0;
			}
		}
	}

}