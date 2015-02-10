Stage3d         = require('core/Stage3d')
Module          = require('modules/Module')
MaterialFactory = require('factories/MaterialFactory')
TextureFactory  = require('factories/TextureFactory')
StageRenderer   = require('core/StageRenderer')

class Main extends Module

    #@construction = null
    @mesh = null

    totalTime = 0
    lightAlias = null
    pointLight=null
    directLight=null

    constructor:()->
        super()
        console.log('002 LargeThing')

        geometry = new THREE.BoxGeometry(70,70,70)
        material = new THREE.MeshBasicMaterial({color:0xFF0000,wireframe:true,transparent: true,opacity:0.2, blending: THREE.AdditiveBlending})
        @mesh = new THREE.Mesh(geometry,material)
        Stage3d.add(@mesh)

        # --- Lights
        #directLight = new THREE.DirectionalLight( 0xffffff );
        #Stage3d.add( directLight );

        pointLight = new THREE.PointLight( 0xffffff, 4 );
        Stage3d.add( pointLight );        
        lightAlias = new THREE.Mesh( new THREE.SphereGeometry( 2, 4, 4 ), new THREE.MeshBasicMaterial( { color:0x333333 } ) );
        Stage3d.add(lightAlias);


        #shader = THREE.ShaderLib["dashed"];
        shader = THREE.ShaderLib["phong"];
        console.log(shader);
        uniforms = THREE.UniformsUtils.clone( shader.uniforms );

        #uniforms[ "tDiffuse" ].texture = THREE.ImageUtils.loadTexture( "models/Sennheiser_Stone_LowPoly_UVed_COLOR.png" );
        uniforms[ "normalMap" ].value = THREE.ImageUtils.loadTexture( "models/Sennheiser_Stone_LowPoly_UVed_NORMALS.png" );

        matPhong = new THREE.ShaderMaterial( {
            uniforms: uniforms,
            vertexShader: shader.vertexShader,
            fragmentShader: shader.fragmentShader,
            lights: true} )

        matReflect = MaterialFactory.getMaterial("Bump", true)


        colorMap = TextureFactory.loadTexture("RockDiffuse", "Diffuse", "models/Sennheiser_Stone_LowPoly_UVed_COLOR", ".png" )
        MaterialFactory.setGlobalMaterialUniform("Bump", "uBaseColorMap", colorMap  )

        noarmalMap = TextureFactory.loadTexture("RockNormal", "Normal", "models/Sennheiser_Stone_LowPoly_UVed_NORMALS", ".png" )
        MaterialFactory.setGlobalMaterialUniform("Bump", "uNormalMap", noarmalMap)

        textureCube = TextureFactory.loadTexture("EnvCube", "Cube", "textures/reflect/", ".jpg" )
        MaterialFactory.setGlobalMaterialUniform("Bump", "uCubeMapTex", textureCube)
    
        MaterialFactory.setGlobalMaterialUniform("Bump", "uWorldTop", 100.0 )
        MaterialFactory.setGlobalMaterialUniform("Bump", "uExposure", 6.3375)
        MaterialFactory.setGlobalMaterialUniform("Bump", "uGamma",    2.2   )
        MaterialFactory.setGlobalMaterialUniform("Bump", "uSunPosition", new THREE.Vector3(0,70,0))
        MaterialFactory.setGlobalMaterialUniform("Bump", "uBaseColor",   new THREE.Color( 0x1d1b1c ))

        console.log matReflect

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
                        #node.material = MaterialFactory.getMeshNormalMaterial()
                        node.material = MaterialFactory.getMeshLambertMaterial()
                        #node.material = matPhong
                        s = 10
                        node.scale.set(s,s,s)
                        node.position.y = 2000
                        #console.log(node.geometry.vertices)
                        #node.material = MaterialFactory.getMeshNormalMaterial()
                )

                Stage3d.add(object)

                if !true

                    cnt = 5
                    for i in [0...cnt] by 1
                        clone = object.clone()
                        clone.position.x=Math.sin(Math.PI*2/cnt*i)*5800
                        clone.position.z=Math.cos(Math.PI*2/cnt*i)*5800
                        clone.position.y=-3500
                        Stage3d.add(clone)
                

            )

        if true

            url = 'models/Sennheiser_Stone_LowPoly_UVed.OBJ'
            (new THREE.OBJLoader()).load(url, ( object ) ->
                object.recieveShadow = true
                object.traverse( ( node ) ->
                    if node instanceof THREE.Mesh

                        #
                        node.geometry.computeFaceNormals()
                        node.geometry.computeVertexNormals()
                        node.geometry.computeBoundingBox()

                        node.receiveShadow = true
                        #node.material = MaterialFactory.getMeshNormalMaterial()
                        #node.material = MaterialFactory.getMeshLambertMaterial()
                        #node.material = matReflect
                        node.material = MaterialFactory.getMeshDirk01Material()
                        #node.material = matPhong
                        node.material = matReflect
                        node.scale.set(100,100,100)
                        console.log(node.geometry.getAttribute('position').length)
                        console.log(node.geometry.getAttribute('position')[0])
                        console.log(node.geometry.getAttribute('position')[1])
                        console.log(node.geometry.getAttribute('position')[2])
                        #console.log(node.geometry.children[0].geometry.vertices)
                        #node.material = MaterialFactory.getMeshNormalMaterial()
                )

                object.position.x = 200
                Stage3d.add(object)

                #@construction = object

                if true

                    cnt = 7
                    for i in [0...cnt] by 1
                        clone = object.clone()
                        clone.position.x=Math.sin(Math.PI*2/cnt*i)*800
                        clone.position.z=Math.cos(Math.PI*2/cnt*i)*800
                        Stage3d.add(clone)

                

            )

        StageRenderer.onUpdate.add(@update)

        return

    update:(dt)->
        #console.log(@construction)
        
        ###
        if @mesh!=undefined
            @mesh.position.z = (Math.random()-.5)*5000
            @mesh.position.x = (Math.random()-.5)*5000
        ###
        totalTime+=dt/1000

        speed = .4
        rad = 600

        if lightAlias!=undefined
            lightAlias.position.x = rad * Math.cos( totalTime*speed );
            lightAlias.position.y = rad * Math.sin( totalTime*speed );
            lightAlias.position.z = rad * Math.sin( totalTime*speed );
        
        if pointLight!=undefined
            pointLight.position.x = rad * Math.cos( totalTime*speed );
            pointLight.position.y = rad * Math.cos( totalTime*speed );
            pointLight.position.z = rad * Math.sin( totalTime*speed );
            #directLight.intensity = (Stage3d.umouse.y+.5)*100

        #console.log(dt+" "+pointLight.intensity)
        
        #if @construction!=undefined
            #@construction.rotation.y+=dt/1000
        return

    @testModule()

module.exports = Main