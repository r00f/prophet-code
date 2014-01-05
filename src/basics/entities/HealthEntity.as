package basics.entities {
	import basics.Blood.BloodConfig;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import utilities.Actions;
	import utilities.interfaces.ILastFrameTrigger;
	import utilities.interfaces.PausingTimer;
	import utilities.LastFrameTrigger;
	
	/**
	 * Implements health with heal and applyDamage functions.
	 * - MaxHealth is only seen by subclasses
	 * - current Health is not seen by any other classes
	 * - HealthPercentage, heal, applyDamage are public.
	 * @author Gabriel
	 */
	public class HealthEntity extends Entity implements ILastFrameTrigger {
		
		[Inspectable(defaultValue=100,name="Maximum Health",type="Number",variable="maxHealth")]
		public var maxHealth:Number = 100;
		
		private var _currentHealth:Number;
		public var death_animation:LastFrameTrigger;
		
		[Inspectable(defaultValue=20,name="Despawn Time [s]",type="Number",variable="despawnTime")]
		public var despawnTime:Number = 20; // Seconds
		
		private var deathTimer:Timer;
		
		public var blood:BloodConfig;
		
		protected var dead:Boolean = false;
		
		public function HealthEntity() {
			super();
		}
	
		override public function init() {
			super.init();
			this.deathTimer = new PausingTimer(despawnTime * 1000, this.rootRef);
			this.deathTimer.addEventListener(TimerEvent.TIMER, deathTrigger, false, 0, true);
			this.blood = new BloodConfig();
			_currentHealth = maxHealth;
		}
		
		public function deathTrigger(e:Event) {
			this.parent.removeChild(this);
			this.deathTimer.removeEventListener(TimerEvent.TIMER, deathTrigger, false);
		}
		
		public function lastFrameEnded(mv:MovieClip) {
			if (mv == death_animation) {
				if (!this.deathTimer.running) {
					this.deathTimer.start();
				}
				if (this.deathTimer.running) {
					this.death_animation.gotoAndPlay(Actions.IDLE);
				}
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
		
		/**
		 * Called when the health is reduced to 0
		 */
		protected function die():void {
			this.dead = true;
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