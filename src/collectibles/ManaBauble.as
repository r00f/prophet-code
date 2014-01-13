package collectibles {
	import basics.entities.Entity;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Dominik Würsch
	 */
	public class ManaBauble extends Bauble {
		

		
		public function ManaBauble() {
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
			this.rootRef.player.manaRegen = this.regenAmount;
		}
		
		override protected function resetRegeneration() 
		{
			super.resetRegeneration();
			this.rootRef.player.manaRegen = 0;
		}
	
	}

}