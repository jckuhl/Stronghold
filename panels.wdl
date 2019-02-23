//Panels.wdl

panel infoPan	//displays information vital to the game
{
	layer = 10;
	bmap = infomap;
	digits = 73,15,4,strongFont,1,fort.health;	//health indicator
	digits = 150,15,4,strongFont,1,fort.maxHealth;	//max health indicator
	digits = 395,15,7,strongFont,1,money;		//money indicator
	digits = 385,44,3,strongFont,1,sheilds;		//sheild indicator
	flags = d3d,refresh,overlay;
}

panel blackPan	//a black panel behind the infoPan, makes the letters show so infoMap can have an overlay
{
	layer = 5;
	bmap = blackMap;	//a black .bmp
	flags = d3d,refresh;
}

panel menuPan	//the main menu, allows for new game, help, and quitting
{
	layer = 11;
	bmap = menuMap;
	button = 532,135,newButtonOv,newButton,newButtonOv,play,null,null;	//new game
	button = 557,254,helpButtonOv,helpButton,helpButtonOv,help,null,null;	//help
	button = 493,404,quitButtonOv,quitButton,quitBUttonOv,quit,null,null;	//quit
	flags = d3d,refresh;
}

panel helpPan	//displays the gameplay instructions
{
	layer = 12;
	bmap = helpMap;
	flags = d3d,refresh;
}


panel losePan	//displays the lose message
{
	layer = 35;
	bmap = loseMap;
	flags = d3d,refresh,overlay;
}

panel handClipPan	//Shows clip size of hand gun
{
	pos_x = 0;
	pos_y = 0;
	layer = 30;
	digits = 73,44,4,strongFont,1,handClip;
	digits = 150,44,4,strongFont,1,handClipMax;
	flags = d3d,refresh;
}

panel mgClipPan		//Shows clip size of Machine Gun
{
	pos_x = 0;
	pos_y = 0;
	layer = 30;
	digits = 73,44,4,strongFont,1,mgClip;
	digits = 150,44,4,strongFont,1,mgClipMax;
	flags = d3d,refresh;
}

panel sniperClipPan	//shows clip size of sniper rifle
{
	pos_x = 0;
	pos_y = 0;
	layer = 30;
	digits = 73,44,4,strongFont,1,sniperClip;
	digits = 150,44,4,strongFont,1,sniperClipMax;
	flags = d3d,refresh;
}

panel bazookaClipPan	//shows clip size of bazooka
{
	pos_x = 0;
	pos_y = 0;
	layer = 30;
	digits = 73,44,4,strongFont,1,bazookaClip;
	digits = 150,44,4,strongFont,1,bazookaClipMax;
	flags = d3d,refresh;
}

panel nukeClipPan	//shows clip size of nuke missile launcher
{
	pos_x = 0;
	pos_y = 0;
	layer = 30;
	digits = 73,44,4,strongFont,1,nukeClip;
	digits = 150,44,4,strongFont,1,nukeAmmo;
	flags = d3d,refresh;
}

text handAmmoPan	//shows handgun ammo as infinite
{
	pos_x = 73;
	pos_y = 72;
	layer = 30;
	font = strongFont;
	strings = 1;
	string = infin;
	flags = d3d;
}

panel mgAmmoPan		//shows machinegun ammo
{
	pos_x = 0; pos_y = 0;
	layer = 30;
	digits = 73,72,4,strongFont,1,mgAmmo;
	flags = d3d,refresh;
}

panel sniperAmmoPan	//shows sniper rifle ammo
{
	pos_x = 0; pos_y = 0;
	layer = 30;
	digits = 73,72,4,strongFont,1,sniperAmmo;
	flags = d3d,refresh;
}

panel bazAmmoPan	//shows bazooka ammo
{
	pos_x = 0; pos_y = 0;
	layer = 30;
	digits = 73,72,4,strongFont,1,bazookaAmmo;
	flags = d3d,refresh;
}

panel nukeAmmoPan	//shows nuclear ammo
{
	pos_x = 0; pos_y = 0;
	layer = 30;
	digits = 73,72,4,strongFont,1,nukeAmmo;
	flags = d3d,refresh;
}

panel handSelect	//shows that handgun is selected
{
	bmap = handMap;
	layer = 15;
	pos_x = 65;
	pos_y = 100;
	flags = d3d,refresh;
}

panel mgSelect		//shows that machine gun is selected
{
	bmap = mgMap;
	layer = 15;
	pos_x = 65;
	pos_y = 100;
	flags = d3d,refresh;
}

panel snipeSelect	//shows that sniper rifle is selected
{
	bmap = snipeMap;
	layer = 15;
	pos_x = 65;
	pos_y = 100;
	flags = d3d,refresh;
}

panel bazSelect		//shows that bazooka is selected
{
	bmap = bazMap;
	layer = 15;
	pos_x = 65;
	pos_y = 100;
	flags = d3d,refresh;
}

panel nukeSelect	//shows that nuke is selected
{
	bmap = nukeMap;
	layer = 15;
	pos_x = 65;
	pos_y = 100;
	flags = d3d,refresh;
}


panel scopePan		//A scope for the sniper
{
	bmap = scopeMap;
	layer = 5;
	alpha = 95;
	flags = transparent,d3d,refresh,overlay;
}

panel storePan	//player buys upgrades
{
	layer = 40;
	bmap = storeMap;
	flags = d3d,refresh,overlay;
	digits = 714,225,7,strongFont,1,score;
	button = 755,705,contButtonOv,contButtonOv,contButton,keepGoing,null,null;	//continue button
}

panel blackPan2	//same purpose of blackPan, only for storePan
{
	layer = 35;
	bmap = blackMap2;
	alpha = 75;
	flags = d3d,transparent,refresh;
}

text cheattxt	//player types cheat on this text object
{
	layer = 20;
	pos_x = 400;
	pos_y = 500;
	font = standardFont;
	strings = 1;
	string = getCode;
	flags = visible,d3d;
}

text errortxt	//error message when player f's up the cheat
{
	layer = 20;
	pos_x = 400;
	pos_y = 600;
	font = standardFont;
	strings = 1;
	string = errorch;
	flags = d3d;
}