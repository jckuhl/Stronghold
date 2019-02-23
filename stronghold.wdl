///////////////////////////////////////////////////////////////////////////////////
// A5 main wdl
////////////////////////////////////////////////////////////////////////////
// Files to over-ride:
// * logodark.bmp - the engine logo, include your game title
// * horizon.pcx - A horizon map displayed over the sky and cloud maps
////////////////////////////////////////////////////////////////////////////
// The PATH keyword gives directories where game files can be found,
// relative to the level directory
path "C:\\Program Files\\GStudio\\template";	// Path to WDL templates subdirectory

include <map.wdl>;		//insert the directory
include <variables.wdl>;	//deals with all variables
include <panels.wdl>;		//deals with all panels
include <player.wdl>;		//deals with player shooting and reloading and defending
include <strong_en_ai.wdl>;	//deals with enemy army
include <cheats.wdl>;		//deals with cheating
include <store.wdl>;		//deals with buying upgrades
include <gameplay.wdl>;		//deals with most panels

/////////////////////////////////////////////////////////////////
// Strings and filenames
string level_str = <stronghold.WMB>; //Level map

/////////////////////////////////////////////////////////////////
// define a splash screen with the required A4/A5 logo
bmap splashmap = <logodark.pcx>; // the default logo in templates
panel splashscreen {
	bmap = splashmap;
	flags = refresh,d3d;
}

/////////////////////////////////////////////////////////////////
// The main() function is started at game start
function main()
{
	tex_share = on;		// map entities share their textures
	wait(3);		//wait 3
	level_load(level_str);	//load level
	wait(1);		//wait
	clip_size = 0.001;	//lower clip size
	video_switch(8,16,0);	//switch video res
	wait(1);		//wait
	splashscreen.pos_x = (screen_size.x - bmap_width(splashmap))/2;		//center screen
	splashscreen.pos_y = (screen_size.y - bmap_height(splashmap))/2;	//center screen
	splashscreen.visible = on;	//turn on splashscreen
	freeze_mode = 1;	//freeze
	sleep(1);		//wait req sec
  	splashscreen.visible = off;	//turn of screen
	menuPan.visible = on;	//show menupan
	bmap_purge(splashmap);	// remove splashscreen from video memory
	freeze_mode = 0;	//unfreeze
	MOUSE_MAP = arrow; // Arrow as Mouspointer!	//places a mouse
	MOUSE_MODE += 2;
	if (MOUSE_MODE > 2) // was it already on?
	{ 
		MOUSE_MODE=0;
	}
	while (1) // move it over the screen
	{ 
		if(mouse_mode > 0)
		{
			MOUSE_POS.X = pointer.x - (bmap_width(arrow)/2);
			MOUSE_POS.Y = pointer.y - (bmap_height(arrow)/2);
		}
		if(shotsHit > 0)
		{
			accuracy = (shotsHit/shotsFired) * 100;
		}
		wait(1);
	}
}

panel lvlNumPan	//debugging panel to show variables and such.
{
	pos_x = 50;
	pos_y = 50;
	layer = 30;
	digits = 2,240,5,standardFont,1,counter;
	digits = 2,260,5,standardFont,1,shotsFired;
	digits = 2,280,5,standardFont,1,shotsHit;
	digits = 2,300,5,standardFont,1,accuracy;
	flags = overlay, refresh, visible;
}
