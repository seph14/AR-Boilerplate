Stage3d 		= require('core/Stage3d')
Module 			= require('modules/Module')
MaterialFactory = require('factories/MaterialFactory')

class Main extends Module

	constructor:()->
		super()
		console.log('002')
		geometry = new THREE.SphereGeometry(7,10,10)
		material = new THREE.MeshBasicMaterial({color:0x00FF00,wireframe:true})
		@mesh = new THREE.Mesh(geometry,material)
		Stage3d.add(@mesh)



		(new THREE.OBJLoader()).load('models/Voronoitest18_LowpolyBake.obj', ( object ) ->
            object.recieveShadow = true
            object.traverse( ( node ) ->
                if node instanceof THREE.Mesh

                	#
					#node.geometry.computeFaceNormals()
					#node.geometry.computeVertexNormals()
                    node.receiveShadow = true
                    node.material = MaterialFactory.getMeshBasicMaterial()
                    node.material = MaterialFactory.getMeshNormalMaterial()
            )

            Stage3d.add(object)

            clone = object.clone()
            clone.position.y=300
            clone.rotation.y=175
            Stage3d.add(clone)

            clone = object.clone()
            clone.position.y=-300
            clone.rotation.y=-227
            Stage3d.add(clone)

        )

		return

	update:(dt)->
		@mesh.rotation.z += 0.01
		return

	@testModule()

module.exports = Main