﻿package {
	
	import basics.entities.HealthEntity;
	import basics.entities.ManaEntity;
	import basics.hitboxes.BodyBox;
	import basics.Light;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import spells.Fireball;
	import utilities.*;
	
	/**
	 * The player class controls the player movieclip. The Player is controlled by the keyboard.
	 */
	public class Player extends ManaEntity {
		
		public static var HITBOX_BODY:String = "body_hit";
		public static var HITBOX_FEET:String = "feet_hit";
		
		[Inspectable(defaultValue=8,name="Base Speed",type="Number",variable="speed")]
		public var speed:Number = 8;
		
		public var feet_hit:BodyBox;
		public var body_hit:BodyBox;
		private var direction:Directions;
		
		[Inspectable(defaultValue=30,name="Fireball Base Damage",type="Number",variable="fireballDamage")]
		public var fireballDamage:Number = 30;
		
		[Inspectable(defaultValue=3.5,name="Fireball Speed [m/s]",type="Number",variable="fireballSpeed")]
		public var fireballSpeed:Number = 3.5;
		
		public var manaRegen:Number = 0.1;
		public var healthRegen:Number = 0.1;
		
		public var offsetx:Number;
		public var offsety:Number;
		
		public function Player() {
			super();
		}
		
		override public function cleanup(e:Event) {
			super.cleanup(e);
			
			removeEventListener(Event.ENTER_FRAME, loop, false);
			removeEventListener(Event.ENTER_FRAME, checkIfDead, false);
		}
		
		override public function pause(e:Event) {
			super.pause(e);
			//Uncomment to pause player too
			removeEventListener(Event.ENTER_FRAME, loop, false);
			removeEventListener(Event.ENTER_FRAME, checkIfDead, false);
		}
		
		override public function resume(e:Event) {
			super.resume(e);
			// Uncomment to resume player too (if pausing is uncommented)
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			addEventListener(Event.ENTER_FRAME, checkIfDead, false, 0, true);
		}
		
		override public function init() {
			super.init();
			this.blood.yRange = 180;
			this.regen.yRange = 100;
			this.regen.yOffset = -50;
			this.regen.xRange = 50;
			this.rootRef.player = this;
			this.offsetx = this.x + 50;
			this.offsety = this.y + 80;
			this.direction = Directions.DOWN;
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			addEventListener(Event.ENTER_FRAME, checkIfDead, false, 0, true);
		}
		
		public function get light():Light {
			var ls = this.Lights;
			if (ls.length == 0) {
				return null;
			} else {
				return ls[0];
			}
		}
		
		private function updateDirection():void {
			if (this.rootRef != null) {
				if (this.rootRef.movementPressed) {
					direction.current = Directions._none;
					if (this.rootRef.upPressed) {
						direction.current += Directions._up;
					} else if (this.rootRef.downPressed) {
						direction.current += Directions._down;
					}
					
					if (this.rootRef.leftPressed) {
						direction.current += Directions._left;
					} else if (this.rootRef.rightPressed) {
						direction.current += Directions._right;
					}
				}
			}
		}
		
		public function get Action():String {
			if (this.rootRef.movementPressed) {
				return Actions.WALK;
			} else if (this.rootRef.attackPressed) {
				return Actions.HIT;
			} else {
				return Actions.IDLE;
			}
		}
		
		public function checkIfDead(e:Event) {
			
			if (this.HealthPercentage == 0) {
				this.gotoAndStop(Actions.DEATH + Strings.ANIMATION_SEPERATOR + this.direction);
				super.death_animation.delegate = this;
				this.blood.yRange = 100;
				removeEventListener(Event.ENTER_FRAME, loop, false);
				removeEventListener(Event.ENTER_FRAME, checkIfDead, false);
			}
		}
		private var cooldown = 20;
		
		private function shootFireball() {
			var fireballOffset:Point = new Point(0, -60);
			if (_currentMana > 25) {
				if (this.direction.isLeft) {
					fireballOffset.x = -80;
				} else if (this.direction.isRight) {
					fireballOffset.x = 80;
				}
				
				if (this.direction.isUp) {
					fireballOffset.y = -80;
				} else if (this.direction.isDown) {
					fireballOffset.y = 0;
				}
				
				this.rootRef.addEntity(new Fireball(this.direction.copy, this.point.add(fireballOffset), this, fireballDamage, fireballSpeed));
			}
		}
		
		public function loop(e:Event):void {
			if (manaRegen != 0) {
				super.regenerate(manaRegen);
			}
			if (healthRegen != 0 && this.HealthPercentage != 0) {
				super.heal(healthRegen);
			}
			this.updateDirection();
			var change:Point = new Point();
			if (this.rootRef.keyPresses.isDown(KeyCodes.Control) && cooldown <= 0) {
				this.shootFireball();
				cooldown = 20;
			}
			cooldown--;
			if (this.rootRef.movementPressed) {
				if (this.direction.isLeft) {
					change.x -= speed;
				} else if (this.direction.isRight) {
					change.x += speed;
				}
				
				if (this.direction.isUp) {
					change.y -= speed;
				} else if (this.direction.isDown) {
					change.y += speed;
				}
			}
			
			var next:Point = this.point.add(change);
			if (!this.rootRef.collidesWithEnvironment(next)) {
				this.point = next;
			} else if (!this.rootRef.collidesWithEnvironment(new Point(this.x, next.y))) {
				this.point = new Point(this.x, next.y);
			} else if (!this.rootRef.collidesWithEnvironment(new Point(next.x, this.y))) {
				this.point = new Point(next.x, this.y);
			}
			this.gotoAndPlay(this.Action + Strings.ANIMATION_SEPERATOR + this.direction);
			if (this.light != null) {
				this.light.scaleX = this.HealthPercentage + 0.4;
				this.light.scaleY = this.HealthPercentage + 0.4;
			}
		}
	}

}

