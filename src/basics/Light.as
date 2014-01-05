package basics {
	import basics.entities.Entity;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.BlendMode;
	import flash.geom.Point;
	import utilities.BaseClip;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Light extends BaseClip {
		
		private var _entity:Entity;
		private var intrinsic_offset:Point;
		
		public function Light(entity:Entity = null) {
			super();
			this.visible = false;
			this.entity = entity;
			this.intrinsic_offset = new Point(x, y);
			this.blendMode = BlendMode.ALPHA;
		
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