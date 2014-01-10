package enemies {
	
	import basics.hitboxes.BodyBox;
	import basics.hitboxes.AttackBox;
	import basics.hitboxes.DamageBox;
	import enemies.base.Enemy;
	import enemies.base.Mover;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import utilities.*;
	import utilities.interfaces.IAttackTrigger;
	import utilities.interfaces.IDamageTrigger;
	import utilities.interfaces.ILastFrameTrigger;
	
	public class Skull extends Mover implements IDamageTrigger {
		
		[Inspectable(defaultValue=5,name="Base Damage",type="Number",variable="damageAmount")]
		public var damageAmount:Number = 5;
		public var damage_box:DamageBox;
		
		public var AttackTriggerLeft:AttackBox;
		public var AttackTriggerRight:AttackBox;
		public var walk_animation:MovieClip;
		
		public function Skull(rootVar:Root = null) {
			super();
			if (this.rootRef != null && rootVar != null) {
				this.rootRef = rootVar;
			}
		}
		
		override public function init() {
			super.init();
			this.blood.yRange = 50;
			this.blood.yOffset = -100;
			this.blood.xRange = 50;
			speed.x = Random.random(6) + 2;
			speed.y = 0;
			this.limit.y = 145;
			this.direction = Directions.RIGHT;
			addEventListener(Event.ENTER_FRAME, setDamageDelegate, false, 0, true);
		}
		
		override public function pause(e:Event) {
			super.pause(e);
			removeEventListener(Event.ENTER_FRAME, setDamageDelegate, false);
		}
		
		override public function resume(e:Event) {
			super.resume(e);
			addEventListener(Event.ENTER_FRAME, setDamageDelegate, false, 0, true);
		}
		
		override public function damageAppliedToPlayer(box:DamageBox, player:Player):void {
			player.applyDamage(this.damageAmount);
		
		}
		
		override public function damageAppliedToEnemy(box:DamageBox, enemy:Enemy):void {
			if (enemy is Baby) {
				enemy.applyDamage(1);
			}
		}
		
		override public function set point(p:Point):void {
			super.point = p;
		}
		
		override public function wait(e:Event) {
			super.wait(e);
			if (this.walk_animation != null) {
				this.walk_animation.stop();
			}
		}
		
		override protected function die():void {
			super.die();
			speed = new Point();
			this.gotoAndStop(Actions.DEATH + Strings.ANIMATION_SEPERATOR + this.direction);
			this.blood.yOffset = 0;
			super.death_animation.delegate = this;
		}
		
		public function setDamageDelegate(e:Event) {
			this.setDamageBoxDelegate(this);
			if (damage_box != null) {
				damage_box.delegate = this;
				removeEventListener(Event.ENTER_FRAME, setDamageDelegate, false);
			}
		}
		private var yCurveOffset = 0;
		private var frameChange = 5;
		private var maxYCurve = 20;
		
		override public function walk(e:Event):void {
			super.walk(e);
			if (this.walk_animation != null) {
				this.walk_animation.play();
			}
			if (Math.abs(yCurveOffset) > maxYCurve) {
				frameChange = -frameChange;
			}
			yCurveOffset += frameChange;
			this.y += frameChange;
			this.gotoAndStop("skull" + Strings.ANIMATION_SEPERATOR + Actions.WALK + Strings.ANIMATION_SEPERATOR + this.direction);
		}
	}
}