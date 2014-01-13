package collectibles {
	import basics.entities.Entity;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Dominik Würsch
	 */
	public class HealthBauble extends Bauble {
		
		public function HealthBauble() {
			super();
		}
		
		override public function init() 
		{
			super.init();
			this.regenAmount = 2;
		}
		
		override protected function setRegeneration() 
		{
			super.setRegeneration();
			this.rootRef.player.healthRegen = this.regenAmount;
		}
		
		override protected function resetRegeneration() 
		{
			super.resetRegeneration();
			this.rootRef.player.healthRegen = 0;
		}
	
	}

}