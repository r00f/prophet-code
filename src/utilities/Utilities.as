package utilities {
	import basics.hitboxes.AttackBox;
	import flash.display.MovieClip;
	import utilities.interfaces.IAttackTrigger;
	import utilities.interfaces.ILastFrameTrigger;
	
	/**
	 * Some utility Functions bundled into a class.
	 * @author Gabriel
	 */
	public class Utilities {
		
		public function Utilities() {
		
		}
		
		public static function setAttackBoxDelegate(box:AttackBox, clip:IAttackTrigger) {
			if (box != null && box.delegate != clip) {
				box.delegate = clip;
			}
		}
		
		public static function setLastFrameTriggerDelegate(box:LastFrameTrigger, clip:ILastFrameTrigger) {
			if (box != null && box.delegate != clip) {
				box.delegate = clip;
			}
		}
	}

}