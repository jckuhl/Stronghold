//Cheat codes

on_f12 = NULL;

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
			fort.health = 10000;
			fort.maxhealth = 10000;
			str_cpy(getCode,emptyStr);
			return;
		}
		if(str_cmp(getCode,getInvincible) == 1)
		{
			fort.invincible = on;
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
		if(str_cmp(getCode,getShields) == 1)
		{
			sheilds = 999;
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
		(str_cmp(getCode,getGunmen) != 1) &&
		(str_cmp(getCode,getShields) != 1))
		{
			str_cpy(getCode,emptyStr);
			errortxt.visible = on;	
			sleep(3);
			errortxt.visible = off;
			return;
		}
	}
		
}

on_grave = cheat;
		