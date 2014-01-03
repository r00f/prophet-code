package basics {
	import basics.entities.Entity;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.BlendMode;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Light extends MovieClip {
		
		private var _entity:Entity;
		private var intrinsic_offset:Point;
		
		public function Light(entity:Entity = null) {
			super();
			this.visible = false;
			this.entity = entity;
			this.intrinsic_offset = new Point(x, y);
			this.blendMode = BlendMode.ALPHA;
			addEventListener(Event.ADDED_TO_STAGE, setListeners, false, 0, true);
		
		}
		
		public function setListeners(e:Event) {
			if (this.stage != null) {
				stage.addEventListener(Root.EVENT_PAUSED, pause, false);
				stage.addEventListener(Root.EVENT_RESUMED, resume, false);
				removeEventListener(Event.ADDED_TO_STAGE, setListeners, false);
			}
		}
		
		public function pause(e:Event) {
			this.stop();
		}
		
		public function resume(e:Event) {
			this.gotoAndPlay(this.currentFrame);
		}
		
		public function set entity(entity:Entity) {
			if (entity != null) {
				_entity = entity;
				addEventListener(Event.EXIT_FRAME, trackEntity, false, 0, true);
			}
		}
		
		public function trackEntity(e:Event) {
			if (parent != null) {
				this.x = _entity.x - this.parent.x + this.intrinsic_offset.x;
				this.y = _entity.y - this.parent.y + this.intrinsic_offset.y;
				this.visible = true;
			}
		}
	}

}