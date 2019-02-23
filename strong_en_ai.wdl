//AI WDL

//Deals with infantry getting hit by trace and scan
function handleShoot()
{
	if(storeOpen == 1) { return; }	//if store is open, close function
	if(event_type == event_shoot)
	{ 
		if((gunType == 1) && (you.jackson != 1) && (you.mg42 != 1) && (you.safety != on))
		//if hit by a trace from player hand gun
		{
			my.health -= 25;	//reduce health
			shotsHit += 1;
			wait(1);
			ent_create(bloodsprite,target,duster);	//create blood 3x
			wait(1);
			ent_create(bloodsprite,target,duster);
			wait(1);
			ent_create(bloodsprite,target,duster);
			return;
		}
		if((gunType == 2) && (you.jackson != 1) && (you.mg42 != 1) && (you.safety != on))
		//if hit by a trace from player machine gun
		{
			my.health -= 20;	//reduce health
			shotsHit += 1;
			wait(1);
			ent_create(bloodsprite,target,duster);	//bloodsprite 3x
			wait(1);
			ent_create(bloodsprite,target,duster);
			wait(1);
			ent_create(bloodsprite,target,duster);
			return;
		}
		if((gunType == 3) && (you.jackson != 1) && (you.mg42 != 1) && (you.safety != on))
		//if hit by a trace from player sniper rifle
		{
			my.health = 0;	//kill
			shotsHit += 1;
			wait(1);
			ent_create(bloodsprite,target,duster);	//bloodsprite 3x
			wait(1);
			ent_create(bloodsprite,target,duster);
			wait(1);
			ent_create(bloodsprite,target,duster);
			return;
	
		}
		if((you.jackson == on) && (you.safety != on))
		//if hit by defensive sniper
		{
			my.health = 0;	//kill
			wait(1);
			ent_create(bloodsprite,target,duster);	//create blood sprite
			wait(1);
			ent_create(bloodsprite,target,duster);
			wait(1);
			ent_create(bloodsprite,target,duster);
			return;
		}
		if((you.mg42 == on) && (you.safety != on))
		//if hit by defensive machine gunner
		{
			my.health -= 1;	//reduce health
			wait(1);
			ent_create(bloodsprite,target,duster);	//create blood
			return;
		}		
	}
	if(event_type == event_scan) 
	{
		if(you == rpg)
		//if hit by rpg explosion
		{
			my.health -= 25;	//reduce health
			shotsHit += 1;
			return;
		}
		if(you == nuclear)
		//if hit by nuclear explosion
		{
			my.health = 0;		//kill
			shotsHit += 1;
			return;
		}
		if(you.safety == on)
		//if hit by the wall's scan
		{
			my.stopped = on;	//stop moving
			return;
		}
		if(you.mg42 == on)
		//if hit by the defensive machine gunner's scan, set pointer
		{
			mgTargSw = my;
		}
		if(you.jackson == on)
		//if hit by the defensive sniper's scan
		{
			snTargSw = my;	//set pointer
		}
		if(you == shd)
		{
			my.health = 0;	//if inside the sheild upond sheilds activation, kill it
			return;
		}
	}
}

function handleShootTank()	//deals with tank getting hit by scan/trace
{
	if(event_type == event_shoot) 
	{
		if((gunType == 1) && (you.jackson != 1) && (you.mg42 != 1) && (you.safety != on))
		//if hit by player hand gun
		{
			my.health -= 50;	//reduce health
			shotsHit += 1;
			wait(1);
			ent_create(bloodsprite,target,duster);	//blood sprite
			return;
		}
		if((gunType == 2) && (you.jackson != 1) && (you.mg42 != 1) && (you.safety != on))
		//if hit by machine gun
		{
			my.health -= 15;	//reduce health
			shotsHit += 1;
			wait(1);
			ent_create(bloodsprite,target,duster);	//bloodsprite
			return;
		}
		if((gunType == 3) && (you.jackson != 1) && (you.mg42 != 1) && (you.safety != on))
		//if hit by sniper rifle
		{
			my.health -= 50;	//reduce health
			shotsHit += 1;
			return;
		}
	}
	if(event_type == event_scan)
	{
		if(you == rpg)
		//if hit by rocket
		{
			my.health -= 250;  //reduce health
			shotsHit += 1;
			return;
		}
		if(you == nuclear)
		//if hit by nuclear explosion
		{
			my.health = 0;	//die
			shotsHit += 1;
			return;
		}
	}
}

/*The Swordsmen
These guys start from day 1.  They walk down the valley until they git hit by the wall's scan.  At that point, they animate
to attack the fort and send a small trace to the wall, doing it damage every 100 frames (about 2-3 seconds) until they are
dead at which point they flicker and then are removed.  They also scan ahead to go around any slower entity in front*/

action attackStickSword
{
	my.enType = 1;		//set enType to swordsman (used by fort/wall trace detection)
	my.enable_scan = on;	//set enable scan on
	my.enable_shoot = on;	//set enable shoot on
	my.event = handleShoot;	//set event handler
	my.health = 50;		//set health to 50
	my.pcounter = 0;	//set flicker counter to zero
	my.skill40 = 0;		//set attack rate to zero
	my.stopped = off;	//not stopped
	randomize();
	my.speed = random(5) + 2;		//set speed
	while((my.health > 0) && (my.stopped == off)  && (storeOpen != 1))
	//while alive and not hit by wall scan
	{
		my.skill22 = my.speed;
		my.skill23 = 0;
		my.skill24 = 0;
		move_mode = ignore_passable;		//ignore_passable
		ent_move(my.skill22,nullvector);	//move
		ent_cycle("walk",my.anim % 100);	//animate
		my.anim += my.skill22 * time; 		//synch animation with speed.
		my.skill30 = 180;
		my.skill31 = 180;
		my.skill32 = 100;
		result = scan_entity(my.x,my.skill30);	//scan for other units
		while((result != 0)  && (my.health > 0))	//if one is found. go around
		{
			if(my.y >= 0)	//if on 0 or negitive y axis, move towards center
			{
				my.skill22 = 0;		//set speed
				my.skill23 = -(random(5) + 2);
				my.skill24 = 0;
				move_mode = ignore_passable;		//ignore_passable
				ent_move(my.skill22,nullvector);	//move
				wait(1);
			}
			if(my.y < 0)	//if on positive y axis, go towards center
			{
				my.skill22 = 0;		//set speed
				my.skill23 = random(5) + 2;
				my.skill24 = 0;
				move_mode = ignore_passable;		//ignore_passable
				ent_move(my.skill22,nullvector);	//move
				wait(1);
			}
		}
		wait(1);
	}
	while((my.health > 0) && (my.stopped == on) && (storeOpen != 1))
	//while alive and stopped by wall, attack
	{			
		if(my.skill40 > 0)			//if skill40 is greater than 0
		{
			my.skill40 -= 1;		//reduce skill40
		}
		ent_cycle("attack",my.anim % 100);	//cycle attack animation
		my.anim += 10 * time;			//quick animation
		if(my.skill40 == 0)			//if skill40 = zero
		{
			my.myTargx = my.x + 120;	//set trace vector
			my.myTargy = my.y;
			my.myTargz = 8;
			trace_mode = ignore_me + ignore_models + activate_shoot;
			trace(my.x,my.myTargx);		//shoot trace
			my.skill40 = 100;		//set skill 40 to 100 (makes him attack every 100 frames)
		}
		wait(1);
	}
	if((my.health <= 0) && (storeOpen == 0))	//if dead
	{
		money += 100;		//increase money
		score += 100;		//increase score
		casualties += 1;	//increase casualties
		my.passable = on;	//turn passable on
		my.event = null;	//turn events off
		while(my.frame <= 22)
		//while my.frame is less than last frame
		{
			ent_cycle("death",my.anim);	//cycle death animation
			my.anim += 2 * time;
			wait(1);
		}
		while(my.pcounter <= 100)
		//while pcounter is less than 100
		{
			if(my.invisible == 0)		//flicker
			{
				my.invisible = on;
			}
			else
			{
				my.invisible = off;
			}
			my.pcounter += 1;
			wait(1);
		}
	}
	enemies -= 1;		//reduce number of alive swordsmen
	ent_remove(me);		//remove me
}

function handleCol()	//handles collision of tank/bazooka/bowman projectiles
{
	if(event_type == event_entity)
	//if projectile hits fort (it can only hit the fort or wall)
	{
		if((fort.invincible != on) && (you != bound))	//if fort's invincibility is not on
		{
			fort.health -= 5;	//damage fort
		}
		my.event = null;		//nullify event
		ent_remove(me);			//remove self
		return;
	}
}

action arrowFly	//projectile fired from bowman/bazooka/tank
{
	my.passable = on;		//passable
	my.scale_x *= 2;		//twice the size of original
	my.scale_y *= 2;		
	my.enable_entity = on;		//enable entity colision
	my.event = handleCol;		//handle collision
	vec_set(my.turnDir,fort.x);		
	vec_diff(my.turnDir,my.turnDir,my.x);	
	vec_to_angle(my.pan,my.turnDir);	//turn to target
	while(you) && (storeOpen != 1)			//while you exists (avoids missing ptrs)
	{
		my.skill22 = 10;	//fly 10 QPT
		my.skill23 = 0;
		my.skill24 = 0;
		move_mode = ignore_passable + ignore_models;
		ent_move(my.skill22,nullvector);	//move
		if(vec_dist(my.x,you.x) > 10)
		//if dist between projectile and shooter is greater than 10
		{
			my.passable = off;	//become impassable
		}
		wait(1);
	}
	ent_remove(me);	//if you is null, remove me
}

action attackStickArrow	//archer, shoots at forts, starts on Day 2
{
	my.enable_scan = on;		//enable scan detection
	my.enable_shoot = on;		//enable shoot detection
	my.event = handleShoot;		//handle scan/shoot events
	my.health = 50;			//health is 50
	my.skill40 = 0;
	randomize();
	my.speed = random(5) + 2;	//set random speed
	while((my.health > 0) && (vec_dist(my.x,fort.x) > 1300) && (storeOpen != 1))
	//while alive and 1300 q away from fort
	{
		my.skill22 = my.speed;
		my.skill23 = 0;
		my.skill24 = 0;
		move_mode = ignore_passable;	
		ent_move(my.skill22,nullvector);	//move
		ent_cycle("walk",my.anim % 100);	//animate
		my.anim += my.skill22 * time;		//synch animation w/ speed
		my.skill30 = 180;			//hemisphere scan
		my.skill31 = 180;
		my.skill32 = 100;
		result = scan_entity(my.x,my.skill30);		//scan for units
		while((result != 0)  && (my.health > 0))	//go around units
		{
			if(my.y >= 0)
			{
				my.skill22 = 0;		//set speed
				my.skill23 = -(random(5) + 2);
				my.skill24 = 0;
				move_mode = ignore_passable;		//ignore_passable
				ent_move(my.skill22,nullvector);	//move
				wait(1);
			}
			if(my.y < 0)
			{
				my.skill22 = 0;		//set speed
				my.skill23 = random(5) + 2;
				my.skill24 = 0;
				move_mode = ignore_passable;		//ignore_passable
				ent_move(my.skill22,nullvector);	//move
				wait(1);
			}
		}
		wait(1);
	}
	while((my.health > 0) && (vec_dist(my.x,fort.x) <= 1300) && (storeOpen != 1))
	//while alive and within range
	{
		if(my.skill40 > 0)
		{
			my.skill40 -= 1;
		}
		ent_cycle("attack",my.anim % 100);	//cycle attack animation
		my.anim += 2 * time;			//speed of animation
		vec_set(my.turnDir,fort.x);
		vec_diff(my.turnDir,my.turnDir,my.x);
		vec_to_angle(my.pan,my.turnDir);		//turn to target
		vec_for_vertex(my.fireSpot,my,616);		//set vector of vertex
		if(my.skill40 == 0)
		{
			ent_create(arrowMDL,my.fireSpot,arrowFly);	//shoot an arrow
			my.skill40 = 100;
		}
		wait(1);
	}
	//if entity is dead
	if((my.health <= 0) && (storeOpen != 1))
	{
		money += 100;		//increase money
		score += 100;		//increase score
		casualties += 1;	//increase casualties
		wait(1);
		my.passable = on;	//passable
		my.event = null;	//nullify events
		while(my.frame <= 18)
		//until animation is at its end
		{
			ent_cycle("death",my.anim);	//cycle death
			my.anim += 2 * time;
			wait(1);
		}
		while(my.pcounter <= 100)	//flickers until pcounter is 100
		{
			if(my.invisible == 0)
			{
			my.invisible = on;
			}
			else
			{
				my.invisible = off;
			}
			my.pcounter += 1;
			wait(1);
		}
	}
	ArrowEnemies -= 1;	//reduce number of alive archers
	ent_remove(me);		//remove self
}


action akFire	//sprite, gunfire burst
{
	my.overlay = on;	//overlay	
	my.oriented = on;	//real world angles
	my.facing = off;	//doesn't always face camera
	my.transparent = on;	//transparent
	my.alpha = 50;		//50%
	while((you != null) && (storeOpen != 1))
	{		
		my.pan = you.pan + 270;		//adjust angle to gunman
		if(snd_playing(you.kalishnikov) == 0) { break; }
		if(my.invisible == 0)	//flicker
		{
			my.invisible = on;
		}
		else
		{
			my.invisible = off;
		}
		wait(1);
	}
	ent_remove(me);		//remove if gun is not firing
	return;
}

action attackStickGun	//gunman who fires upon the fort, starts on Day 3
{
	var gunFireSpot[3];	//position of gun fire sprite
	my.enType = 2;		//gunman entity (used by fort/wall trace detection)
	my.enable_scan = on;	//enable scan detection
	my.enable_shoot = on;	//enable shoot detection
	my.event = handleShoot;	//handle scan and shoot
	my.health = 75;		//set health
	my.pcounter = 0;	//set flicker counter
	my.skill40 = 0;		//set attack rate
	randomize();
	my.speed = random(5) + 2;	//set random speed
	while((my.health > 0) && (vec_dist(my.x,fort.x) > 1300) && (storeOpen != 1))
	//while alive and over 1300 q away from fort
	{
		my.skill22 = my.speed;
		my.skill23 = 0;
		my.skill24 = 0;
		move_mode = ignore_passable;		//set move mode
		ent_move(my.skill22,nullvector);	//move
		ent_cycle("walk",my.anim % 100);	//animate walking
		my.anim += my.skill22 * time; 		//synch animation with speed.
		my.skill30 = 180;			//hemisphere scan
		my.skill31 = 180;
		my.skill32 = 100;
		result = scan_entity(my.x,my.skill30);		//scan for units
		while((result != 0)  && (my.health > 0))	//go around
		{
			if(my.y >= 0)
			{
				my.skill22 = 0;		//set speed
				my.skill23 = -(random(5) + 2);
				my.skill24 = 0;
				move_mode = ignore_passable;		//ignore_passable
				ent_move(my.skill22,nullvector);	//move
				wait(1);
			}
			if(my.y < 0)
			{
				my.skill22 = 0;		//set speed
				my.skill23 = random(5) + 2;
				my.skill24 = 0;
				move_mode = ignore_passable;		//ignore_passable
				ent_move(my.skill22,nullvector);	//move
				wait(1);
			}
		}
		wait(1);
	}
	while((my.health > 0) && (vec_dist(my.x,fort.x) <= 1300) && (storeOpen != 1))
	//while alive and in range (within 1300 q of fort)
	{
		if(my.skill40 > 0)	//if skill40 greater than zero
		{
			my.skill40 -= 1;	//reduce skill 40
		}
		vec_set(my.turnDir,fort.x);		//turn to target
		vec_diff(my.turnDir,my.turnDir,my.x);
		vec_to_angle(my.pan,my.turnDir);
		if((snd_playing(my.kalishnikov) != 1) && (my.skill40 == 0))
		//if gun sound isn't playing and skill40 is zero
		{
			my.kalishnikov = ent_playsound(my,ak47SND,1000);	//play gun sound
			vec_for_vertex(my.fireSpot,my,921);			//set vector of gun vertex
			ent_create(fire2SPT,my.fireSpot,akFire);		//create fire sprite
			trace_mode = ignore_me + ignore_models + ignore_sprites + activate_shoot;
			trace(gunFireSpot,fort.x);				//fire trace
			my.skill40 = 100;					//set skill40 to 100
		}
		wait(1);
	}
	//if dead
	if((my.health <= 0) && (storeOpen != 1))
	{
		snd_stop(my.kalishnikov);	//stop gunfire
		money += 100;			//increase money
		score += 100;			//increase score
		casualties += 1;		//increase casualties
		wait(1);
		my.passable = on;		//passable
		my.event = null;		//nullify events
		while(my.frame <= 12)		//run death animation
		{
			ent_cycle("death",my.anim);
			my.anim += 2 * time;
			wait(1);
		}
		while(my.pcounter <= 100)	//if pcounter less than 100
		{
			if(my.invisible == 0)		//flicker
			{
				my.invisible = on;
			}
			else
			{
				my.invisible = off;
			}
			my.pcounter += 1;
			wait(1);
		}
	}
	GunEnemies -= 1;		//reduce # of alive gunners
	ent_remove(me);	//remove self
}	

action attackStickBaz	//bazooka man that fires rpg at fort, starts on Day 4
{
	var bazFireSpot[3];		//pos where RPG launches
	my.enable_scan = on;		//enable scan detection
	my.enable_shoot = on;		//enable shoot detection
	my.event = handleShoot;		//handle scan/shoot events
	my.health = 100;			//set health
	randomize();
	my.speed = random(5) + 2;	//set random speed
	while((my.health > 0) && (vec_dist(my.x,fort.x) > 1500) && (storeOpen != 1))
	//while alive and beyond 1500 q from fort
	{
		my.skill22 = my.speed;
		my.skill23 = 0;
		my.skill24 = 0;
		move_mode = ignore_passable;	
		ent_move(my.skill22,nullvector);	//move
		ent_cycle("walk",my.anim % 100);	//cycle walk animation
		my.anim += my.skill22 * time; 		//synch with speed.
		my.skill30 = 180;			//hemisphere scan
		my.skill31 = 180;
		my.skill32 = 100;
		result = scan_entity(my.x,my.skill30);		//scan for units
		while((result != 0)  && (my.health > 0))	//go around units
		{
			if(my.y >= 0)
			{
				my.skill22 = 0;		//set speed
				my.skill23 = -(random(5) + 2);
				my.skill24 = 0;
				move_mode = ignore_passable;		//ignore_passable
				ent_move(my.skill22,nullvector);	//move
				wait(1);
			}
			if(my.y < 0)
			{
				my.skill22 = 0;		//set speed
				my.skill23 = random(5) + 2;
				my.skill24 = 0;
				move_mode = ignore_passable;		//ignore_passable
				ent_move(my.skill22,nullvector);	//move
				wait(1);
			}
		}
		wait(1);
	}
	while((my.health > 0) && (vec_dist(my.x,fort.x) <= 1500) && (storeOpen != 1))
	//while alive and within range
	{
		if(my.skill40 == 0)
		{
			ent_cycle("attack",my.anim % 100);	//cycle attack animation
			my.anim += 2 * time;
			vec_set(my.turnDir,fort.x);
			vec_diff(my.turnDir,my.turnDir,my.x);
			vec_to_angle(my.pan,my.turnDir);		//turn to target
			vec_for_vertex(my.fireSpot,my,750);		//find front vertex
			ent_create(rocket2mdl,my.fireSpot,arrowFly);	//launch rocket
			my.skill40 = 100;
		}
		if(my.skill40 > 0) { my.skill40 -= 1; }
		if(my.skill40 <= 0) { my.skill40 = 0; }
		wait(1);
	}
	//if dead:
	if((my.health <= 0) && (storeOpen != 1))	//if dead and store isn't open
	{
		money += 100;		//increase money
		score += 100;		//"      " score
		casualties += 1;	//"	 " casualties
		wait(1);
		my.passable = on;	//passable
		my.event = null;	//nullify events
		while(my.frame <= 13)	//run death animation
		{
			ent_cycle("death",my.anim);
			my.anim += 2 * time;
			wait(1);
		}
		while(my.pcounter <= 100)	//flicker for 100 ticks
		{
			if(my.invisible == 0)
			{
				my.invisible = on;
			}
			else
			{
				my.invisible = off;
			}
			my.pcounter += 1;
			wait(1);
		}
	}
	BazEnemies -= 1;	//reduce # of alive bazooka men
	ent_remove(me);	//remove self
}

action tankTurret	//the tank's turret does the attack.
{
	var tankFireSpot[3];	//rocket launch from here
	my.metal = on;		//set metal flag on
	my.passable = on;	//passable
	my.scale_x *= 1.5;	//1.5 times bigger
	my.scale_y *= 1.5;
	my.scale_z *= 1.5;
	my.skill40 = 0;
	while(you != NULL)	//while parent is not null
	{
		my.x = you.x;	//follows tank body
		my.y = you.y;
		my.z = you.z;
		if((you.stopped == 1) && (my.skill40  == 0))	//if stopped is set
		{
			vec_set(my.turnDir,fort.x);
			vec_diff(my.turnDir,my.turnDir,my.x);
			vec_to_angle(my.pan,my.turnDir);		//turn to target
			vec_for_vertex(my.fireSpot,my,250);	//set vector of front vertex
			ent_create(rocket2MDL,my.fireSpot,arrowFly);	//fire rocket
			ent_playsound(my,tankBlastSnd,1000);		//play gun fire sound
			my.skill40 = 100;
			wait(1);
		}
		if(my.skill40 > 0) { my.skill40 -= 1; }
		if(my.skill40 <= 0) { my.skill40 = 0; }
		wait(1);
	}
	ent_remove(me);	//if parent is null, remove me.
}

action attackStickTank	//attack tank, longer range than others, susceptible to player bazooka, starts on Day 5
{
	my.metal = on;			//set metal to on
	my.fat = on;			//set fat on
	my.health = 500;		//set health 500
	my.scale_x *= 1.5;		//resize to 1.5x bigger
	my.scale_y *= 1.5;
	my.scale_z *= 1.5;
	my.pcounter = 0;		//set pcounter
	my.enable_scan = on;		//enable shoot detection
	my.enable_shoot = on;		//enable scan detection
	my.event = handleShootTank;	//handle shoot/scan
	you = ent_create(tankTurretMDL,my.x,tankTurret);	//create turret
	while((my.health > 0) && (vec_dist(my.x,fort.x) > 1500) && (storeOpen != 1))
	//while alive and beyond 1500 q of fort
	{
		my.skill22 = 3;				//set speed
		my.skill23 = 0;
		my.skill24 = 0;
		move_mode = ignore_passable;
		ent_move(my.skill22,nullvector);	//move
		wait(1);
	}
	while((my.health > 0) && (storeOpen != 1))
	//if in range and alive
	{
		my.stopped = 1;	//set stopped flag so turret knows to fire
		wait(1);
	}
	//if dead:
	my.stopped = 0;		//set stopped to 0 so turret stops firing
	if((my.health <= 0) && (storeOpen != 1))
	{
		my.passable = on;	//passable
		my.event = null;	//nullify events
		money += 300;		//increase money
		score += 100;		//increase score
		casualties += 1;	//increase casualties
		while((my.pcounter <= 100) && (you != null))	//flicker turret and body for 100 ticks
		{
			if(my.invisible == 0)
			{
				my.invisible = on;
				you.invisible = on;
			}
			else
			{
				my.invisible = off;
				you.invisible = off;
			}
			my.pcounter += 1;
			wait(1);
		}
	}
	TankEnemies -= 1;	//lower # of alive tanks
	ent_remove(me);	//remove me
}	


//Enemy creation functions

function createEnemies()
{
	while(1)
	{
		while((day == 1) && (enemies <= 2))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			randvec.x = -3200;
			randvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			randvec.z = 32;
			temp.pan = 360;
			temp.tilt = 360;
			temp.z = 100;
			result = scan_entity(randvec,temp);
			if(result == 0)
			{
				wait(1);
				ent_create(stickmdl,randvec,attackStickSword);	//create a bad guy
				enemies += 1;
				sleep(random(2));	//wait between 0 - 2 seconds before making another
			}
		}
		while((day == 2) && (enemies <= 3))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			randvec.x = -3200;
			randvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			randvec.z = 32;
			temp.pan = 360;
			temp.tilt = 360;
			temp.z = 100;
			result = scan_entity(randvec,temp);
			if(result == 0)
			{
				wait(1);
				ent_create(stickmdl,randvec,attackStickSword);	//create a bad guy
				enemies += 1;
			}
			sleep(random(2));	//wait between 0 - 2 seconds before making another
		}
		while((day == 3) && (enemies <= 3))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			randvec.x = -3200;
			randvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			randvec.z = 32;
			temp.pan = 360;
			temp.tilt = 360;
			temp.z = 100;
			result = scan_entity(randvec,temp);
			if(result == 0)
			{
				wait(1);
				ent_create(stickmdl,randvec,attackStickSword);	//create a bad guy
				enemies += 1;
			}
			sleep(random(2));	//wait between 0 - 2 seconds before making another
		}
		while((day == 4) && (enemies <= 4))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			randvec.x = -3200;
			randvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			randvec.z = 32;
			temp.pan = 360;
			temp.tilt = 360;
			temp.z = 100;
			result = scan_entity(randvec,temp);
			if(result == 0)
			{
				wait(1);
				ent_create(stickmdl,randvec,attackStickSword);	//create a bad guy
				enemies += 1;
			}
			sleep(random(2));	//wait between 0 - 2 seconds before making another
		}
		while((day == 5) && (enemies <= 4))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			randvec.x = -3200;
			randvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			randvec.z = 32;
			temp.pan = 360;
			temp.tilt = 360;
			temp.z = 100;
			result = scan_entity(randvec,temp);
			if(result == 0)
			{
				wait(1);
				ent_create(stickmdl,randvec,attackStickSword);	//create a bad guy
				enemies += 1;
			}
			sleep(random(2));	//wait between 0 - 2 seconds before making another
		}
		while((day == 6) && (enemies <= 5))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			randvec.x = -3200;
			randvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			randvec.z = 32;
			temp.pan = 360;
			temp.tilt = 360;
			temp.z = 100;
			result = scan_entity(randvec,temp);
			if(result == 0)
			{
				wait(1);
				ent_create(stickmdl,randvec,attackStickSword);	//create a bad guy
				enemies += 1;
			}
			sleep(random(2));	//wait between 0 - 2 seconds before making another
		}
		wait(1);
	}
		
}

function createEnemiesArrow()
{
	while(1)
	{
		while((day == 2) && (ArrowEnemies <= 1))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			arandvec.x = -3200;
			arandvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			arandvec.z = 32;
			temp.pan = 360;
			temp.tilt = 360;
			temp.z = 100;
			result = scan_entity(randvec,temp);
			if(result == 0)
			{
				wait(1);
				ent_create(stickarrowMDL,arandvec,attackStickArrow);	//create a bad guy
				ArrowEnemies += 1;
			}
			sleep(random(2));	//wait between 0 - 2 seconds before making another
		}
		while((day == 3) && (ArrowEnemies <= 1))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			arandvec.x = -3200;
			arandvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			arandvec.z = 32;
			temp.pan = 360;
			temp.tilt = 360;
			temp.z = 100;
			result = scan_entity(randvec,temp);
			if(result == 0)
			{
				wait(1);
				ent_create(stickarrowMDL,arandvec,attackStickArrow);	//create a bad guy
				ArrowEnemies += 1;
			}
			sleep(random(2));	//wait between 0 - 2 seconds before making another
		}
		while((day == 4) && (ArrowEnemies <= 1))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			arandvec.x = -3200;
			arandvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			arandvec.z = 32;
			temp.pan = 360;
			temp.tilt = 360;
			temp.z = 100;
			result = scan_entity(randvec,temp);
			if(result == 0)
			{
				wait(1);
				ent_create(stickarrowMDL,arandvec,attackStickArrow);	//create a bad guy
				ArrowEnemies += 1;
			}
			sleep(random(2));	//wait between 0 - 2 seconds before making another
		}
		while((day == 5) && (ArrowEnemies <= 1))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			arandvec.x = -3200;
			arandvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			arandvec.z = 32;
			temp.pan = 360;
			temp.tilt = 360;
			temp.z = 100;
			result = scan_entity(randvec,temp);
			if(result == 0)
			{
				wait(1);
				ent_create(stickarrowMDL,arandvec,attackStickArrow);	//create a bad guy
				ArrowEnemies += 1;
			}
			sleep(random(2));	//wait between 0 - 2 seconds before making another
		}
		while((day == 6) && (ArrowEnemies <= 3))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			arandvec.x = -3200;
			arandvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			arandvec.z = 32;
			temp.pan = 360;
			temp.tilt = 360;
			temp.z = 100;
			result = scan_entity(randvec,temp);
			if(result == 0)
			{
				wait(1);
				ent_create(stickarrowMDL,arandvec,attackStickArrow);	//create a bad guy
				ArrowEnemies += 1;
			}
			sleep(random(2));	//wait between 0 - 2 seconds before making another
		}
		wait(1);
	}
		
}

function createEnemiesGun()
{
	while(1)
	{
		while((day == 3) && (GunEnemies <= 1))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			grandvec.x = -3200;
			grandvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			grandvec.z = 32;
			temp.pan = 360;
			temp.tilt = 360;
			temp.z = 100;
			result = scan_entity(randvec,temp);	
			if(result == 0)	
			{
				wait(1);
				ent_create(stickgunMDL,grandvec,attackStickGun);	//create a bad guy
				GunEnemies += 1;
			}
			sleep(random(2));	//wait between 0 - 2 seconds before making another
		}
		while((day == 4) && (GunEnemies <= 1))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			grandvec.x = -3200;
			grandvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			grandvec.z = 32;
			temp.pan = 360;
			temp.tilt = 360;
			temp.z = 100;
			result = scan_entity(randvec,temp);	
			if(result == 0)	
			{
				wait(1);
				ent_create(stickgunMDL,grandvec,attackStickGun);	//create a bad guy
				GunEnemies += 1;
			}
			sleep(random(2));	//wait between 0 - 2 seconds before making another
		}
		while((day == 4) && (GunEnemies <= 1))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			grandvec.x = -3200;
			grandvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			grandvec.z = 32;
			temp.pan = 360;
			temp.tilt = 360;
			temp.z = 100;
			result = scan_entity(randvec,temp);	
			if(result == 0)	
			{
				wait(1);
				ent_create(stickgunMDL,grandvec,attackStickGun);	//create a bad guy
				GunEnemies += 1;
			}
			sleep(random(2));	//wait between 0 - 2 seconds before making another
		}
		while((day == 5) && (GunEnemies <= 3))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			grandvec.x = -3200;
			grandvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			grandvec.z = 32;
			temp.pan = 360;
			temp.tilt = 360;
			temp.z = 100;
			result = scan_entity(randvec,temp);	
			if(result == 0)	
			{
				wait(1);
				ent_create(stickgunMDL,grandvec,attackStickGun);	//create a bad guy
				GunEnemies += 1;
			}
			sleep(random(2));	//wait between 0 - 2 seconds before making another
		}
		while((day == 6) && (GunEnemies <= 4))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			grandvec.x = -3200;
			grandvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			grandvec.z = 32;
			temp.pan = 360;
			temp.tilt = 360;
			temp.z = 100;
			result = scan_entity(randvec,temp);	
			if(result == 0)	
			{
				ent_create(stickgunMDL,grandvec,attackStickGun);	//create a bad guy
				GunEnemies += 1;
			}
			sleep(random(2));	//wait between 0 - 2 seconds before making another
		}
		wait(1);
	}
}


function createEnemiesBaz()
{
	while(1)
	{
		while((day == 4) && (BazEnemies <= 1))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			brandvec.x = -3200;
			brandvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			brandvec.z = 32;
			temp.pan = 360;
			temp.tilt = 360;
			temp.z = 100;
			result = scan_entity(randvec,temp);
			if(result == 0)
			{
				wait(1);
				ent_create(stickBazMDL,brandvec,attackStickBaz);	//create a bad guy
				BazEnemies += 1;
			}
			sleep(random(2));	//wait between 0 - 2 seconds before making another
		}
		while((day == 5) && (BazEnemies <= 1))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			brandvec.x = -3200;
			brandvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			brandvec.z = 32;
			temp.pan = 360;
			temp.tilt = 360;
			temp.z = 100;
			result = scan_entity(randvec,temp);
			if(result == 0)
			{
				wait(1);
				ent_create(stickBazMDL,brandvec,attackStickBaz);	//create a bad guy
				BazEnemies += 1;
			}
			sleep(random(2));	//wait between 0 - 2 seconds before making another
		}
		while((day == 6) && (BazEnemies <= 1))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			brandvec.x = -3200;
			brandvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			brandvec.z = 32;
			temp.pan = 360;
			temp.tilt = 360;
			temp.z = 100;
			result = scan_entity(randvec,temp);
			if(result == 0)
			{
				wait(1);
				ent_create(stickBazMDL,brandvec,attackStickBaz);	//create a bad guy
				BazEnemies += 1;
			}
			sleep(random(2));	//wait between 0 - 2 seconds before making another
		}
		wait(1);
	}
		
}

function createEnemiesTank()
{
	var firstTank;
	while(1)
	{
		if((day == 1) && (firstTank != 1))
		{
			tankVec.x = -3200;
			tankVec.y = 0;
			tankVec.z = 32;
			wait(1);
			ent_create(tankbodMDL,tankVec,attackStickTank);	//create a bad guy
			TankEnemies += 1;
			firstTank = 1;
			sleep(5);	//wait between 0 - 2 seconds before making another
		}
		while((day == 5) && (TankEnemies < 1))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			trandvec.x = -3200;
			trandvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			trandvec.z = 32;
			wait(1);
			ent_create(tankbodMDL,trandvec,attackStickTank);	//create a bad guy
			TankEnemies += 1;
			sleep(5);	//wait between 0 - 2 seconds before making another
		}
		while((day == 6) && (TankEnemies <= 1))
		{
			while(storeOpen == 1) { wait(1); }
			randomize();
			trandvec.x = -3200;
			trandvec.y = int(random(-1980)) + 990;	//pick a random y val b/t -1000 and 1000
			trandvec.z = 32;
			wait(1);
			ent_create(tankbodMDL,trandvec,attackStickTank);	//create a bad guy
			TankEnemies += 1;
			sleep(5);	//wait between 0 - 2 seconds before making another
		}
		wait(1);
	}
}