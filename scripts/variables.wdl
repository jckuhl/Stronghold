//Variables, and other defined stuff

var score;		//Tallies the score
var gameStarted = 0;	//Flag - starts certain functions
var to[3];		//mouse trace vector
var from[3];		//mouse trace vector
var gunType = 1;  	//1-hand gun, 2-machine gun, 3-sniper rifle, 4-bazooka, 5-nuclear missile
var handClip = 7;	//bullets in one clip
var handClipMax = 7;	//max bullets in a clip
var mgClip = 30;	//bullets in mg clip
var mgClipMax = 30;	//max bullets in mg clip
var mgAmmo = 300;	//total mg ammo
var sniperClip = 1;	//bullets in sniper rifle
var sniperClipMax = 1;	//max bullets in sniper
var sniperAmmo = 10;	//total sniper ammo
var bazookaClip = 1;	//loaded bazooka rounds
var bazookaClipMax = 1;	//clip size max
var bazookaAmmo = 5;	//total bazooka ammo
var nukeClip = 1;	//loaded nuclear rounds
var nukeAmmo = 0;	//remaining nuclear ammo
var rockDist[3];	//speed of rocket
var nukeDist[3];	//speed of nuke
var handDisabled;	//flag, 0-guns enabled, 1-guns disabled
var mgDisabled;		//flag, disables weapon during reload
var sniperDisabled;	//flag, disables weapon during reload
var bazDisabled;	//flag, disables weapon during reload
var nukeDisabled;	//flag, disables weapon during reload
var money;		//Money available
var mgSndHandle;	//handles machinegun shound
var day = 1;		//simulated days since start
var enemies;		//num of sword enemies at once
var ArrowEnemies;	//num of archers at once
var GunEnemies;		//num of gun enemies
var BazEnemies;		//num of bazooka enemies
var TankEnemies;	//num of tank enemies
var randvec[3];		//random vec where swordsman spawn
var arandvec[3];	//random vec where archers spawn
var grandvec[3];	//random vec where gunmen spawn
var trandvec[3];	//random vec where tanks spawn
var brandvec[3];	//random vec where bazookamen spawn
var counter;		//frames per day (5000)
var casualties;		//number enemies dead
var musicHandle;	//handles music
var musicVol = 100;	//handles volume
var tankVec[3];		//initial tank start vector
var sheilds = 1;	//shields available
var gunman = 0;		//gunmen defending fort
var watchTower = 0;	//watchtowers defending fort
var fortify = 0;	//fortifications bought
var storeOpen;		//checks if the store is open
var shotsFired;
var shotsHit;
var accuracy;

define health,skill1;		//health of entities
define maxHealth,skill2;	//max health of entities
define anim,skill3;		//animation % of entities
define pcounter,skill4;		//counts to 100 to flicker dying enemy
define kalishnikov,skill6;	//sound of gunner's AK47
define myTargx,skill7;		//define target vector for
define myTargy,skill8;		//stick gunner and	   
define myTargz,skill9;		//stick swordsman
define enType,skill10;		//1 - swordsman, 2 - gunman
define turnDir,skill11;		//Turn direction of rockets
define fireSpot,skill12;	//checks the gunman's firesprite.
define speed,skill25;		//speed of a unit
define invincible,flag2;	//fort's invinciblility flag
define stopped,flag3;		//tank flag to tell turret to fire
define safety,flag4;		//wall flag to keep it from murdering anything
define targeted,flag5;		//has it been targeted?
define jackson,flag6;		//pseudo-pointer for defensive snipers
define mg42,flag7;		//pseudo-pointer for defensive gunners


string dustsprite = <dust.bmp>;			//dust
string bloodsprite = <blood.bmp>;		//spilled blood
string exploMDL = <explosion.mdl>;		//bazooka explosion
string rocketmdl = <rocket.mdl>;		//player rocket
string stickmdl = <sticksoldier.mdl>;		//swordsman
string arrowMDL = <arrow.mdl>;			//arrow
string tankBodMDL = <tankbody.mdl>;		//tank body
string tankTurretMDL = <tankturret.mdl>;	//tank turret
string stickBazMDL = <sticksoldierbaz.mdl>;	//bazooka man model
string stickArrowMDL = <sticksoldierarrow.mdl>;	//archer model
string stickGunMDL = <sticksoldiergun.mdl>;	//gunner model
string rocket2mdl = <rocket2.mdl>;		//rocket model
string sheildMDL = <shield.mdl>;		//shield model
string mg42MDL = <mg42.mdl>;			//mg42 model
string fireSPT = <gunfire.bmp>;			//gunfire sprite <-
string fire2SPT = <gunfire2.bmp>;		//gunfire sprite ->
string towerWMB = <snipertower.wmb>;		//sniper tower map entity
string fortLvl2 = <stronghouse2.wmb>;
string fortLvl3 = <stronghouse3.wmb>;
string strongAnim = <strongholdanim.avi>;
string emptyStr = "                                        ";	//empty string to erase getCode
string getCode = "                                        ";	//input from player
string getMoney = "insider trading";		//money cheat code
string getHealth = "i am the luv docter";	//health cheat code
string getInvincible = "i am god's boss";	//invincible cheat code
string getMG = "i read dirty magasines";	//machine gun cheat code
string getSniper = "go get em shooter!";	//sniper cheat code
string getBaz = "the rockets red glare";	//bazooka cheat code
string getNuke = "nuclear winter";		//nuclear weapon cheat code
string getTheMonkey = "monkeys and guns";	//Crazy monkey cheat code
string getGunmen = "pathfinders 101st";		//gunmen cheat code
string getSnipers = "high in her tower";	//watch tower sniper code
string getShields = "missile attack";		//shield code
string errorch = "You dirty little cheater!  I can't believe you!  And you didn't even get the code right!"; //error string
string infin = "Infinite";

entity* wall2;		//defense wall
entity* nuclear;	//player nuke missile pointer
entity* rpg;		//player bazooka pointer
entity* fort;		//fort pointer
entity* shd;		//sheild pointer
entity* snTargSw;	//sniper targets
entity* mgTargSw;	//Machine Gunner targets
entity* swordTarg;	//Swordsman's target (the wall)
entity* bound;		//shield boundary
//entity* ptr;

sound handGunSnd = <colt45.wav>;		//hand gun sound
sound mgSnd = <machinegun.wav>;			//machine gun sound
sound sniperSnd = <SPRINGFI.wav>;		//sniper sound
sound bazSnd = <BAZOOKA.wav>;			//bazooka sound
sound loadGun = <cockgun.wav>;			//reload
sound tankSnd = <tank1.wav>;			//tank driving
sound musicSnd = <TheMight2.wav>;		//background music
sound tankBlastSnd = <tankfire-1.wav>;		//tank fire
sound mg42SND = <MG42Burst_02.wav>;		//fort gunmen fire
sound sniperTowSND = <SpringfieldFire2.wav>;	//fort sniper fire
sound ak47SND = <ak47-1.wav>;			//enemy gunman fire

bmap arrow = <crosshair.bmp>;		//crosshair cursor
bmap scopeMap = <sniperpan.bmp>;	//sniper panel
bmap menuMap = <strongtitlescreen.bmp>;		//menu panel
bmap newButton = <newbut.bmp>;		//new button
bmap newButtonOv = <newbut_ov.bmp>;
bmap helpButton = <helpbut.bmp>;	//help button
bmap helpButtonOv = <helpbut_ov.bmp>;
bmap quitButton = <quitbut.bmp>;	//quit button
bmap quitButtonOv = <quitbut_ov.bmp>;
bmap saveButton = <savebut.bmp>;	//save button
bmap saveButtonOv = <savebut_ov.bmp>;
bmap backButton = <backbut.bmp>;	//back button
bmap backButtonOv = <backbut_ov.bmp>;
bmap helpMap = <helpscreen.bmp>;		//help panel
bmap infoMap = <infopan.bmp>;		//game top panel
bmap blackMap = <blackpan.bmp>;		//background to infoMap
bmap handMap = <handpan.bmp>;		//hand gun selected panel
bmap snipeMap = <sniperPanSelect.bmp>;	//sniper selected panel
bmap mgMap = <mgPan.bmp>;		//machine gun selected panel
bmap bazMap = <bazookaPan.bmp>;		//bazooka selected panel
bmap nukeMap = <nukePan.bmp>;		//nuclear selected panel
bmap storeMap = <storepan.bmp>;
bmap blackMap2 = <blackpanstore.bmp>;
bmap contButton = <continuebut.bmp>;
bmap contButtonOv = <continuebut_ov.bmp>;
bmap loseMap = <losePan.bmp>;
bmap smokeEmit = <smokeemit.bmp>;	//smoke particle
bmap blackAvi = <blackpanavi.bmp>;

font standardFont = <ackfont.pcx>,6,9;	//debug/cheat font
font strongFont = <strongfont.bmp>,17,17;