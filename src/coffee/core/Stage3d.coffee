# 
# Stage3d for three.js with every basics you need
#
# @author David Ronai / Makiopolis.com / @Makio64 
# 

class Stage3d


	@camera 	= null
	@scene 		= null
	@renderer 	= null
	@stats 		= null
	@isInit		= false

	@mouse 		= {x:0, y:0}
	@umouse 	= {x:.5, y:.5}
	@campos 	= {x:0, y:0, z:0}

	@angle  	= 0
	@radius 	= 2000

	@init = (options)=>

		if(@isInit)
			return

		w = window.innerWidth
		h = window.innerHeight

		@camera = new THREE.PerspectiveCamera( 40, w / h, 1, 20000 )
		@camera.position.z = 100

		@scene = new THREE.Scene()
		@scene.add( new THREE.AmbientLight(color:0xFFFF00) )

		transparent = options.transparent||false
		antialias = options.antialias||false

		@renderer = new THREE.WebGLRenderer({alpha:transparent,antialias:antialias})
		@renderer.setSize( w, h )

		document.body.appendChild(@renderer.domElement)

		#@setUpStats()

		return


	@add = (obj)=>
		@scene.add(obj)
		return


	@remove = (obj)=>
		@scene.remove(obj)
		return


	@removeAll = ()=>
		while @scene.children.length>0
			@scene.remove(@scene.children[0])
		return


	@render = (dt)=>

		#@stats.update()
		#console.log(dt/1000)
		@angle+= (dt/1000) * @umouse.x
		@radius+= (1800+@umouse.x*1400-@radius)/10

		@campos.y+=(@umouse.y*800-@campos.y)/20

		@camera.position.set(@radius * Math.cos(@angle),@campos.y,@radius * Math.sin(@angle))
		@camera.lookAt(new THREE.Vector3())

		Stage3d.renderer.render(@scene, @camera)
		return


	@resize = ()=>
		if @renderer
			@camera.aspect = window.innerWidth / window.innerHeight
			@camera.updateProjectionMatrix()
			@renderer.setSize( window.innerWidth, window.innerHeight )
		return
	###
	@setUpStats: () ->
        @stats = new Stats()
        @stats.domElement.style.position = 'absolute'
        @stats.domElement.style.top = '0px'
        @stats.domElement.style.zIndex = 1002
	###
module.exports = Stage3d
