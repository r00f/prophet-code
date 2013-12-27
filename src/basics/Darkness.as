package basics {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Darkness extends MovieClip {
		public function Darkness() {
			super();
		}
		
		public function addLight(light:Light) {
			this.addChild(light);
		}
	
	}

}