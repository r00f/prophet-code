package basics.entities {
	import basics.hitboxes.AttackBox;
	import basics.hitboxes.CollisionBox;
	import basics.hitboxes.DamageBox;
	import basics.hitboxes.Hitbox;
	import basics.Light;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	import utilities.BaseClip;
	import utilities.interfaces.IAttackTrigger;
	import utilities.interfaces.IDamageTrigger;
	import utilities.interfaces.ILastFrameTrigger;
	import utilities.LastFrameTrigger;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Entity extends BaseClip {
		private var lights:Vector.<Light> = new Vector.<Light>();
		private var nextFrameKnockback:Point = new Point();
		
		public function Entity() {
			super();
			addEventListener(Event.REMOVED_FROM_STAGE, cleanup, false, 0, true);
		}
		
		override public function init() 
		{
			super.init();
			addEventListener(Event.ENTER_FRAME, moveLightToDarkness, false, 0, true);
		}
		
		public function cleanup(e:Event) {
			for (var i:int = 0; i < this.lights.length; i++) {
				rootRef.darkness.removeChild(this.lights[i]);
			}
		}
		
		public function get point():Point {
			return new Point(this.x, this.y);
		}
		
		
		private function findPointWithNoCollision(p:Point, kb:Point ):Point {
			if (this.rootRef != null) {
				while (this.rootRef.collidesWithEnvironment(p.add(kb)))  {
					kb = new Point(0.9 * kb.x, 0.9 * kb.y);
				}
			}
			return p.add(kb);	
		}
		
		public function set point(p:Point):void {
			var nextPoint:Point = this.findPointWithNoCollision(p, this.nextFrameKnockback);
			nextFrameKnockback = new Point();
			this.x = nextPoint.x;
			this.y = nextPoint.y;
		}
		
		protected function get Lights():Vector.<Light> {
			return lights;
		}
		
		public function get CollisionBoxes():Vector.<CollisionBox> {
			return Vector.<CollisionBox>(this.getBoxesOfTypeInClip(CollisionBox, this));
		}
		
		public function get DamageBoxes():Vector.<DamageBox> {
			return Vector.<DamageBox>(this.getBoxesOfTypeInClip(DamageBox, this));
		}
		
		public function get AttackBoxes():Vector.<AttackBox> {
			return Vector.<AttackBox>(this.getBoxesOfTypeInClip(AttackBox, this));
		}
		
		protected function setAttackBoxDelegate(delegate:IAttackTrigger) {
			this.AttackBoxes.forEach(function(box:AttackBox, idx, test) {
					box.delegate = delegate;
				});
		}
		
		protected function setDamageBoxDelegate(delegate:IDamageTrigger) {
			this.DamageBoxes.forEach(function(box:DamageBox, idx, mv) {
					box.delegate = delegate;
				});
		}
		
		protected function setLastFrameTriggerDelegate(delegate:ILastFrameTrigger) {
			this.LastFrameTriggers.forEach(function(clip:LastFrameTrigger, idx, test) {
					clip.delegate = delegate;
				});
		}
		
		private function getBoxesOfTypeInClip(type:Class, movieClip:MovieClip):Vector.<Hitbox> {
			var results:Vector.<Hitbox> = new Vector.<Hitbox>();
			for (var i:int = 0; i < movieClip.numChildren; i++) {
				var obj:DisplayObject = movieClip.getChildAt(i);
				if (obj is MovieClip) {
					this.getBoxesOfTypeInClip(type, obj as MovieClip).forEach(function(box:Hitbox, idx, mv) {
							results.push(box);
						});
				}
				if (obj is type) {
					results.push(obj);
				}
			}
			return results;
		}
		
		private function get LastFrameTriggers():Vector.<LastFrameTrigger> {
			var results:Vector.<LastFrameTrigger> = new Vector.<LastFrameTrigger>();
			for (var i:int = 0; i < this.numChildren; i++) {
				var obj:DisplayObject = this.getChildAt(i);
				if (obj is LastFrameTrigger) {
					results.push(obj);
				}
			}
			return results;
		}
		
		private function moveLightToDarkness(e:Event) {
			if (rootRef != null && rootRef.darkness != null) {
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
			}
		}
		
		
		public function knockback(knockback:Point) {
			this.nextFrameKnockback = knockback;
		}
	}

}