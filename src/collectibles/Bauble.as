package collectibles 
{
	import basics.entities.Entity;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Bauble extends Entity 
	{
		public var regenAmount:Number = 2;
		protected var waitFrames:int = 10;
		
		public function Bauble() 
		{
			super();
		}
		
		override public function init() 
		{
			super.init();
			addEventListener(Event.ENTER_FRAME, wait, false, 0, false);
		}
		
		public function wait(e:Event) {
			if (this.hitTestObject(rootRef.player.feet_hit)) {
				addEventListener(Event.ENTER_FRAME, regenerate, false, 0, false);
				this.setRegeneration()
			}
		}
		
		public function regenerate(e:Event) {
			if (this.waitFrames > 0) {
				this.scaleX -= 0.1;
				this.scaleY -= 0.1;
				this.waitFrames--;
			} else if (parent != null) {
				this.resetRegeneration()
				parent.removeChild(this);
				removeEventListener(Event.ENTER_FRAME, loop2, false)
			}
		}
		
		protected function setRegeneration() {
			
		}
		
		protected function resetRegeneration() {
			
		}
		
	}

}