<<<<<<< HEAD
Stage3d         = require('core/Stage3d')
Module          = require('modules/Module')
MaterialFactory = require('factories/MaterialFactory')
StageRenderer   = require('core/StageRenderer')

class Main extends Module

    @construction = null

    constructor:()->
        super()
        console.log('003 terrain')
        cnt = 0

        directLight = new THREE.DirectionalLight( 0x00ffff, 1 );
        directLight.position.set(.5,-1,.2)
        Stage3d.add( directLight );

        directLightBack = new THREE.DirectionalLight( 0xffeedd, 10 );
        directLightBack.position.set(0,0,1)
        Stage3d.add( directLightBack );

        if true

            lambertMaterial = MaterialFactory.getMeshLambertMaterial()
            url = 'models/stone.dae'
            url = 'models/hero.dae'
            #url = 'models/Voronoitest18_LowpolyBake.obj'
            
            (new THREE.ColladaLoader()).load(url, ( result ) ->
                object = result.scene
=======
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
>>>>>>> 49c0ca6dd7e303561e81924c5bff2178fa3b9179
                object.recieveShadow = true
                object.traverse( ( node ) ->
                    if node instanceof THREE.Mesh

                        #
<<<<<<< HEAD
                        #console.log('dae')
                        
                        node.geometry.computeFaceNormals()
                        #node.geometry.computeVertexNormals()
                        node.geometry.computeBoundingBox()

                        ##node.geometry.reverse(computeFaceNormals());
                        ##node.geometry.reverse(computeVertexNormals());
                        
                        node.center = node.geometry.boundingBox.min
                        ###
                        offset  = node.geometry.boundingBox.min
                        offset.add(node.geometry.boundingBox.max)
                        offset.divideScalar(2)
                        node.geometry.applyMatrix( new THREE.Matrix4().makeTranslation( - offset.x, - offset.y, - offset.z ) )
                        node.position.set( offset.x, offset.y, offset.z )
                        node.myid = "hello"+cnt
                        node.center = offset
                        #node.updateMatrix()
                        ###

                        #if cnt<10
                            #console.log(node.geometry.boundingBox.center().x)
                        cnt++

                        if cnt==8
                            console.log(node)
                        #node.receiveShadow = true
                        #s = 1
                        #node.scale.set(s,s,s)
                        #node.material = MaterialFactory.getMeshBasicMaterial()
                        #node.material = MaterialFactory.getMeshNormalMaterial()
                        node.material = lambertMaterial
                )
                s = 1
                object.scale.set(s,s,s)
                console.log("daecount "+cnt)
                Stage3d.add(object)

                @construction = object

            )

        StageRenderer.onUpdate.add(@update)

        return

    update:(dt)->
        if @construction!=undefined

            @construction.rotation.y+=dt/5000
            cnt=0

            if !false
                @construction.traverse( ( node ) ->
                    if node instanceof THREE.Mesh
                        #dist = node.position.distanceTo(new THREE.Vector3( 0, 100*Stage3d.umouse.y, 0 ))
                        #node.geometry.computeBoundingBox()
                        thresh = 200
                        dist = node.center.distanceTo(new THREE.Vector3( 0, 100*Stage3d.umouse.y, 0 ))
                        if dist<thresh
                            node.position.x*=dist/thresh*Stage3d.umouse.x*100
                            node.position.z*=dist/thresh*Stage3d.umouse.y*100
                        else
                            node.position.x=0
                            node.position.z=0
                        #if cnt++<10
                            #console.log(dist+node.myid)

                )
        return

    @testModule()
=======
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
>>>>>>> 49c0ca6dd7e303561e81924c5bff2178fa3b9179

module.exports = Main