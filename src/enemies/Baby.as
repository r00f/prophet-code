package enemies {
	
	import basics.hitboxes.BodyBox;
	import basics.hitboxes.AttackBox;
	import basics.hitboxes.DamageBox;
	import basics.Light;
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
	public class Baby extends Enemy implements IAttackTrigger, IDamageTrigger {
		private var HorizontalLimit = 100;
		private var VerticalLimit = 50;
		
		private var rootRef:Root;
		private var speed:Number;
		private var xspeed:Number;
		private var yspeed:Number;
		private var direction:String;
		private var nextAction:String = "idle";
		private var damageAmount:Number;
		
		public var AttackTriggerLeft:AttackBox;
		public var AttackTriggerRight:AttackBox;
		
		private var FixPositionX;
		private var FixPositionY;
		
		private var playerHit:Boolean = false;
		
		private var Wait;
		
		public function Baby() {
			super();
			this.rootRef = this.root as Root;
			Wait = Random.random(25);
			FixPositionX = int(this.x);
			FixPositionY = int(this.y);
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
		
		public function walk(e:Event):void {
			this.setAttackTriggerDelegate()
			
			if (this.HealthPercentage == 0) {
				this.attackBoxTriggeredByPlayer(null);
				
				removeEventListener(Event.ENTER_FRAME, walk, false);
				return;
			}
			
			if (this.x < (FixPositionX - HorizontalLimit)) {
				xspeed = this.speed;
				this.direction = Directions.RIGHT;
			}
			if (this.x > (FixPositionX + HorizontalLimit)) {
				
				xspeed = -this.speed;
				this.direction = Directions.LEFT;
			}
			
			if (this.y > (FixPositionY + VerticalLimit)) {
				yspeed = -this.speed;
				this.direction = Directions.UP;
			}
			
			if (this.y < (FixPositionY - VerticalLimit)) {
				yspeed = this.speed;
				this.direction = Directions.DOWN;
			}
			
			if ((xspeed != 0 || yspeed != 0)) {
				if (this.rootRef.collidesWithEnvironment(this.x + xspeed, this.y + yspeed) || this.rootRef.collidesWithEnvironment(this.x + xspeed + this.width * 2 / 3, this.y + yspeed)) {
					xspeed = -xspeed;
					this.direction = Directions.oppositeOf(this.direction);
				}
				this.nextAction = "baby_" + Actions.WALK + "_";
				this.x += xspeed;
				this.y += yspeed;
			}
			
			this.gotoAndStop(this.nextAction + this.direction);
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
			this.gotoAndStop(Actions.DEATH + "_" + this.direction);
			this.death_animation.delegate = this;
			
			addEventListener(Event.ENTER_FRAME, setDamageDelegate, false, 0, true);
			removeEventListener(Event.ENTER_FRAME, walk, false);
			removeEventListener(Event.ENTER_FRAME, wait, false);
		}
	}
}

