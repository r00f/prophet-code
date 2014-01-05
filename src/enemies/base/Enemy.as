package enemies.base {
	import basics.entities.HealthEntity;
	import basics.hitboxes.BodyBox;
	import basics.hitboxes.DamageBox;
	import flash.events.Event;
	import utilities.interfaces.IDamageTrigger;
	import utilities.KeyCodes;
	
	/**
	 * Enemy Superclass which implements despawn-time for all enemies with a required animation named death_animation
	 * which has a label called Actions.IDLE which will be played until the enemy is removed from stage.
	 * Implements ILastFrameTrigger to remove the enemy in the last frame of the death_animation.
	 * @author Gabriel
	 */
	public class Enemy extends HealthEntity implements IDamageTrigger {
		
		public var body_hit:BodyBox;
		
		public function Enemy() {
			super();
			addEventListener(Event.ENTER_FRAME, death, false, 0, true);
		}
		
		override public function pause(e:Event) {
			// We do not pass it up to HealthEntity, the containerclip which the enemy-class is on does not need to be paused, each frame contains just an animation.
		}
		
		override public function resume(e:Event) {
			// We do not pass it up to HealthEntity, the containerclip which the enemy-class is on does not need to be paused, each frame contains just an animation.
		}
		
		public function death(e:Event):void {
			if (root != null) {
				if ((this.root as Root).keyPresses.isDown(KeyCodes.J)) {
					this.applyDamage(100000);
				}
			}
		}
		
		public function damageAppliedToPlayer(box:DamageBox, player:Player):void {
		}
		
		public function damageAppliedToEnemy(box:DamageBox, enemy:Enemy):void {
		}
		
		public function damagePlayerHitbox(box:DamageBox):String {
			return Player.HITBOX_BODY;
		}
	
	}

}