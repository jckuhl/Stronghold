GSFlash v1.14
http://www.peacekeeper.com/3dgs/
eli@peacekeeper.com

Use:
Free for all GameStudio projects without restrictions. 

Disclaimer: If it blows up your machine it's not our fault.

Installation:
Unzip gsflash.wdl into your templates directory.
Unzip GSFlash.dll into your work directory. 

Publishing:
You will have to copy the DLL manually to your .cd directory when you publish.
You will have to copy your SWF files manually to your .cd directory when you publish.

Testing:
When testing your SWF files should be in the bin directory.

Versions:

9/02/2003 -- v1.14 -- Released. Bugfix.
4/11/2003 -- v1.13 -- Released. Bugfix.
4/07/2003 -- v1.12 -- Released.
4/01/2003 -- v1.1 -- Released.
3/23/2003 -- v1.0 -- Released.

Usage:

See gsflash.wdl for a list of functions and their parameters.

Note on Flash Script Commands. If Flash_FSCmds(1); is run then flash script commands run in the SWF be piped to
c-script. If the flash script command is called "blahblah" you will need a c-script function called 
function blahblah() {}. Any arguments of the flash script command are passed to the first parameter of the
function as a string. For example, function blahblah(args) {} where args would contain the arguments from
the flash script command. Good luck.

Hints:
*Panel needs to be 16bit.
*Panel and flash need to be the same size.
*If your panel starts out as invisible you need to bmap_preload the
image before flash can access it.
*The default image for your panel can't have alpha data from a TGA.


Examples:

include <gsflash.wdl>;

// Example
main {

DoFlash();

}

Potential Flash on a Sprite or Entity texture:

bmap* myspritebmap;
action FlashOnSprite() {

dll_handle = dll_open("GSFlash.dll");

Flash_Verbose(1);

Flash_Create(flash1,flashfile);

Flash_SetBounds(flash1,300,300);

Flash_Play(flash1);

myspritebmap = bmap_for_entity(my,0);
while(1) {
Flash_Paint(flash1,myspritebmap);
waitt(1);
}

Flash_Free(flash1);
dll_close(dll_handle);
}