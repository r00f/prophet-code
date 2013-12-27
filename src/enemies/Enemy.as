package enemies {
	import basics.hitboxes.BodyBox;
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.Utilities;
	import utilities.KeyCodes;
	
	/**
	 * Enemy Superclass which implements despawn-time for all enemies with a required animation named death_animation
	 * which has a label called Actions.IDLE which will be played until the enemy is removed from stage.
	 * Implements ILastFrameTrigger to remove the enemy in the last frame of the death_animation.
	 * @author Gabriel
	 */
	public class Enemy extends HealthEntity {
		
		public var body_hit:BodyBox;
		
		public function Enemy() {
			super();
			addEventListener(Event.ENTER_FRAME, death, false, 0, true);
		}
		
		public function death(e:Event):void {
			if (root != null) {
				if ((this.root as Root).keyPresses.isDown(KeyCodes.J)) {
					this.applyDamage(100000);
				}
			}
		}
	
	}

}