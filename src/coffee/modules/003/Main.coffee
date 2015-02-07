Stage3d 		= require('core/Stage3d')
Module 			= require('modules/Module')
MaterialFactory = require('factories/MaterialFactory')


class Main extends Module

	constructor:()->
		super()
		console.log('003 terrain')


		if true

            url = 'models/terrainA.obj'
            #url = 'models/Voronoitest18_LowpolyBake.obj'
            
            (new THREE.OBJLoader()).load(url, ( object ) ->
                object.recieveShadow = true
                object.traverse( ( node ) ->
                    if node instanceof THREE.Mesh

                        #
                        #node.geometry.computeFaceNormals()
                        #node.geometry.computeVertexNormals()
                        node.receiveShadow = true
                        node.material = MaterialFactory.getMeshBasicMaterial()
                        #node.material = MaterialFactory.getMeshNormalMaterial()
                )

                Stage3d.add(object)

                if true
                        clone = object.clone()
                        clone.position.y=200
                        clone.rotation.y=90
                        Stage3d.add(clone)

                        clone = object.clone()
                        clone.position.y=-200
                        clone.rotation.y=180
                        Stage3d.add(clone)

                        clone = object.clone()
                        clone.position.y=-400
                        clone.rotation.y=270
                        Stage3d.add(clone)
                

            )
		return

	update:(dt)->
		return

	@testModule()

module.exports = Main