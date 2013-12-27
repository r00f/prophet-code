package {
	import flash.display.MovieClip;
	import utilities.interfaces.ILastFrameTrigger;
	import utilities.LastFrameTrigger;
	import flash.events.Event;
	import utilities.Actions;
	
	/**
	 * Implements health with heal and applyDamage functions.
	 * - MaxHealth is only seen by subclasses
	 * - current Health is not seen by any other classes
	 * - HealthPercentage, heal, applyDamage are public.
	 * @author Gabriel
	 */
	public class HealthEntity extends Entity implements ILastFrameTrigger {
		protected var maxHealth:Number = 100;
		private var _currentHealth:Number;
		public var death_animation:LastFrameTrigger;
		public var despawnTime:Number = 20; // Seconds
		private var deadTime:Date;
		
		public function HealthEntity() {
			super();
			_currentHealth = maxHealth;
		}
		
		public function deathTrigger(e:Event) {
			if (this.deadTime != null) {
				var t:Date = new Date();
				if (t.valueOf() - this.deadTime.valueOf() > this.despawnTime * 1000) {
					removeEventListener(Event.EXIT_FRAME, deathTrigger, false);
					this.parent.removeChild(this);
				}
				if (this.death_animation.currentLabel != Actions.IDLE) {
					this.death_animation.gotoAndPlay(Actions.IDLE);
				}
			}
		}
		
		public function lastFrameEnded(mv:MovieClip) {
			if (mv == death_animation && this.deadTime == null) {
				addEventListener(Event.EXIT_FRAME, deathTrigger, false, 0, true);
				this.deadTime = new Date();
			}
		}
		
		/**
		 * Get the percentage of the current health between 0 and 1.
		 */
		public function get HealthPercentage():Number {
			return 1.0 / this.maxHealth * _currentHealth;
		}
		
		/**
		 * Apply Damage reducing current health.  If currentHealth would be smaller than 0, currentHealth is 0.
		 * @param	damage the amount of health subtracted.
		 */
		public function applyDamage(damage:Number) {
			this.currentHealth = _currentHealth - damage;
		}
		
		/**
		 * Heal the entity, increasing its current health. If currentHealth would be greater than maxHealh, currentHealth is maxHealth.
		 * @param	amount the amount the current health is increased.
		 */
		public function heal(amount:Number) {
			this.currentHealth = _currentHealth + amount;
		}
		
		private function set currentHealth(value:Number):void {
			if (value > this.maxHealth) {
				value = this.maxHealth;
			} else if (value < 0) {
				value = 0;
			}
			_currentHealth = value;
		}

	
	}

}