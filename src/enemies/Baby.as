package enemies {
	
	import basics.hitboxes.BodyBox;
	import basics.hitboxes.AttackBox;
	import basics.hitboxes.DamageBox;
	import basics.Light;
	import enemies.base.Enemy;
	import enemies.base.Mover;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import utilities.*;
	import utilities.interfaces.IAttackTrigger;
	import utilities.interfaces.ILastFrameTrigger;
	import utilities.interfaces.IDamageTrigger;
	
	/**
	 * Controls the baby animation.
	 * Implements IAttackTrigger to let the attackbox trigger the attack into the correct direction.
	 */
	public class Baby extends Mover implements IAttackTrigger {
		private var nextAction:String = "idle";
		
		private var damageAmount:int;
		public var AttackTriggerLeft:AttackBox;
		public var AttackTriggerRight:AttackBox;
		private var playerHit:Boolean = false;
		
		private var Wait;
		
		private var attacking:Boolean = false;
		
		public function Baby() {
			super();
		}
		
		override public function init() {
			super.init();
			Wait = Random.random(25);
			this.blood.xRange = 100;
			this.speed.x = Random.random(6) + 2;
			this.speed.y = 0;
			this.damageAmount = 1 / this.speed.x * 100;
			this.direction = Directions.RIGHT;
			addEventListener(Event.ENTER_FRAME, wait, false, 0, true);
			this.despawnTime = 1;
		}
		
		override public function pause(e:Event) {
			removeEventListener(Event.ENTER_FRAME, wait, false);
			removeEventListener(Event.ENTER_FRAME, walk, false);
		}
		
		override public function resume(e:Event) {
			if (!this.attacking) {
				super.resume(e);
			} else {
				addEventListener(Event.ENTER_FRAME, setDamageDelegate, false, 0, true);
			}
		}
		
		override public function damageAppliedToPlayer(box:DamageBox, player:Player):void {
			if (!this.playerHit) {
				player.applyDamage(this.damageAmount);
				playerHit = true;
			}
		}
		
		override public function damageAppliedToEnemy(box:DamageBox, enemy:Enemy):void {
			if (enemy is Baby) {
				enemy.applyDamage(1);
			} else if (enemy is Skull) {
				enemy.heal(10);
			}
		}
		
		override protected function die():void {
			this.attackBoxTriggeredByPlayer(null);
			removeEventListener(Event.ENTER_FRAME, walk, false);
		}
		
		override public function walk(e:Event):void {
			super.walk(e);
			this.setAttackBoxDelegate(this);
			this.gotoAndStop("baby" + Strings.ANIMATION_SEPERATOR + Actions.WALK + Strings.ANIMATION_SEPERATOR + this.direction);
		}
		
		public function setDamageDelegate(e:Event) {
			this.setDamageBoxDelegate(this);
		}
		
		public function attackBoxTriggeredByPlayer(box:AttackBox) {
			this.speed = new Point(0, 0);
			this.gotoAndStop(Actions.DEATH + Strings.ANIMATION_SEPERATOR + this.direction);
			this.death_animation.delegate = this;
			this.attacking = true;
			
			addEventListener(Event.ENTER_FRAME, setDamageDelegate, false, 0, true);
			removeEventListener(Event.ENTER_FRAME, walk, false);
			removeEventListener(Event.ENTER_FRAME, wait, false);
		}
	}
}

