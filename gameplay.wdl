//Gameplay.wdl

function setVariables()
{
	gunType = 1;  //1-hand gun, 2-machine gun, 3-sniper rifle, 4-bazooka, 5-nuclear missile
	handClip = 7;	//bullets in one clip
	handClipMax = 7; //max bullets in a clip
	mgClip = 30;
	mgClipMax = 30;
	mgAmmo = 300;	//total ammo
	sniperClip = 1;
	sniperClipMax = 1;
	sniperAmmo = 10;
	bazookaClip = 1;
	bazookaClipMax = 1;
	bazookaAmmo = 5;
	nukeClip = 1;
	nukeAmmo = 0;
	return;
}

function startMusic()
{
	wait(1);
	musicHandle = snd_loop(musicSnd,musicVol,0);
	return;
}

function play()
{
	menuPan.visible = off;
	infoPan.visible = on;
	blackPan.visible = on;
	handSelect.visible = on;
	handClipPan.visible = on;
	handAmmoPan.visible = on;
	gameStarted = 1;
	//startMusic();
	createEnemies();
	createEnemiesArrow();
	createEnemiesGun();
	createEnemiesBaz();
	createEnemiesTank();
	gunmen();
	sniperTowers();
	fortifications();
	dayFunc();
	while(1)
	{
		if(day < 31)
		{
			//winPan.visible = on;
		}
		if(fort.health <= 0)
		{
			fort.health = 0;
			storeOpen = 1;
			losePan.visible = on;
		}
		wait(1);
	}
}

function help()
{
	helpPan.visible = on;
	return;
}

function quit()
{
	EXIT;
}

function helpBack()
{
	helpPan.visible = off;
	return;
}

function musicUp()
{
	while((key_equals) && (musicVol <= 99))
	{
		musicVol += 1;
		wait(1);
	}
	return;
}

function musicDn()
{
	while((key_minusc) && (musicVol >= 0))
	{
		musicVol -= 1;
		wait(1);
	}
	return;
}

function mute()
{
	if(musicVol > 0)
	{
		musicVol = 0;
		return;
	}
	if(musicVol == 0)
	{
		musicVol = 100;
		return;
	}
}

function showMenu()
{
	if(gameStarted == 0) { exit; }	//if game is not started, exit, else continue
	if(menuPan.visible == off)	//if menu is not visible
	{
		menuPan.visible = on;	//turn on the menu panel
		pause();		//toggle pause on
		return;
	}
	if(menuPan.visible == on)	//if menu is visible
	{
		menuPan.visible = off;	//turn off the menu panel
		pause();		//toggle pause off
		return;
	}
}

on_equals = musicUp;
on_minusc = musicDn;
on_m = mute;
on_esc = showMenu;