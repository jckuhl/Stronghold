//Debugger

view debugCam 
{
	layer = 0;
}

function activateDebugCam()
{
	debugCam.visible = on;
	while(1)
	{
		debugCam.x += key_force.y;
		debugCam.y += key_force.x;
		debugCam.z += (key_home - key_end);
		debugCam.pan += (key_comma - key_period);
		debugCam.tilt += (key_pgup - key_pgdn);
		wait(1);
	}
}

on_0 = activateDebugCam;
