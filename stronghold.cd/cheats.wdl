//Cheat codes

on_f12 = NULL;

text cheattxt
{
	layer = 20;
	pos_x = 400;
	pos_y = 500;
	font = standardFont;
	strings = 1;
	string = getCode;
	flags = visible,d3d;
}

text errortxt
{
	layer = 20;
	pos_x = 400;
	pos_y = 600;
	font = standardFont;
	strings = 1;
	string = error;
	flags = d3d;
}

function cheat()
{
	inkey(getCode);
	if(result == 13)
	{
		if(str_cmp(getCode,getMoney) == 1)
		{
			money += 1000000;
			str_cpy(getCode,emptyStr);
			return;
		}
		if(str_cmp(getCode,getHealth) == 1)
		{
			wall2.health = 10000;
			wall2.maxhealth = 10000;
			str_cpy(getCode,emptyStr);
			return;
		}
		if(str_cmp(getCode,getInvincible) == 1)
		{
			wall2.invincible = on;
			str_cpy(getCode,emptyStr);
			return;
		}
		if(str_cmp(getCode,getMG) == 1)
		{
			mgClip = 999;
			mgClipMax = 999;
			mgAmmo = 999;
			str_cpy(getCode,emptyStr);
			return;
		}
		if(str_cmp(getCode,getSniper) == 1)
		{
			sniperClip = 999;
			sniperClipMax = 999;
			sniperAmmo = 999;
			str_cpy(getCode,emptyStr);
			return;
		}
		if(str_cmp(getCode,getBaz) == 1)
		{
			bazookaClip = 999;
			bazookaClipMax = 999;
			bazookaAmmo = 999;
			str_cpy(getCode,emptyStr);
			return;
		}
		if(str_cmp(getCode,getNuke) == 1)
		{
			nukeClip = 999;
			nukeAmmo = 999;
			str_cpy(getCode,emptyStr);
			return;
		}
		if(str_cmp(getCode,getTheMonkey) == 1)
		{
			//creates a crazy killer monkey
			//ent_create(monkeyMDL,monkeySpot,theCrazyKillerMonkey);
			str_cpy(getCode,emptyStr);
			return;
		}
		if(str_cmp(getCode,getGunmen) == 1)
		{
			gunman = 7;
			str_cpy(getCode,emptyStr);
			return;
		}
		if((str_cmp(getCode,getMoney) != 1) && 
		(str_cmp(getCode,getHealth) != 1) &&
		(str_cmp(getCode,getInvincible) != 1) &&
		(str_cmp(getCode,getMG) != 1) &&
		(str_cmp(getCode,getSniper) != 1) &&
		(str_cmp(getCode,getBaz) != 1) &&
		(str_cmp(getCode,getNuke) != 1) &&
		(str_cmp(getCode,getTheMonkey) != 1) &&
		(str_cmp(getCode,getGunmen) != 1))
		{
			str_cpy(getCode,emptyStr);
			errortxt.visible = on;	
			sleep(3);
			errortxt.visible = off;
			return;
		}
	}
		
}

on_p = cheat;
		