﻿package basics.hitboxes {
	
	import enemies.base.Enemy;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.interfaces.IDamageTrigger;
	
	public class DamageBox extends Hitbox {
		
		public var delegate:IDamageTrigger;
		
		public function DamageBox() {
			super();
			addEventListener(Event.ENTER_FRAME, checkForEnemies, false, 0, true);
			addEventListener(Event.ENTER_FRAME, checkForPlayer, false, 0, true);
		}
		
		public function checkForPlayer(e:Event) {
			if (this.delegate != null && this.rootRef != null) {
				if (this.hitTestObject(super.rootRef.player[delegate.damagePlayerHitbox(this)])) {
					this.delegate.damageAppliedToPlayer(this, super.rootRef.player);
				}
			}
		}
		
		public function checkForEnemies(e:Event) {
			if (this.delegate != null && this.rootRef != null) {
				var enemylist:Vector.<Enemy> = rootRef.Enemies;
				for (var i:int = 0; i < enemylist.length; i++) {
					var enemy:Enemy = enemylist[i];
					if (this.hitTestObject(enemy)) {
						this.delegate.damageAppliedToEnemy(this, enemy);
					}
				}
			}
		}
	
	}

}