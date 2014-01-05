package utilities.interfaces {
	import flash.events.Event;
	import flash.utils.Timer;
	import Date;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class PausingTimer extends Timer {
		private var root:Root;		
		
		private var startedAt:Date;
		private var pausedAt:Date;
		
		public function PausingTimer(delay:Number, root:Root, repeatCount:int = 0) {
			super(delay, repeatCount);
			this.root = root;
			root.addEventListener(Root.EVENT_PAUSED, pause, false, 0, true);
			root.addEventListener(Root.EVENT_RESUMED, resume, false, 0, true);
		}
		
		override public function start():void {
			super.start();
			this.startedAt = new Date();
			this.pausedAt = null;
		}
		
		public function pause(e:Event) {
			if (this.running && this.pausedAt == null) {
				super.stop();
				this.pausedAt = new Date();
			}
		}
		
		public function resume(e:Event) {
			if (this.pausedAt != null) {
				var nextDelay:Number = this.delay - (this.pausedAt.valueOf() - this.startedAt.valueOf());
				this.delay = nextDelay <= 0 ? 0 : nextDelay;
				this.start();
			}
		}
	
	}

}