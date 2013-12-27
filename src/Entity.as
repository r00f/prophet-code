package {
	import basics.hitboxes.AttackBox;
	import basics.hitboxes.CollisionBox;
	import basics.hitboxes.DamageBox;
	import basics.hitboxes.Hitbox;
	import basics.Light;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Entity extends MovieClip {
		private var lights:Vector.<Light> = new Vector.<Light>();
		
		public function Entity() {
			super();
			addEventListener(Event.ENTER_FRAME, moveLightToDarkness, false, 0, true);
		}
		
		protected function get Lights():Vector.<Light> {
			return lights;
		}
		
		public function get CollisionBoxes():Vector.<CollisionBox> {
			return Vector.<CollisionBox>(this.getBoxesOfType(CollisionBox));
		}
		
		public function get DamageBoxes():Vector.<DamageBox> {
			return Vector.<DamageBox>(this.getBoxesOfType(DamageBox));
		}
		
		public function get AttackBoxes():Vector.<AttackBox> {
			return Vector.<AttackBox>(this.getBoxesOfType(AttackBox));
		}
		
		private function getBoxesOfType(type:Class):Vector.<Hitbox> {
			var results:Vector.<Hitbox> = new Vector.<Hitbox>();
			for (var i:int = 0; i < this.numChildren; i++) {
				var obj:DisplayObject = getChildAt(i);
				if (obj is type) {
					results.push(obj);
				}
			}
			return results;
		}
		
		private function moveLightToDarkness(e:Event) {
			var rootRef:Root = root as Root;
			if (rootRef.darkness != null) {
				var removed:Vector.<Light> = new Vector.<Light>();
				for (var i:int = 0; i < this.numChildren; i++) {
					var child:DisplayObject = this.getChildAt(i);
					if (child is Light) {
						removed.push(child as Light);
					}
				}
				for (var lightNumber:int = 0; lightNumber < removed.length; lightNumber++) {
					var light:Light = removed[lightNumber];
					light.entity = this;
					this.removeChild(light);
					rootRef.darkness.addLight(light)
					this.lights.push(light);
				}
				removeEventListener(Event.ENTER_FRAME, moveLightToDarkness, false);
				addEventListener(Event.REMOVED_FROM_STAGE, removeLight, false, 0, true);
			}
		}
		
		private function removeLight(e:Event) {
			var rootRef:Root = root as Root;
			for (var i:int = 0; i < this.lights.length; i++) {
				rootRef.darkness.removeChild(this.lights[i]);
			}
		}
	}

}