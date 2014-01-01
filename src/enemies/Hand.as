package enemies {
	
	import basics.hitboxes.BodyBox;
	import basics.hitboxes.DamageBox;
	import basics.hitboxes.AttackBox;
	import enemies.base.Enemy;
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.Directions;
	import utilities.Actions;
	import utilities.interfaces.ILastFrameTrigger;
	import utilities.LastFrameTrigger;
	import utilities.Utilities;
	import utilities.KeyCodes;
	import utilities.interfaces.IAttackTrigger;
	
	/**
	 * Controls the hand.
	 * Impelments IAttackTrigger to trigger the correct attacks (left/right/up/down).
	 */
	public class Hand extends Enemy implements IAttackTrigger {
		
		public var AttackTriggerLeft:AttackBox;
		public var AttackTriggerRight:AttackBox;
		public var AttackTriggerUp:AttackBox;
		public var AttackTriggerDown:AttackBox;
		
		private var damageAmount:int;
		
		public var intro_animation:LastFrameTrigger;
		public var hit_left_animation:LastFrameTrigger;
		public var hit_right_animation:LastFrameTrigger;
		public var hit_up_animation:LastFrameTrigger;
		public var hit_down_animation:LastFrameTrigger;
		
		
		public function Hand() {
			super();
			this.damageAmount = 2;
			addEventListener(Event.ENTER_FRAME, setDelegateIfNotSet, false, 0, true);	
			this.gotoAndStop(Actions.INTRO);
			this.intro_animation.delegate = this;
		}
		
		override public function damageAppliedToPlayer(box:DamageBox, player:Player):void {
			player.applyDamage(this.damageAmount);
		}
		
		override public function damageAppliedToEnemy(box:DamageBox, enemy:Enemy):void {
			if (enemy is Baby) {
				enemy.applyDamage(1);
			} else if (enemy is Skull) {
				enemy.heal(10);
			}
		}
		override public function damagePlayerHitbox(box:DamageBox):String  {
			return "feet_hit";
		}
		
		public function setDelegateIfNotSet(e:Event) {
			if (this.rootRef.keyPresses.isDown(KeyCodes.J)) {
				this.gotoAndStop(Actions.DEATH);
			}
			Utilities.setAttackBoxDelegate(AttackTriggerLeft, this);
			Utilities.setAttackBoxDelegate(AttackTriggerRight, this);
			Utilities.setAttackBoxDelegate(AttackTriggerUp, this);
			Utilities.setAttackBoxDelegate(AttackTriggerDown, this);
			Utilities.setLastFrameTriggerDelegate(death_animation, this);
			Utilities.setLastFrameTriggerDelegate(hit_left_animation, this);
			Utilities.setLastFrameTriggerDelegate(hit_right_animation, this);
			Utilities.setLastFrameTriggerDelegate(hit_up_animation, this);
			Utilities.setLastFrameTriggerDelegate(hit_down_animation, this);
		}
		
		
		override public function lastFrameEnded(mv:MovieClip) {
			super.lastFrameEnded(mv);
			if (mv != death_animation) {
				this.gotoAndStop(Actions.IDLE);
			}
		}
		
		public function setDamageDelegate(e:Event) {
			this.setDamageBoxDelegate(this);
		}
		public function attackBoxTriggeredByPlayer(box:AttackBox) {
			var direction:Directions = new Directions();
			if (box == AttackTriggerLeft) {
				direction = Directions.LEFT;
			} else if  (box == AttackTriggerRight) {
				direction = Directions.RIGHT;
			} else if  (box == AttackTriggerUp) {
				direction = Directions.UP;				
			} else if  (box == AttackTriggerDown) {
				direction = Directions.DOWN;				
			}
			this.gotoAndStop(Actions.HIT + Utilities.ANIMATION_SEPERATOR + direction);
			addEventListener(Event.ENTER_FRAME, setDamageDelegate, false, 0, true);
		}
	}

}
