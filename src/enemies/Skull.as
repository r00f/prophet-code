﻿package enemies {
	
	import basics.BloodSplatter;
	import basics.hitboxes.BodyBox;
	import basics.hitboxes.AttackBox;
	import basics.hitboxes.DamageBox;
	import flash.display.MovieClip;
	import flash.events.Event;
	import utilities.*;
	import utilities.interfaces.IAttackTrigger;
	import utilities.interfaces.IDamageTrigger;
	import utilities.interfaces.ILastFrameTrigger;
	
	public class Skull extends Enemy implements IDamageTrigger {
		
		public static var blabla = "String";
		
		private var HorizontalLimit = 100;
		private var VerticalLimit = 50;
		
		private var rootRef:Root;
		private var speed:Number;
		private var xspeed:Number;
		private var yspeed:Number;
		private var direction:String;
		private var damageAmount:Number;
		public var damage_box:DamageBox;
		
		public var AttackTriggerLeft:AttackBox;
		public var AttackTriggerRight:AttackBox;
		
		//private var playerHit:Boolean = false;
		
		private var FixPositionX;
		private var FixPositionY;
		
		private var Wait;
		
		public function Skull() {
			super();
			yOffset = 50;
			yRange = 50;
			this.rootRef = this.root as Root;
			Wait = Random.random(25);
			FixPositionX = int(this.x);
			FixPositionY = int(this.y);
			this.speed = Random.random(6) + 2;
			this.damageAmount = 5;
			xspeed = this.speed;
			yspeed = 0;
			this.direction = Directions.RIGHT;
			addEventListener(Event.ENTER_FRAME, wait, false, 0, true);
			addEventListener(Event.ENTER_FRAME, checkIfDead, false, 0, true);
			addEventListener(Event.ENTER_FRAME, setDamageDelegate, false, 0, true);
		}
		
		public function damageAppliedToPlayer(box:DamageBox, player:Player) {
			//if (!this.playerHit) {
				player.applyDamage(this.damageAmount);
				//playerHit = true;
		
		}
		
		public function damageAppliedToEnemy(box:DamageBox, enemy:Enemy) {
			if (enemy is Baby) {
				enemy.applyDamage(1);
			} 
		}
		
		public function wait(e:Event) {
			if (Wait > 0) {
				Wait--;
			} else {
				removeEventListener(Event.ENTER_FRAME, wait, false)
				addEventListener(Event.ENTER_FRAME, walk, false, 0, true);
			}
		}
		
		public function checkIfDead(e:Event) {
			if (this.HealthPercentage == 0) {
				xspeed = 0;
				yspeed = 0;
				this.gotoAndStop(Actions.DEATH + "_" + this.direction);
				super.death_animation.delegate = this;
				removeEventListener(Event.ENTER_FRAME, walk, false);
				removeEventListener(Event.ENTER_FRAME, wait, false);
			}
		}
		
		public function setDamageDelegate(e:Event) {
			if (damage_box != null)
			damage_box.delegate = this;
			removeEventListener(Event.ENTER_FRAME, setDamageDelegate, false);
		}
		
		public function walk(e:Event):void {
			if (this.x < (FixPositionX - HorizontalLimit)) {
				xspeed = this.speed;
				this.direction = Directions.RIGHT;
			}
			if (this.x > (FixPositionX + HorizontalLimit)) {
				
				xspeed = -this.speed;
				this.direction = Directions.LEFT;
			}
			
			if (this.y > (FixPositionY + VerticalLimit)) {
				yspeed = -this.speed;
				this.direction = Directions.UP;
			}
			
			if (this.y < (FixPositionY - VerticalLimit)) {
				yspeed = this.speed;
				this.direction = Directions.DOWN;
			}
			
			if ((xspeed != 0 || yspeed != 0)) {
				if (this.rootRef.collidesWithEnvironment(this.x + xspeed, this.y + yspeed) || this.rootRef.collidesWithEnvironment(this.x + xspeed + this.width * 2 / 3, this.y + yspeed)) {
					xspeed = -xspeed;
					this.direction = Directions.oppositeOf(this.direction);
				}
				this.x += xspeed;
				this.y += yspeed;
			}
			
			this.gotoAndStop("skull_walk_" + this.direction);
		
		}
	}
}