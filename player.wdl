//PLayer interaction

view scopeView 		//sniper view
{
	layer = 0;
}


function scopeOff()	//switches sniper scope (view & panel) off and camera back on.
{
	scopePan.visible = off;
	scopeView.visible = off;
	camera.x = -824;
	camera.y = -2723;
	camera.z = 1218;
	camera.visible = on;
	mouse_mode = 2;	//turn mouse back on
	return;
}

function sniperScope()	//turns scope on and off
{
	if((scopePan.visible == off) && (gunType == 3))
	{
		mouse_mode = 0;			//turn mouse off
		scopeView.x = -824;		//set scopeView vector
		scopeView.y = -1780;
		scopeView.z = 600;
		scopeView.pan = 90;
		scopeView.roll = 0;
		scopePan.visible = on;		//turn panel on
		camera.visible = off;		//turn camera off
		scopeView.visible = on;		//turn view on
		while(scopePan.visible == on)
		{
			scopeView.pan -= 3 * mouse_force.x;	//allow panning with mouse_force
			scopeView.tilt += 3 * mouse_force.y;	//allow tilt with mouse_force
			wait(1);
		}
		return;				//leave function
	}
	if((scopePan.visible == on) && (scopeView.visible == on))
	{
		scopeOff();	//turn off scope
		return;		//leave function
	}
}

function reload()
{
	if(gunType == 1)	//if handgun selected
	{
		snd_play(loadGun,100,0);
		while(handClip < handClipMax)	//while clip is less than the max
		{
			handClip += 1;	//add a bullet
			handDisabled = 1;	//disable firing during reload	
			wait(1);
		}
		handDisabled = 0;	//re-enable firing
		return;
	}
	if(gunType == 2)	//if machine gun selected
	{
		if(mgAmmo >= mgClipMax)
		{
			snd_play(loadGun,100,0);
			mgAmmo -= mgClipMax - mgClip;	//calculated deduction from remaining ammo
			while(mgClip < mgClipMax)	//while clip is less than the max
			{
				mgClip += 1;		//add a bullet
				mgDisabled = 1;	//disable firing during reload
				wait(1);
			}
			mgDisabled = 0;	//re-enable firing
			return;
		}
		if((mgAmmo <= mgClipMax) && (mgAmmo > 0))
		//If there is less ammo than the clip size, take the remaining ammo and load it.
		{
			snd_play(loadGun,100,0);
			while(mgClip < mgAmmo)	
			{
				mgClip += 1;
				mgDisabled = 1;
				wait(1);
			}
			mgAmmo = 0;
			mgDisabled = 0;
			return;
		}
	}
	if(gunType == 3)	//if sniper selected
	{
		if(sniperAmmo >= sniperClipMax)
		{
			snd_play(loadGun,100,0);
			sniperAmmo -= sniperClipMax - sniperClip;	//calculated deduction from remaining ammo
			while(sniperClip < sniperClipMax)	//while clip is less than the max
			{
				sniperClip += 1;		//add a bullet
				sniperDisabled = 1;	//disable firing during reload
				wait(1);
			}
			sniperDisabled = 0;	//re-enable firing
			return;
		}
		
	}
	if(gunType == 4)	//if bazooka enabled
	{
		if(bazookaAmmo >= bazookaClipMax)
		{
			snd_play(loadGun,100,0);
			bazookaAmmo -= bazookaClipMax - bazookaClip;	//calculated deduction from remaining ammo
			while(bazookaClip < bazookaClipMax)	//while clip is less than the max
			{
				bazookaClip += 0.05;		//add a bullet
				bazDisabled = 1;	//disable firing during reload
				wait(1);
			}
			bazDisabled = 0;	//re-enable firing
			return;
		}
	}
	if(gunType == 5)	//if nuke selected
	{
		if(nukeAmmo >= 1)
		{
			snd_play(loadGun,100,0);
			nukeAmmo -= nukeClip;	//calculated deduction from remaining ammo
			while(nukeClip < 1)	//while clip is less than the max
			{
				nukeClip += 0.05;		//add a bullet
				nukeDisabled = 1;	//disable firing during reload
				wait(1);
			}
			nukeDisabled = 0;	//re-enable firing
			return;
		}
	}
	return;
}

function switchHandGun()	//switches to handgun
{
	gunType = 1;			//set to hand gun
	handClipPan.visible = on;
	handSelect.visible = on;
	mgSelect.visible = off;
	snipeSelect.visible = off;
	bazSelect.visible = off;
	nukeSelect.visible = off;
	mgClipPan.visible = off;
	sniperClipPan.visible = off;
	bazookaClipPan.visible = off;
	nukeClipPan.visible = off;
	handAmmoPan.visible = on;
	mgAmmoPan.visible = off;
	sniperAmmoPan.visible = off;
	bazAmmoPan.visible = off;
	nukeAmmoPan.visible = off;
	if(scopePan.visible == on)
	{
		scopeOff();
	}
	return;
}

function switchMG()		//switches to machine gun
{
	if(gameStarted == 0) { return; }
	gunType = 2;			//set to machine gun
	handSelect.visible = off;
	mgSelect.visible = on;
	snipeSelect.visible = off;
	bazSelect.visible = off;
	nukeSelect.visible = off;
	handClipPan.visible = off;
	mgClipPan.visible = on;
	sniperClipPan.visible = off;
	bazookaClipPan.visible = off;
	nukeClipPan.visible = off;
	handAmmoPan.visible = off;
	mgAmmoPan.visible = on;
	sniperAmmoPan.visible = off;
	bazAmmoPan.visible = off;
	nukeAmmoPan.visible = off;
	if(scopePan.visible == on)
	{
		scopeOff();
	}
	return;
}

function switchSniper()		//switches to sniper rifle
{
	if(gameStarted == 0) { return; }
	gunType = 3;	//set to sniper rifle
	handSelect.visible = off;
	mgSelect.visible = off;
	snipeSelect.visible = on;
	bazSelect.visible = off;
	nukeSelect.visible = off;
	handClipPan.visible = off;
	mgClipPan.visible = off;
	sniperClipPan.visible = on;
	bazookaClipPan.visible = off;
	nukeClipPan.visible = off;
	handAmmoPan.visible = off;
	mgAmmoPan.visible = off;
	sniperAmmoPan.visible = on;
	bazAmmoPan.visible = off;
	nukeAmmoPan.visible = off;
	return;
}

function switchBazooka()	//switches to bazooka
{
	if(gameStarted == 0) { return; }
	gunType = 4;	//set to rocket launcher
	handSelect.visible = off;
	mgSelect.visible = off;
	snipeSelect.visible = off;
	bazSelect.visible = on;
	nukeSelect.visible = off;
	handClipPan.visible = off;
	mgClipPan.visible = off;
	sniperClipPan.visible = off;
	bazookaClipPan.visible = on;
	nukeClipPan.visible = off;
	handAmmoPan.visible = off;
	mgAmmoPan.visible = off;
	sniperAmmoPan.visible = off;
	bazAmmoPan.visible = on;
	nukeAmmoPan.visible = off;
	if(scopePan.visible == on)
	{
		scopeOff();
	}
	return;
}

function switchNuke()		//switches to nuke
{
	if(gameStarted == 0) { return; }
	gunType = 5;	//set to nuke launcher
	handSelect.visible = off;
	mgSelect.visible = off;
	snipeSelect.visible = off;
	bazSelect.visible = off;
	nukeSelect.visible = on;
	handClipPan.visible = off;
	mgClipPan.visible = off;
	sniperClipPan.visible = off;
	bazookaClipPan.visible = off;
	nukeClipPan.visible = on;
	handAmmoPan.visible = off;
	mgAmmoPan.visible = off;
	sniperAmmoPan.visible = off;
	bazAmmoPan.visible = off;
	nukeAmmoPan.visible = on;
	if(scopePan.visible == on)
	{
		scopeOff();
	}
	return;
}

action duster	//sprite to create dust or blood effect
{
	my.passable = on;	//turn on passable
	my.overlay = 1;		//turn off black
	my.transparent = on;	//transparent
	my.alpha = 25;		//alpha of 25
	my.facing = on;		//facing is on
	my.z += 25;		//higher than the ground
	while(my.alpha > 0)
	{
		my.alpha -= 1;		//decrease alpha to the point of invisibility
		wait(1);		//avoid endless loops
	}
	if(my.alpha == 0)	//when invisible
	{
		ent_remove(me);	//remove self
	}
}

function mouse_trace(traceDist,ax,ay,mode) //shoots a trace from mouse/sniper panel to traceDist
{
	from.X = ax;	//set from.x to mouse_pos.x
	from.Y = ay;	//set from.y to mouse_pos.y
	from.Z = 0;		//set from.z to zero
	vec_set(to,from);	//copy from to to
	vec_for_screen(from,camera);	//convert from to 3d coords
	to.Z = traceDist; 			//set to.z to 5000
	vec_for_screen(To,camera); 	//convert to to 3d coords
	trace_mode = mode;
	return(trace(From,To));		//return the distance between from and to
}

action exploder	//rpg explosion
{
	my.passable = on;	//passable
	my.invisible = on;	//invisible
	my.light = on;		//turn on the light
	my.lightrange = 100;	//set light range to 100
	my.red = 255;		//full red
	my.green = 255;		//full green
	my.blue = 255;		//full blue
	while(my.lightrange < 300)	//while lightrange is less than 1000
	{
		my.lightrange += 5;	//increase it
		wait(1);
	}
	ent_remove(me);	//once at 1000 LR, remove self
}

function handleImpact()
{
	if((event_type == event_block) || (event_type == event_entity))
	{
		
		temp.pan = 360;
		temp.tilt = 360;
		temp.z = 300;				//set scan sphere
		result = scan_entity(my.x,temp);	//scan for nearby entities (their function hurts them
		wait(1);
		my.passable = on;			//become passable
		ent_create(exploMDL,my.x,exploder);	//explode
		ent_remove(me);				//remove self
	}
}
action rocketFly
{
	rpg = my;			//rpg is rocket pointer
	my.enable_block = on;		//enable impact
	my.enable_entity = on;		//enable entity;
	my.event = handleImpact;	//set event
	vec_set(my.turnDir,target);		
	vec_diff(my.turnDir,my.turnDir,my.x);
	vec_to_angle(my.pan,my.turnDir);	//turn to target
	while(1)
	{
		my.skill22 = 100;	//100 q per tick
		my.skill23 = 0;
		my.skill24 = 0;
		move_mode = ignore_passable + ignore_passents;
		ent_move(my.skill22,nullvector);	//go to target
		wait(1);
	}
}

action mushroomCloud
{
	my.transparent = on;	//transparent
	my.alpha = 50;		//alpha  is 50
	my.passable = on;	//passable is on
	my.lightrange = 100;	//set light range to 100
	my.red = 255;		//full red
	my.green = 255;		//full green
	my.blue = 255;		//full blue
	my.skin = 1;		//yellow skin
	while(my.lightrange < 2000)	//while lightrange is less than 1000
	{
		my.lightrange += 70;	//increase it
		my.scale_x += 0.5;	//increase size
		my.scale_y += 0.5;
		my.scale_z += 0.5;
		wait(1);
	}
	ent_remove(me);	//once at 1000 LR, remove self
}


function handleNukeImpact()
{
	if((event_type == event_block) || (event_type == event_entity))	//if it hits the ground
	{
		temp.pan = 360;					//set scan sphere
		temp.tilt = 360;
		temp.z = 2000;
		result = scan_entity(my.x,temp);		//scan for enemies
		wait(1);
		my.passable = on;				//become passable
		ent_create(sheildMDL,my.x,mushroomCloud);	//explode
		ent_remove(me);					//remove rocket
	}
}

action rocketFlyNuke
{
	nuclear = my;			//nuclear pointer to rocket
	my.enable_block = on;		//enable impact
	my.enable_entity = on;		//enable entity
	my.event = handleNukeImpact;	//set event
	vec_set(my.turnDir,target);
	vec_diff(my.turnDir,my.turnDir,my.x);
	vec_to_angle(my.pan,my.turnDir);	//turn to target
	while(1)
	{
		my.skill22 = 50;		//50 QPT
		my.skill23 = 0;
		my.skill24 = 0;
		move_mode = ignore_passable;
		ent_move(my.skill22,nullvector);	//go to target
		wait(1);
	}
}

function shoot()
{
	if(menuPan.visible == on) { return; }
	if((gunType == 1) && (handDisabled != 1) && (gameStarted == 1))
	//if hand gun is selected, not loading and the game has started
	{
		if(handClip > 0) //if there is ammo
		{
			snd_play(handGunSnd,100,0); //play gun sound
			result = mouse_trace(5000,pointer.x,pointer.y,activate_shoot);
			//fire trace
			shotsFired += 1;
			if((result > 0) && (you == null))
			//if nothing is found
			{
				ent_create(dustsprite,target,duster);
				//create dust sprite
			}
			handClip -= 1;	//reduce bullets in clip
		}
		return;
	}
	if((gunType == 2) && (mgDisabled != 1) && (gameStarted == 1))
	//if machine gun is selected, not reloading and game has started
	{
		while((mouse_left) && (mgClip > 0))	//while mouse is clicked and clip has bullets
		{
			if(snd_playing(mgSndHandle) == 0)
			{
				mgSndHandle = snd_play(mgSnd,100,0);	//play machine gun sound
			}
			result = mouse_trace(5000,pointer.x,pointer.y,activate_shoot);
			//fire trace
			shotsFired += 1;
			if((result > 0) && (you == NULL))
			{
				ent_create(dustsprite,target,duster);	//if nothing was hit, create dust
			}
			mgClip -= 1;	//reduce bullets in clip
			wait(1);
		}
		snd_stop(mgSndHandle);	//end sound when mg isn't firing
		return;
	}
	if((gunType == 3) && (sniperDisabled != 1) && (gameStarted == 1))
	//if sniper rifle is selected, isn't reloading, and game has started
	{
		if((sniperClip > 0) && (scopePan.visible != 1))
		//if clip has bullets and scope pan isn't visible
		{
			snd_play(sniperSnd,100,0);	//play sniper sound
			result = mouse_trace(5000,pointer.x,pointer.y,activate_shoot);
			//fire trace
			shotsFired += 1;
			if((result > 0) && (you == NULL))
			//if nothing was hit
			{
				ent_create(dustsprite,target,duster);	//create dust
			}
			sniperClip -= 1;	//reduce bullets in clip
		}
		if((sniperClip > 0) && (scopePan.visible == 1))
		//if clip has bullets and scope pan is visible
		{
			snd_play(sniperSnd,100,0);  //play sniper sound
			result = mouse_trace(5000,(pointer.x - bmap_width(scopeMap)/2),(pointer.y - bmap_height(scopeMap)/2),activate_shoot);
			//shoot from center of the screen
			shotsFired += 1;
			if((result > 0) && (you == NULL))
			//if nothing was hit
			{
				ent_create(dustsprite,target,duster);	//create dust
			}
			sniperClip -= 1;	//reduce bullets in clip
		}
		return;
	}
	if((gunType == 4) && (bazDisabled != 1) && (gameStarted == 1))
	//if bazooka is selected, not reloading and the game has started
	{
		if(bazookaClip > 0)  //if there are rpg rounds
		{
			snd_play(bazSnd,100,0);		//play bazooka sound
			result = mouse_trace(50000,pointer.x,pointer.y,ignore_models);
			//find target
			shotsFired += 1;
			if(result > 0)
			{
				ent_create(rocketmdl,camera.x,rocketFly);	//launch rocket
				bazookaClip -= 1;				//reduce inventory
				wait(1);
			}
		}
		return;
	}
	if((gunType == 5) && (nukeDisabled != 1) && (gameStarted == 1))
	//if the nuke has been selected, isn't reloading and game has started
	{
		if(nukeClip > 0)	//if there are nuclear warheads available
		{
			snd_play(bazSnd,100,0);		//play bazooka sound
			result = mouse_trace(50000,pointer.x,pointer.y,ignore_models);
			//find target
			shotsFired += 1;
			if(result > 0)
			{
				ent_create(rocketmdl,camera.x,rocketFlyNuke);	//launch ICBM
				nukeClip -= 1;					//reduce inventory
			}
		}
		return;
	}
}

function takeDamage()
{
	if((event_type == event_shoot) && (you.enType == 1) && (fort.invincible == off))
	{
		fort.health -= 1;	//If hit by enemy swordsman/gunman reduce health by 1
		return;
	}
	if((event_type == event_shoot) && (you.enType == 2) && (fort.invincible == off))
	{
		fort.health -= 5;	//If hit by tank, bazooka, bowman, reduce health by 5
		return;
	}
}

action meleeWall	//Wall enemy attacks to damage fort
{
	var wallScan[3];	//set the scan variable
	wall2 = my;		//set a pointer
	my.safety = on;		//Its scan does no damage to the wall
	my.enable_shoot = on;	//enable shoot
	my.enable_detect = on;	//and scan events
	my.event = takeDamage;	//if shot/scanned, call takeDamage
	while(1)	//do until game ends
	{
		wallScan.pan = 360;	//set scan sphere
		wallScan.tilt = 360;	
		wallScan.z = 75;	//radius = 75
		scan_entity(my.x,wallScan);	//scan for enemies (sets their stop flag on)
		wait(1);
	}
}

/*THE STRONGHOLD:
Player must protect for 31 days.
If health is zero or less, the game is over.*/

action strongHouse
{
	fort = my;		//set pointer
	my.health = 100;	//set default health
	my.invincible = off;	//set invincible to off
	my.maxHealth = 100;	//set default maximum health
	my.enable_shoot = on;	//enable shoot
	my.enable_impact = on;	//enable impact
	my.event = takeDamage;
}

//generates a defensive shield that kills all within the shield and blocks all outside
//lasts for 15 seconds

action sheild 
{
	var shdScan[3];
	shd = my;		//set pointer
	my.skin = 2;		//blue skin
	my.transparent = on;	//transparent
	my.alpha = 25;		//25 alpha
	while(my.scale_x <= 12)
	{
		my.scale_x += 1;	//scale up
		my.scale_y += 1;
		my.scale_z += 1;
		wait(1);
	}
	shdScan.pan = 360;
	shdScan.tilt = 360;
	shdScan.z = 1200;
	scan_entity(my.x,shdScan);	//scan to kill anything inside
	sleep(15);			//wait 15 seconds
	while(my.scale_x >= 1)
	{
		my.scale_x -= 1;	//scale down
		my.scale_y -= 1;
		my.scale_z -= 1;
		wait(1);
	}
	ent_remove(me);		//remove
}

action boundary		//keeps enemies from going through sheild
{
	bound = my;
	my.invisible = on;	//invisible always
	while(1)
	{
		if(shd != NULL)			//if shield exists
		{
			my.passable = off;	//impassable
		}
		if(shd == NULL)			//if shield doesn't exist
		{
			my.passable = on;	//passable
		}
		wait(1);
	}
}

function genSheild()	//generates the shield
{
	var here[3];
	here.x = 632;	//place over Strong Hold
	here.y = 0;
	here.z = 0;
	if(sheilds > 0)	//if there are shields
	{
		ent_create(sheildMDL,here,sheild);	//create the shield
		sheilds -= 1;				//reduce inventory of shields
	}
	return;
}

on_mouse_left = shoot;	//shoot.
on_mouse_right = sniperScope;	//turn on/off sniper scope
on_space = reload;	//on space, reload weapon
on_1 = switchHandGun;	//on 1, select hand gun
on_2 = switchMG;	//on 2, select machine gun
on_3 = switchSniper;	//on 3, select sniper rifle
on_4 = switchBazooka;	//on 4, select bazooka
on_5 = switchNuke;	//on 5, select nuke launcher
on_s = genSheild;	//on s, generate shield