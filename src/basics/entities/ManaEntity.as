package basics.entities {
	
	import spells.Spell;
	
	/**
	 * ...
	 * @author Dominik
	 */
	public class ManaEntity extends HealthEntity {
		public var maxMana:Number = 100;
		public var _currentMana:Number;
			
		public function ManaEntity() {
			super();
		
		}
		
		override public function init() {
			super.init();
			_currentMana = maxMana;
		}
		
		public function get ManaPercentage():Number {
			return 1.0 / this.maxMana * _currentMana;
		}
		
		public function useMana(mana:Number) {
			this.currentMana = _currentMana - mana;
		}
		
		public function regenerate(amount:Number) {
			this.currentMana = _currentMana + amount;
		}
		
		private function set currentMana(value:Number):void {
			if (value > this.maxMana) {
				value = this.maxMana;
			} else if (value <= 0) {
				value = 0;
			}
			_currentMana = value;
		}
	
	}

}