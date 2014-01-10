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
		
		private var started:Boolean = false;
		
		public function Bauble() 
		{
			super();
		}
		
		override public function init() 
		{
			super.init();
			addEventListener(Event.ENTER_FRAME, wait, false, 0, false);
		}
		
		override public function pause(e:Event) 
		{
			super.pause(e);
			removeEventListener(Event.ENTER_FRAME, regenerate, false)
			removeEventListener(Event.ENTER_FRAME, wait, false);
		}
		
		override public function resume(e:Event) 
		{
			super.resume(e);
			if (this.started) {
				addEventListener(Event.ENTER_FRAME, regenerate, false, 0, false);
			} else {				
				addEventListener(Event.ENTER_FRAME, wait, false, 0, false);
			}
		}
		
		public function wait(e:Event) {
			if (this.hitTestObject(rootRef.player.feet_hit)) {
				addEventListener(Event.ENTER_FRAME, regenerate, false, 0, false);
				this.setRegeneration()
				removeEventListener(Event.ENTER_FRAME, wait, false);
				this.started = true;
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
				removeEventListener(Event.ENTER_FRAME, regenerate, false)
			}
		}
		
		protected function setRegeneration() {
			
		}
		
		protected function resetRegeneration() {
			
		}
		
	}

}