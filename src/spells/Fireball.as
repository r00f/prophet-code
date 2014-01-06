package spells {
	import basics.entities.ManaEntity;
	import basics.hitboxes.DamageBox;
	import enemies.base.Enemy;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import utilities.Directions;
	import utilities.interfaces.ILastFrameTrigger;
	import utilities.LastFrameTrigger;
	
	/**
	 * ...
	 * @author Gabriel
	 */
	public class Fireball extends Spell implements ILastFrameTrigger {
		private var spellDamage:Number;
		private var moveDistance:Number = 7.6; // in pseudo-meters, 1 pixel = 1cm, must be > 0
		
		private var enemiesHit:Object;
		private var direction:Directions = Directions.LEFT;
		private var speed:Number;
		
		private var start:Point;
		
		private var maxDistanceSquared:int;
		private var maxDistancePixel:int;
		
		private var entity:ManaEntity;
		
		public var explosion:LastFrameTrigger;
		public var fireballManaCost = 25;
		
		public function Fireball(direction:Directions, pos:Point, entity:ManaEntity,  damage:Number = 50, speed:Number = 3.5, manacost:Number = 25) {
			super();
			entity.useMana(fireballManaCost);
			this.point = pos;
			this.direction = direction;
			this.speed = speed * 100 / 24;
			this.spellDamage = damage;
			this.gotoAndStop(this.direction);
		}
		
		override public function init() {
			super.init();
			if (this.rootRef != null) {
				this.enemiesHit = new Object();
				
				this.start = this.point;
				
				maxDistancePixel = this.moveDistance * 100;
				maxDistanceSquared = Math.pow(maxDistancePixel, 2);
				addEventListener(Event.ENTER_FRAME, move, false, 0, true);
			}
		}
		
		override public function pause(e:Event) {
			super.pause(e);
			removeEventListener(Event.ENTER_FRAME, move, false);
		}
		
		override public function resume(e:Event) {
			super.resume(e);
			this.gotoAndStop(this.currentFrame);
			addEventListener(Event.ENTER_FRAME, move, false, 0, true);
		}
		
		public function move(e:Event) {
			var next:Point = this.point;
			if (this.direction.isLeft) {
				next.x -= this.speed;
			} else if (this.direction.isRight) {
				next.x += this.speed;
			}
			if (this.direction.isUp) {
				next.y -= this.speed;
			} else if (this.direction.isDown) {
				next.y += this.speed;
			}
			if (this.rootRef.collidesWithEnvironment(next) || travelledTooFar(next)) {
				this.gotoAndPlay("explode");
				this.explosion.delegate = this;
			} else {
				this.point = next;
			}
		
		}
		
		public function travelledTooFar(next:Point) {
			var diff:Point = new Point(Math.abs(next.x - this.start.x), Math.abs(next.y - this.start.y));
			var dist_squared:Point = new Point(Math.pow(diff.x, 2), Math.pow(diff.y, 2));
			if (diff.x > this.maxDistancePixel || diff.y > this.maxDistancePixel || dist_squared.x + dist_squared.y > maxDistanceSquared) {
				return true;
			}
			return false;
		}
		
		public function lastFrameEnded(mv:MovieClip) {
			removeEventListener(Event.ENTER_FRAME, move, false);
			if (this.parent == null) {
				return;
			}
			this.parent.removeChild(this);
		}
		override public function damageAppliedToEnemy(box:DamageBox, enemy:Enemy):void {
			super.damageAppliedToEnemy(box, enemy);
			if (!enemiesHit[enemy.name]) {
				enemy.applyDamage(spellDamage);
				enemiesHit[enemy.name] = true;
			}
		}
	
	}

}