# 
# Stage3d for three.js with every basics you need
#
# @author David Ronai / Makiopolis.com / @Makio64 
# 

class Stage3d


	@camera 	= null
	@scene 		= null
	@renderer 	= null
	@isInit		= false

	@mouse 		= {x:0, y:0}
	@campos 	= {x:0, y:0, z:0}

	@angle  	= 0
	@mode 		= "free"

	@init = (options)=>

		if(@isInit)
			return

		w = window.innerWidth
		h = window.innerHeight

		@camera = new THREE.PerspectiveCamera( 40, w / h, 1, 10000 )
		@camera.position.z = 100

		@scene = new THREE.Scene()
		@scene.add( new THREE.AmbientLight(color:0xFFFFFF) )

		transparent = options.transparent||false
		antialias = options.antialias||false

		@renderer = new THREE.WebGLRenderer({alpha:transparent,antialias:antialias})
		@renderer.setSize( w, h )

		document.body.appendChild(@renderer.domElement)

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

		#console.log(dt/1000)
		@angle+= (dt/1000) * @mouse.x/600
		radius = 800

		@campos.y+=(((@mouse.y-300)*10)-@campos.y)/10

		@camera.position.set(radius * Math.cos(@angle),@campos.y,radius * Math.sin(@angle))
		@camera.lookAt(new THREE.Vector3())

		Stage3d.renderer.render(@scene, @camera)
		return


	@resize = ()=>
		if @renderer
			@camera.aspect = window.innerWidth / window.innerHeight
			@camera.updateProjectionMatrix()
			@renderer.setSize( window.innerWidth, window.innerHeight )
		return

	@setUpStats: () ->
        @stats = new Stats()
        @stats.domElement.style.position = 'absolute'
        @stats.domElement.style.top = '0px'
        @stats.domElement.style.zIndex = 100
        document.body.style.backgroundColor = '#D7F0F7'

module.exports = Stage3d
