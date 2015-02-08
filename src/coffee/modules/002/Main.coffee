Stage3d         = require('core/Stage3d')
Module          = require('modules/Module')
MaterialFactory = require('factories/MaterialFactory')
StageRenderer   = require('core/StageRenderer')

class Main extends Module

    @construction = null
    @mesh = null

    totalTime = 0
    light = null
    pointLight=null

    constructor:()->
        super()
        console.log('002 LargeThing')


        geometry = new THREE.BoxGeometry(70,70,70)
        material = new THREE.MeshBasicMaterial({color:0xFF0000,wireframe:true,transparent: true,opacity:0.2, blending: THREE.AdditiveBlending})
        @mesh = new THREE.Mesh(geometry,material)
        Stage3d.add(@mesh)



        # --- Lights
            
        pointLight = new THREE.PointLight( 0x333333 );
        Stage3d.add( pointLight );

        
        sphere1             = new THREE.SphereGeometry( 8, 4, 4 );
        light               = new THREE.Mesh( sphere1, new THREE.MeshBasicMaterial( { color:0x00ffff, wireframe: true } ) );
        light.position      = pointLight.position;
        Stage3d.add(light);

        @pointLight = pointLight
        @light = light

        #shader = THREE.ShaderLib["dashed"];
        shader = THREE.ShaderLib["phong"];
        console.log(shader)
        uniforms = THREE.UniformsUtils.clone( shader.uniforms );

        #uniforms[ "tDiffuse" ].texture = THREE.ImageUtils.loadTexture( "models/Sennheiser_Stone_LowPoly_UVed_COLOR.png" );
        uniforms[ "normalMap" ].value = THREE.ImageUtils.loadTexture( "models/Sennheiser_Stone_LowPoly_UVed_NORMALS.png" );

        matPhong = new THREE.ShaderMaterial( {
            uniforms: uniforms,
            vertexShader: shader.vertexShader,
            fragmentShader: shader.fragmentShader,
            lights: true} )

        if true

            #url = 'models/terrainA.obj'
            url = 'models/Voronoitest18_LowpolyBake.obj'
            #url = 'models/Sennheiser_Stone_LowPoly_UVed.OBJ'

            
            (new THREE.OBJLoader()).load(url, ( object ) ->
                object.recieveShadow = true
                object.traverse( ( node ) ->
                    if node instanceof THREE.Mesh

                        #
                        node.geometry.computeFaceNormals()
                        node.geometry.computeVertexNormals()
                        node.receiveShadow = true
                        node.material = MaterialFactory.getMeshNormalMaterial()
                        #node.material = matPhong
                        #node.scale.set(100,100,100)
                        #console.log(node.geometry)
                        #node.material = MaterialFactory.getMeshNormalMaterial()
                )

                Stage3d.add(object)

                @construction = object

                if false
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


            url = 'models/Sennheiser_Stone_LowPoly_UVed.OBJ'
            (new THREE.OBJLoader()).load(url, ( object ) ->
                object.recieveShadow = true
                object.traverse( ( node ) ->
                    if node instanceof THREE.Mesh

                        #
                        node.geometry.computeFaceNormals()
                        node.geometry.computeVertexNormals()
                        node.receiveShadow = true
                        node.material = MaterialFactory.getMeshNormalMaterial()
                        node.material = matPhong
                        node.scale.set(100,100,100)
                        #console.log(node.geometry)
                        #node.material = MaterialFactory.getMeshNormalMaterial()
                )

                Stage3d.add(object)

                @construction = object

                if !false
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

        StageRenderer.onUpdate.add(@update)

        return

    update:(dt)->
        #console.log(@construction)
        
        if @mesh!=undefined
            @mesh.position.z = (Math.random()-.5)*5000
            @mesh.position.x = (Math.random()-.5)*5000

        totalTime+=dt/1000

        if light!=undefined
            light.position.x = 2000 * Math.cos( totalTime*.2 );
            light.position.z = 2000 * Math.sin( totalTime*.2 );
        
        if pointLight!=undefined
            pointLight.position.x = 200 * Math.cos( totalTime*.2 );
            pointLight.position.z = 200 * Math.sin( totalTime*.2 );

        #console.log(dt+" "+pointLight)
        
        #if @construction!=undefined
            #@construction.rotation.y+=dt/1000
        return

    @testModule()

module.exports = Main