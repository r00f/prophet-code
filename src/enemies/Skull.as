package enemies {
	
	import basics.hitboxes.BodyBox;
	import basics.hitboxes.AttackBox;
	import basics.hitboxes.DamageBox;
	import enemies.base.Enemy;
	import enemies.base.Mover;
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.*;
	import utilities.interfaces.IAttackTrigger;
	import utilities.interfaces.IDamageTrigger;
	import utilities.interfaces.ILastFrameTrigger;
	
	public class Skull extends Mover implements IDamageTrigger {		
		private var damageAmount:Number;
		public var damage_box:DamageBox;
		
		public var AttackTriggerLeft:AttackBox;
		public var AttackTriggerRight:AttackBox;

		
		private var Wait;
		
		public function Skull() {
			super();
			this.blood.yRange = 50;
			this.blood.xRange = 50;
			Wait = Random.random(25);
			FixPositionX = int(this.x);
			FixPositionY = int(this.y);
			this.speed = Random.random(6) + 2;
			this.damageAmount = 5;
			xspeed = this.speed;
			yspeed = 0;
			this.direction = Directions.RIGHT;
			addEventListener(Event.ENTER_FRAME, wait, false, 0, true);
			addEventListener(Event.ENTER_FRAME, checkIfDead, false, 0, true);
			addEventListener(Event.ENTER_FRAME, setDamageDelegate, false, 0, true);
		}
		
		public function damageAppliedToPlayer(box:DamageBox, player:Player) {
			//if (!this.playerHit) {
				player.applyDamage(this.damageAmount);
				//playerHit = true;
		
		}
		
		public function damageAppliedToEnemy(box:DamageBox, enemy:Enemy) {
			if (enemy is Baby) {
				enemy.applyDamage(1);
			} 
		}
		
		public function wait(e:Event) {
			if (Wait > 0) {
				Wait--;
			} else {
				removeEventListener(Event.ENTER_FRAME, wait, false)
				addEventListener(Event.ENTER_FRAME, walk, false, 0, true);
			}
		}                                                                                                                          
		
		
		public function checkIfDead(e:Event) {
			if (this.HealthPercentage == 0) {
				xspeed = 0;
				yspeed = 0;
				this.gotoAndStop(Actions.DEATH + Utilities.ANIMATION_SEPERATOR + this.direction);
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
		
		override public function walk(e:Event):void {
			super.walk(e);
			this.gotoAndStop("skull"+Utilities.ANIMATION_SEPERATOR+Actions.WALK+Utilities.ANIMATION_SEPERATOR + this.direction);
		}
	}
}