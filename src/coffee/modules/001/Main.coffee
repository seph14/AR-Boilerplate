Stage3d 		= require('core/Stage3d')
Module 			= require('modules/Module')
MaterialFactory = require('factories/MaterialFactory')

class Main extends Module

	cubes = []

	constructor:()->
		super()
		console.log('001')
		geometry = new THREE.BoxGeometry(7,7,7)
		material = new THREE.MeshBasicMaterial({color:0xFF0000,wireframe:true})
		@mesh = new THREE.Mesh(geometry,material)
		Stage3d.add(@mesh)


		###
			w = 10
			h = 10
			for x in [0...w] by 2
				for y in [0...h] by 2
					geo = new THREE.BoxGeometry(2,2,2)
					material = new THREE.MeshBasicMaterial({color:0x00ffff,wireframe:false})
					mesh = new THREE.Mesh(geo,material)
					mesh.position.set( x-w/2, y-w/2, 0 ) 
					mesh.position.multiplyScalar(10)
					cubes.push(mesh)
					Stage3d.add(mesh)
		###
		
		Stage3d.add(MaterialFactory.createSkybox('textures/skybox'))


		return

	update:(dt)->
		@mesh.rotation.x+=.05
		angle = Date.now() * 0.01
		log(angle)
		console.log(@cubes.length)
		for element in @cubes
			console.log(element)
			element.position.x = Math.sin(angle)*100


		return

	@testModule()

module.exports = Main