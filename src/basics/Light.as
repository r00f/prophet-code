package basics {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.BlendMode;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Light extends MovieClip {
		
		private var _entity:Entity;
		
		private var intrinsic_x_offset;
		private var intrinsic_y_offset;
		
		public function Light(entity:Entity = null) {
			super();
			this.entity = entity;
			this.intrinsic_x_offset = x;
			this.intrinsic_y_offset = y;
			this.blendMode = BlendMode.ALPHA;
		}
		
		public function set entity(entity:Entity) {
			if (entity != null) {
				_entity = entity;
				addEventListener(Event.ENTER_FRAME, trackEntity, false, 0, true);
			}
		}
		
		public function trackEntity(e:Event) {
			if (parent != null) {
				this.x = _entity.x - this.parent.x + this.intrinsic_x_offset;
				this.y = _entity.y - this.parent.y + this.intrinsic_y_offset;
			}
		}
	}

}