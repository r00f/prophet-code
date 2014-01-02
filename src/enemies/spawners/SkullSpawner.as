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
		
		private var Wait = 150;
		
		public function SkullSpawner() {
			super();
			this.spawnRect = spawn_area.getRect(this.rootRef);
			
			addEventListener(Event.ENTER_FRAME, wait, false, 0, true);
		}
		
		public function wait(e:Event) {
			if (Wait > 0) {
				Wait--;
			} else {
				removeEventListener(Event.ENTER_FRAME, wait, false)
				addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			}
			trace("waiting");
		}
		
		public function loop(e:Event) {
			for (var i:int = 0; i < 5; i++) 
			{
				spawnEnemyAtPosition(new Point(spawnRect.x + Math.random() * spawnRect.width, spawnRect.y + Math.random() * spawnRect.height));
				
			}
			removeEventListener(Event.ENTER_FRAME, loop);
			
		}
	
		private function spawnEnemyAtPosition(pos:Point) {
			if (spawnRect.containsPoint(pos)) {
				var skull:Skull = new Skull(root as Root);
				skull.point = pos;
				this.rootRef.addEnemy(skull);
				
			}
		}
	
	}

}