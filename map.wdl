//Map.wdl
/*This file is specifically to map all parts of the script, it is a directory
In order of complilation:

variables.wdl
	-No functions/actions
	-Vars
	-Defines
	-Strings
	-Entities
	-Sounds
	-Bmaps
	-Fonts

Panels.wdl
	-panel infoPan
	-panel blackPan
	-panel menuPan
	-panel helpPan
	-panel losePan
	-panel handClipPan
	-panel mgClipPan
	-panel sniperClipPan
	-panel bazookaClipPan
	-panel nukeClipPan
	-text handAmmoPan
	-panel mgAmmoPan
	-panel sniperAmmoPan
	-panel bazAmmoPan
	-panel nukeAmmoPan
	-panel handSelect
	-panel mgSelect
	-panel snipeSelect
	-panel bazSelect
	-panel scopePan
	-panel storePan
	-panel blackPan2

player.wdl
	-view scopeView
	-function scopeOff()
	-function sniperScope()
	-function reload()
	-function switchHandGun()
	-function switchMG()
	-function switchSniper()
	-function switchBazooka()
	-function switchNuke()
	-action duster
	-function mouse_trace()
	-action exploder
	-function handleImpact()
	-action rocketFly
	-action mushroomCloud
	-function handleNukeImpact()
	-action rocketFlyNuke
	-function shoot()
	-function takeDamage()
	-action meleeWall()
	-action strongHouse
	-action shield
	-action boundary
	-function genSheild()
	-keyboard instructions for shoot, scope, reload, selecting guns

strong_en_ai.wdl
	-function handleShoot()
	-function handleShootTank()
	-action attackSticksword
	-function handleCol()
	-action arrowFly
	-action attackStickArrow
	-action akFire
	-action attackStickGun
	-action attackStickBaz
	-action tankTurret
	-action attackStickTank
	-function createEnemies()
	-function createEnemiesArrow()
	-function createEnemiesGun()
	-function createEnemiesBaz()
	-function createEnemiesTank()

cheats.wdl
	-function cheat()

store.wdl
	-function pause()
	-function store()
	-function keepGoing()
	-function dayFunc()
	-action fire


End of Directory*/