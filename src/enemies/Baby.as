package enemies {
	
	import basics.hitboxes.BodyBox;
	import basics.hitboxes.AttackBox;
	import basics.hitboxes.DamageBox;
	import basics.Light;
	import enemies.base.Enemy;
	import enemies.base.Mover;
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.*;
	import utilities.interfaces.IAttackTrigger;
	import utilities.interfaces.ILastFrameTrigger;
	import utilities.interfaces.IDamageTrigger;
	
	/**
	 * Controls the baby animation.
	 * Implements IAttackTrigger to let the attackbox trigger the attack into the correct direction.
	 */
	public class Baby extends Mover implements IAttackTrigger, IDamageTrigger {
		private var nextAction:String = "idle";
		private var damageAmount:Number;
		public var AttackTriggerLeft:AttackBox;
		public var AttackTriggerRight:AttackBox;
		

		private var playerHit:Boolean = false;
		
		private var Wait;
		
		public function Baby() {
			super();
			Wait = Random.random(25);

			this.speed = Random.random(6) + 2;
			this.damageAmount = 1/this.speed * 100;
			xspeed = this.speed;
			yspeed = 0;
			this.direction = Directions.RIGHT;
			addEventListener(Event.ENTER_FRAME, wait, false, 0, true);
			this.despawnTime = 1;
		}
		
		public function damageAppliedToPlayer(box:DamageBox, player:Player) {
			if (!this.playerHit) {
				player.applyDamage(this.damageAmount);
				playerHit = true;
			}
		}
		
		public function damageAppliedToEnemy(box:DamageBox, enemy:Enemy) {
			if (enemy is Baby) {
				enemy.applyDamage(1);
			} else if (enemy is Skull) {
				enemy.heal(10);
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
		
		override public function walk(e:Event):void {
			super.walk(e);
			this.setAttackBoxDelegate(this);
			
			if (this.HealthPercentage == 0) {
				this.attackBoxTriggeredByPlayer(null);
				
				removeEventListener(Event.ENTER_FRAME, walk, false);
				return;
			}
			this.gotoAndStop("baby"+Utilities.ANIMATION_SEPERATOR + Actions.WALK +Utilities.ANIMATION_SEPERATOR + this.direction.toString);
		}
		
		private function setAttackTriggerDelegate() {
			if (this.AttackTriggerRight && this.AttackTriggerRight.delegate != this)
				this.AttackTriggerRight.delegate = this;
			if (this.AttackTriggerLeft && this.AttackTriggerLeft.delegate != this)
				this.AttackTriggerLeft.delegate = this;
		}
		
		public function setDamageDelegate(e:Event) {
			if (death_animation != null) {
				var attackTrigger:AttackAnimationTrigger = death_animation as AttackAnimationTrigger;
				if (attackTrigger.damage_box != null) {
					attackTrigger.damage_box.delegate = this;
					removeEventListener(Event.ENTER_FRAME, setDamageDelegate, false);
				}
			}
		}
		
		public function attackBoxTriggeredByPlayer(box:AttackBox) {
			xspeed = 0;
			yspeed = 0;
			this.gotoAndStop(Actions.DEATH + Utilities.ANIMATION_SEPERATOR + this.direction.toString);
			this.death_animation.delegate = this;
			
			addEventListener(Event.ENTER_FRAME, setDamageDelegate, false, 0, true);
			removeEventListener(Event.ENTER_FRAME, walk, false);
			removeEventListener(Event.ENTER_FRAME, wait, false);
		}
	}
}

