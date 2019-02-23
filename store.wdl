//Store WDL

function pause()
{
	if(freeze_mode < 1)
	{
		freeze_mode = 1;
		return;
	}
	if(freeze_mode == 1)
	{
		freeze_mode = 0;
		return;
	}
}

function store()	//pauses the game and allows player to buy upgrades
{
	blackPan2.visible = on;
	storePan.visible = on;
	storeOpen = 1;
	money += 100 * day;
	score += (money + (day * 100) + casualties + fort.health + gunman + watchtower + (fortify * 20)) - (fort.maxHealth - fort.health);
	return;
}

function keepGoing()	//continues the game
{
	blackPan2.visible = off;
	storePan.visible = off;
	storeOpen = 0;
	return;
}

function dayFunc()	//increases level about every 2 minutes
{
	while(day <= 31)	//31 is the last day, after which the player wins
	{
		if(freeze_mode == 0)
		{
			if(counter >= 5000)	//if counter is equal to/greater than 5000
			{
				day += 1;			//go to next day
				gameStarted = 0;		//stop game
				store();			//open store
				while(storeOpen == 1) { wait(1); }	//wait for store to be closed
				wait(1);
				gameStarted = 1;		//start game
				counter = 0;			//reset counter
			}
			counter += 1;				//increase counter
		}
		wait(1);
	}
}


action fire
{
	my.passable = on;
	my.transparent = on;
	my.alpha = 50;
	my.overlay = on;
	my.facing = on;
	my.oriented = off;
}

action mg42Gunner
{
	var gunnerHandle;	//set the sound handle
	var mgScan[3];		//set the scan vector
	my.mg42 = on;		//set its flag on for identification
	my.pan = 180;		//turn it towards the enemy advance
	my.metal = on;		//make it metallic
	my.lightrange = 100;	//give it some light so it looks like something
	while(1)		//always there
	{
		mgScan.pan = 360;	//scan full sphere
		mgScan.tilt = 360;
		mgScan.z = 2000;	//2000 radius
		scan_entity(my.x,mgScan);	//scan
		if(mgTargSw != null)		//if a target is found (pointer set in handleShoot() in strong_en_ai.wdl)
		{
			if(mgTargSw.health > 0)	//if target is alive
			{
				gunnerHandle = ent_playsound(my,mg42SND,1000);	//play gun sound
				while(snd_playing(gunnerHandle) == 1)		//while sound is playing
				{
					if(mgTargSw == NULL) { break; }		//break if object is dead
					vec_set(temp,mgTargSw.x);		
					vec_diff(temp,temp,my.x);
					vec_to_angle(my.pan,temp);		//turn to target
					trace_mode = ignore_me + ignore_passable + ignore_maps + activate_shoot;
					trace(my.x,mgTargSw.x);			//shoot
					wait(1);
				}
				sleep(random(1) + 2);	//wait 2 or 3 seconds before continuing
			}
		}
		wait(1);
	}
}

function gunmen()
{
	var gunSpot[3];	//position of gunmen
	var gunPos;	//flag so computer doesn't build more than one in a position.
	while(1)
	{
		if((gunman >= 1) && (gunPos == 0))
		//Check if a gunman has been bought and if a gun has been placed their
		{
			gunSpot.x = 515;
			gunSpot.y = -120;
			gunSpot.z = 32 + 16;	//look how lazy I am!
			wait(1);
			ent_create(mg42MDL,gunSpot,mg42Gunner);	//place a gunner
			gunPos = 1;
		}
		if((gunman >= 2) && (gunPos == 1))
		{
			gunSpot.x = 515;
			gunSpot.y = 0;
			gunSpot.z = 32 + 16;
			wait(1);
			ent_create(mg42MDL,gunSpot,mg42Gunner);	//place a gunner
			gunPos = 2;
		}
		if((gunman >= 3) && (gunPos == 2))
		{
			gunSpot.x = 515;
			gunSpot.y = 120;
			gunSpot.z = 32 + 16;
			wait(1);
			ent_create(mg42MDL,gunSpot,mg42Gunner);	//place a gunner
			gunPos = 3;
		}
		if((fortify >= 1) && (gunman >= 4) && (gunPos == 3))
		{
			gunSpot.x = 544;
			gunSpot.y = 56;
			gunSpot.z = 192;
			wait(1);
			ent_create(mg42MDL,gunSpot,mg42Gunner);	//place a gunner
			gunPos = 4;
		}
		if((fortify >= 1) && (gunman >= 5) && (gunPos == 4))
		{
			gunSpot.x = 544;
			gunSpot.y = -56;
			gunSpot.z = 192;
			wait(1);
			ent_create(mg42MDL,gunSpot,mg42Gunner);	//place a gunner
			gunPos = 5;
		}
		if((fortify >= 2) && (gunman >= 6) && (gunPos == 5))
		{
			gunSpot.x = 568;
			gunSpot.y = 0;
			gunSpot.z = 336;
			wait(1);
			ent_create(mg42MDL,gunSpot,mg42Gunner);	//place a gunner
			gunPos = 6;
		}
		if((fortify >= 2) && (gunman >= 7) && (gunPos == 6))
		{
			gunSpot.x = 568;
			gunSpot.y = 0;
			gunSpot.z = 512;
			wait(1);
			ent_create(mg42MDL,gunSpot,mg42Gunner);	//place a gunner
			gunPos = 7;
			return;
		}
			
		wait(1);
	}
}

action sniperTow	//tower for sniper to hang out in
{
	my.passable = on;	//allow nothing to collide with it so sniper can shoot without interferance
	while(my.z < 0)
	{
		my.z += 1;	//rise from ground when bought
		wait(1);
	}
}

action sniper
{
	var sniperHandle;	//set the sound handle
	var snScan[3];		//set the scan vector
	my.jackson = on;	//set the identification flag
	my.pan = 180;		//face enemy advance
	my.skill40 = 0;		//set attack rate
	while(my.z < 294)	//rise with sniper tower
	{
		my.passable = on;	//passable while rising
		my.z += 1;
		wait(1);
	}
	my.passable = off;	//impassable
	while(1)
	{	
		snScan.pan = 360;	//scan in a sphere
		snScan.tilt = 360;
		snScan.z = 2500;	//2500 radius
		scan_entity(my.x,snScan);	//scan
		if(snTargSw != null)		//if target is found (pointer set in handleShoot() in strong_en_ai.wdl)
		{
			if(snTargSw.health > 0)	//if it is alive
			{
				vec_set(temp,snTargSw.x);
				vec_diff(temp,temp,my.x);
				vec_to_angle(my.pan,temp);	//turn to target
				if(my.skill40 == 0)
				{
					trace_mode = ignore_me + ignore_passable + ignore_maps + activate_shoot;
					trace(my.x,snTargSw.x);	//shoot it
					my.skill40 = 1000;	//set attack rate to 1000
				}
				ent_playsound(my,sniperTowSND,1000);
				if((result > 0) && (you == NULL))
				{
					ent_create(dustsprite,target,duster);
				}
				while(my.skill40 > 0) { my.skill40 -= 1; }	//lower attack rate before firing again
			}
		}
		waitt(48);
	}
}

function sniperTowers()	//set up the sniper towers
{
	var watchPos;		//set the number of towers
	var watchSpot[3];	//set the tower vectors
	var sniperSpot[3];	//set the sniper vectors
	var sniperPos;		//set the number of snipers
	while(1)
	{
		if((watchtower >= 1) && (watchPos == 0))
		{
			watchSpot.x = 592;	//set the coordinates
			watchSpot.y = 336;
			watchSpot.z = -480;
			sniperSpot.x = 576;
			sniperSpot.y = 336;
			sniperSpot.z = -224;
			wait(1);
			ent_create(towerWMB,watchSpot,sniperTow);	//create tower
			wait(1);
			ent_create(stickgunMDL,sniperSpot,sniper);	//create sniper
			watchPos = 1;
		}
		if((watchtower >= 2) && (watchPos == 1))
		{
			watchSpot.x = 592;	//set the coordinates
			watchSpot.y = -336;
			watchSpot.z = -480;
			sniperSpot.x = 576;
			sniperSpot.y = -336;
			sniperSpot.z = -224;
			wait(1);
			ent_create(towerWMB,watchSpot,sniperTow);	//create tower
			wait(1);
			ent_create(stickgunMDL,sniperSpot,sniper);	//create sniper
			watchPos = 2;
		}
		wait(1);
	}
}

function fortifications()
{
	var fortPos;		//set number of fortifications
	var fortSpot[3];	//set the vector
	while(1)
	{
		if((fortify >= 1) && (fortPos == 0))
		{
			fortSpot.x = 640;	//set coordinates
			fortSpot.y = -16;
			fortSpot.z = 160;
			wait(1);
			ent_create(fortLvl2,fortSpot,null);	//create the fort
			fort.health *= 2;			//double fort health
			fort.maxHealth *= 2;			//double fort max health
			fortPos = 1;
		}
		if((fortify >= 2) && (fortPos == 1))
		{
			fortSpot.x = 640;
			fortSpot.y = 0;
			fortSpot.z = 304;
			wait(1);
			ent_create(fortLvl3,fortSpot,null);	//create the fort
			fort.health *= 2;			//double health
			fort.maxHealth *= 2;			//double max health
			fortPos = 3;
		}
		wait(1);
	}
}

on_p = pause;	//pause on P