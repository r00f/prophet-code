package basics.entities {
	import basics.Blood.BloodConfig;
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.Actions;
	import utilities.interfaces.ILastFrameTrigger;
	import utilities.LastFrameTrigger;
	/**
	 * Implements health with heal and applyDamage functions.
	 * - MaxHealth is only seen by subclasses
	 * - current Health is not seen by any other classes
	 * - HealthPercentage, heal, applyDamage are public.
	 * @author Gabriel
	 */
	public class HealthEntity extends Entity implements ILastFrameTrigger {
		
		[Inspectable(defaultValue = 100, name = "Maximum Health", type = "Number", variable = "maxHealth")]
		public var maxHealth:Number;
		
		private var _currentHealth:Number;
		public var death_animation:LastFrameTrigger;
		
		[Inspectable(defaultValue=20, name="Despawn Time [s]", type="Number", variable="despawnTime")]
		public var despawnTime:Number; // Seconds
		private var deadTime:Date;
		
		
		public var blood:BloodConfig;
		
		public function HealthEntity() {
			super();
			this.blood = new BloodConfig();
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
			this.addChild(blood.Splatter);
		}
		
		/**
		 * Heal the entity, increasing its current health. If currentHealth would be greater than maxHealh, currentHealth is maxHealth.
		 * @param	amount the amount the current health is increased.
		 */
		public function heal(amount:Number) {
			this.currentHealth = _currentHealth + amount;
		}
		
		protected function die():void {
			
		}
		
		private function set currentHealth(value:Number):void {
			if (value > this.maxHealth) {
				value = this.maxHealth;
			} else if (value <= 0) {
				value = 0;
				this.die();
			}
			_currentHealth = value;
		}

	
	}

}