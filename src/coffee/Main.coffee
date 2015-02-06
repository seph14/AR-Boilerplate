StageRenderer = require "core/StageRenderer"
Stage3d = require "core/Stage3d"
SceneTraveler = require "core/scenes/SceneTraveler"
HomeScene = require "HomeScene"

#---------------------------------------------------------- Class Main

class Main

	mouse = {x:0,y:0}
	
	@init = ()->
		StageRenderer.onUpdate.add(SceneTraveler.update)
		StageRenderer.onResize.add(SceneTraveler.resize)
		SceneTraveler.to(new HomeScene())
		return

	document.addEventListener('DOMContentLoaded', ()->
		Main.init()
		return
	)

	document.addEventListener('mousemove', (e)->
		mouse.x = e.pageX;
		mouse.y = e.pageY;
		Stage3d.mouse.x = e.pageX;
		Stage3d.mouse.y = e.pageY;

		#console.log(mouse)
		return
	)


module.exports = Main