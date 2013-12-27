package utilities.interfaces {
	import flash.display.MovieClip;
	
	/**
	 * Interface to use with anymovieclips of the baseclass LastFrameTrigger. Will be called when the last frame ends.
	 * @author Gabriel
	 */
	public interface ILastFrameTrigger {
		function lastFrameEnded(mv:MovieClip);
	}

}