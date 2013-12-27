package enemies {
	
	import basics.hitboxes.BodyBox;
	import basics.hitboxes.AttackBox;
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.Directions;
	import utilities.Actions;
	import utilities.interfaces.ILastFrameTrigger;
	import utilities.interfaces.IDamageTrigger;
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
		
		public var intro_animation:LastFrameTrigger;
		public var hit_left_animation:LastFrameTrigger;
		public var hit_right_animation:LastFrameTrigger;
		public var hit_up_animation:LastFrameTrigger;
		public var hit_down_animation:LastFrameTrigger;
			
		private var rootRef:Root;
		
		
		public function Hand() {
			super();
			this.rootRef = this.root as Root;
			addEventListener(Event.ENTER_FRAME, setDelegateIfNotSet, false, 0, true);	
			this.gotoAndStop(Actions.INTRO);
			this.intro_animation.delegate = this;
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
		
		public function attackBoxTriggeredByPlayer(box:AttackBox) {
			var direction:String;
			if (box == AttackTriggerLeft) {
				direction = Directions.LEFT;
			} else if  (box == AttackTriggerRight) {
				direction = Directions.RIGHT;
			} else if  (box == AttackTriggerUp) {
				direction = Directions.UP;				
			} else if  (box == AttackTriggerDown) {
				direction = Directions.DOWN;				
			}
			this.gotoAndStop(Actions.HIT+"_" + direction);
		}
	}

}
