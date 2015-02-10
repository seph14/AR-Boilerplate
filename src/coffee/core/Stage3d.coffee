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

	rendererStats = null
	stats = null

	@init = (options)=>

		if(@isInit)
			return

		w = window.innerWidth
		h = window.innerHeight

		@camera = new THREE.PerspectiveCamera( 40, w / h, 1, 50000 )
		@camera.position.z = 100

		@scene = new THREE.Scene()
		@scene.add( new THREE.AmbientLight(color:0xFFFF00) )

		@scene.fog = new THREE.Fog(0x000000, 200, 2800)
		#@scene.fog.color.setHSL( 0.51, 0.6, 0.6 )

		transparent = options.transparent||false
		antialias = options.antialias||false

		@renderer = new THREE.WebGLRenderer({alpha:transparent,antialias:antialias})
		@renderer.setSize( w, h )

		document.body.appendChild(@renderer.domElement)

		rendererStats	= new THREEx.RendererStats()
		rendererStats.domElement.style.position	= 'absolute'
		rendererStats.domElement.style.right	= '0px'
		rendererStats.domElement.style.bottom	= '0px'
		document.body.appendChild( rendererStats.domElement )

		stats	= new Stats()
		stats.domElement.style.position	= 'absolute'
		stats.domElement.style.right	= '0px'
		stats.domElement.style.top	= '4px'
		document.body.appendChild( stats.domElement )

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

		#@angle+= (dt/1000) * (@umouse.x) *.2
		@angle+= (@umouse.x * Math.PI - @angle)/15
		@radius+= (1800+@umouse.x*1400-@radius)/10

		@campos.y+=(@umouse.y*800-@campos.y)/20

		@camera.position.set(@radius * Math.cos(@angle),@campos.y,@radius * Math.sin(@angle))
		@camera.lookAt(new THREE.Vector3())

		Stage3d.renderer.render(@scene, @camera)

		rendererStats.update(@renderer);
		stats.update();
		return


	@resize = ()=>
		if @renderer
			@camera.aspect = window.innerWidth / window.innerHeight
			@camera.updateProjectionMatrix()
			@renderer.setSize( window.innerWidth, window.innerHeight )
		return

module.exports = Stage3d
