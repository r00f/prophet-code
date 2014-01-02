package enemies {
	
	import basics.hitboxes.AttackBox;
	import basics.hitboxes.DamageBox;
	import enemies.base.Enemy;
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.Actions;
	import utilities.Directions;
	import utilities.interfaces.IAttackTrigger;
	import utilities.Strings;
	
	/**
	 * Controls the hand.
	 * Impelments IAttackTrigger to trigger the correct attacks (left/right/up/down).
	 */
	public class Hand extends Enemy implements IAttackTrigger {
		
		public var AttackTriggerLeft:AttackBox;
		public var AttackTriggerRight:AttackBox;
		public var AttackTriggerUp:AttackBox;
		public var AttackTriggerDown:AttackBox;
		
		[Inspectable(defaultValue=2, name="Base Damage", type="Number", variable="damageAmount")]
		public var damageAmount:int;
		
		private var idle:Boolean = false;
		
		public function Hand() {
			super();
			this.blood.yRange = 120;
			this.damageAmount;
			this.gotoAndStop(Actions.INTRO);
			this.setLastFrameTriggerDelegate(this);
		}
		
		override protected function die():void {
			super.die();
			this.gotoAndStop(Actions.DEATH);
			this.setLastFrameTriggerDelegate(this);
		}
		
		/** IDamageBoxTrigger **/
		
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
		
		override public function damagePlayerHitbox(box:DamageBox):String {
			return Player.HITBOX_FEET;
		}
		
		/** ILastFrameTrigger **/
		
		override public function lastFrameEnded(mv:MovieClip) {
			super.lastFrameEnded(mv);
			if (mv != death_animation) {
				this.gotoAndStop(Actions.IDLE);
				this.setAttackBoxDelegate(this);
				removeEventListener(Event.ENTER_FRAME, setDamageDelegate, false);
				this.idle = true;
			}
		}
		
		/** IAttackTrigger **/
		
		public function attackBoxTriggeredByPlayer(box:AttackBox) {
			if (!this.idle) {
				return; // We are not idle, e.g. intro or hitanimation
			}
			this.idle = false;
			var direction:Directions = new Directions();
			if (box == AttackTriggerLeft) {
				direction = Directions.LEFT;
			} else if (box == AttackTriggerRight) {
				direction = Directions.RIGHT;
			} else if (box == AttackTriggerUp) {
				direction = Directions.UP;
			} else if (box == AttackTriggerDown) {
				direction = Directions.DOWN;
			}
			this.gotoAndStop(Actions.HIT + Strings.ANIMATION_SEPERATOR + direction);
			this.setLastFrameTriggerDelegate(this);
			addEventListener(Event.ENTER_FRAME, setDamageDelegate, false, 0, true);
		}
		
		public function setDamageDelegate(e:Event) {
			this.setDamageBoxDelegate(this);
		}
	}

}
