// GSFlash v1.14 *Compiled for A5.5+*

// Note on Flash Script Commands. If Flash_FSCmds(1); is run then flash script commands run in the SWF be piped to
// c-script. If the flash script command is called "blahblah" you will need a c-script function called 
// function blahblah() {}. Any arguments of the flash script command are passed to the first parameter of the
// function as a string. For example, function blahblah(args) {} where args would contain the arguments from
// the flash script command. Good luck.

dllfunction Flash_Create(name_str,filename); // name_str = name of flash component // filename is the filename of the swf file // returns 1 if error else returns 0.

dllfunction Flash_Verbose(verbose_int); // verbose_int = 1 show error messages // returns 1 if error else returns 0.

dllfunction Flash_FSCmds(fscmds_int); // fscmds_int = 1 run flash script commands // returns 1 if error else returns 0.

dllfunction Flash_Paint(name_str,bmap); // name_str = name of flash component // returns 1 if error else returns 0.

dllfunction Flash_MouseDown(name_str,x,y); // name_str = name of flash component // returns 1 if error else returns 0.
dllfunction Flash_MouseUp(name_str,x,y); // name_str = name of flash component // returns 1 if error else returns 0.
dllfunction Flash_MouseMove(name_str,x,y); // name_str = name of flash component // returns 1 if error else returns 0.

dllfunction Flash_SetBounds(name_str,width,height); // name_str = name of flash component // returns 1 if error else returns 0.

dllfunction Flash_Play(name_str); // name_str = name of flash component

dllfunction Flash_Free(name_str); // name_str = name of flash component // returns 1 if error else returns 0.


bmap flash_bmap = <flashpan.bmp>; // the default logo in templates
panel flash {
	pos_x = 0;
	pos_y = 364;
	bmap = flash_bmap;
        on_click = OnFlashClick;
	layer = 20;
	flags = refresh,d3d;
}

string flash1 = "Flash1";
string flashfile = "strongholdanim.swf";
var VaryMouse = 0;

function OnFlashClick() {
Flash_MouseDown(flash1,(pointer.x-flash.pos_x),(pointer.y-flash.pos_y));
waitt(1);
Flash_MouseUp(flash1,(pointer.x-flash.pos_x),(pointer.y-flash.pos_y));
}


function DoFlash() {

dll_handle = dll_open("GSFlash.dll");

Flash_Verbose(1);

Flash_Create(flash1,flashfile);

Flash_SetBounds(flash1,300,300);

Flash_Play(flash1);

MouseMove();
while(1) {
Flash_Paint(flash1,flash_bmap);
waitt(1);
}

Flash_Free(flash1);
dll_close(dll_handle);
}

function MouseMove() {

while(1) {
if(VaryMouse==1) {
VaryMouse=0;
}
else
{
VaryMouse=1;
}
Flash_MouseMove(flash1,(pointer.x-flash.pos_x)+VaryMouse,(pointer.y-flash.pos_y)+VaryMouse);
wait(1);
}

}