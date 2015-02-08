Stage3d 		= require('core/Stage3d')
Module 			= require('modules/Module')
MaterialFactory = require('factories/MaterialFactory')

class Main extends Module

	@cubes = []

	constructor:()->
		super()
		console.log('001 skybox.grid')
		geometry = new THREE.BoxGeometry(7,7,7)
		material = new THREE.MeshBasicMaterial({color:0xFF0000,wireframe:true,transparent: true, blending: THREE.AdditiveBlending})
		@mesh = new THREE.Mesh(geometry,material)
		Stage3d.add(@mesh)


		
		w = 128
		h = 32
		d = 128

		t = 8
		s = 10

		for x in [0...w] by t
			for y in [0...h] by t
				for z in [0...d] by t
					geo = new THREE.BoxGeometry(t*s-1,t*s-1,t*s-1)
					material = MaterialFactory.getGridMaterial()
					mesh = new THREE.Mesh(geo,material)
					mesh.position.set( x-w/2, y-h/2, z-d/2 ) 
					mesh.position.multiplyScalar(s)
					#@cubes.push(mesh)
					Stage3d.add(mesh)
		
		
		Stage3d.add(MaterialFactory.createSkybox('textures/skybox'))


		return

	update:(dt)->
		#@mesh.rotation.x+=.05
		angle = Date.now() * 0.01
		#log(angle)
		#console.log(@cubes.length)
		###
		for element in @cubes
			console.log(element)
			element.position.x = Math.sin(angle)*100
		###

		return

	@testModule()

module.exports = Main