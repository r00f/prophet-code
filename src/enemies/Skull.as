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
		
		[Inspectable(defaultValue=5, name="Base Damage", type="Number", variable="damageAmount")]
		public var damageAmount:Number = 5;
		public var damage_box:DamageBox;  
		
		public var AttackTriggerLeft:AttackBox;
		public var AttackTriggerRight:AttackBox;
		public var walk_animation:MovieClip;

		
		private var Wait;
		
		public function Skull(root:Root) {
			super();
			this.rootRef = root;
		}
		
		
		override public function init(e:Event) 
		{
			super.init(e);
			this.blood.yRange = 50;
			this.blood.yOffset = -100;
			this.blood.xRange = 50;
			Wait = Random.random(25);
			speed.x= Random.random(6) + 2;
			speed.y = 0;
			this.limit.y = 145;
			this.direction = Directions.RIGHT;
			addEventListener(Event.ENTER_FRAME, wait, false, 0, true);
			addEventListener(Event.ENTER_FRAME, checkIfDead, false, 0, true);
			addEventListener(Event.ENTER_FRAME, setDamageDelegate, false, 0, true);
		}
		
		override public function damageAppliedToPlayer(box:DamageBox, player:Player):void {
			//if (!this.playerHit) {
				player.applyDamage(this.damageAmount);
				//playerHit = true;
		
		}
		
		override public function damageAppliedToEnemy(box:DamageBox, enemy:Enemy):void {
			if (enemy is Baby) {
				enemy.applyDamage(1);
			} 
		}
		
		override public function set point(p:Point):void {
			super.point = p;
			this.fixedPoint = p;
		}
		
		public function wait(e:Event) {
			if (Wait > 0) {
				Wait--;
				this.walk_animation.stop();
			} else {
				this.walk_animation.play();
				removeEventListener(Event.ENTER_FRAME, wait, false)
				addEventListener(Event.ENTER_FRAME, walk, false, 0, true);
			}
		}
		
		public function checkIfDead(e:Event) {
			if (this.HealthPercentage == 0) {
				speed = new Point();
				this.gotoAndStop(Actions.DEATH + Strings.ANIMATION_SEPERATOR + this.direction);
				this.blood.yOffset = 0;
				super.death_animation.delegate = this;
				removeEventListener(Event.ENTER_FRAME, walk, false);
				removeEventListener(Event.ENTER_FRAME, wait, false);
			}
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
			if (Math.abs(yCurveOffset) > maxYCurve) {
				frameChange = -frameChange;
			}
			yCurveOffset += frameChange;
			this.y += frameChange;
			this.gotoAndStop("skull"+Strings.ANIMATION_SEPERATOR+Actions.WALK+Strings.ANIMATION_SEPERATOR + this.direction);
		}
	}
}