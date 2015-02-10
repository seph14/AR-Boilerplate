class MaterialFactory 
	globalMaterial = {}
	
	constructor:()->

		console.log('MaterialFactory.constructor')
		dispTexture = THREE.ImageUtils.loadTexture( "srtm_512x256_norm2.png" );
    
		shader = THREE.ShaderLib[ "normalmap" ];
		uniforms = THREE.UniformsUtils.clone( shader.uniforms );

		uniforms[ "tNormal" ].value = THREE.ImageUtils.loadTexture( "flat.png" );

		@material = new THREE.ShaderMaterial( {
	            uniforms: uniforms,
	            vertexShader: shader.vertexShader,
	            fragmentShader: shader.fragmentShader,
	            lights: true} )

		return

	@init:()->
		@isInit = true
	# @init()

	@getMaterial: (name, useGlobal) ->
		if name == undefined or name == null 
			console.log "Name of material is undefined, use createMaterialWithShader instead"
			return null
		if useGlobal == undefined or useGlobal == null
			useGlobal = true
			#default to use global materials
		if name == "PBR_Diffuse" 
			if globalMaterial["PBR_Diffuse"] == undefined
				shader 	 = THREE.ShaderPBR[ "PBR_Env" ]
				uniforms = THREE.UniformsUtils.clone( shader.uniforms )
				mat = new THREE.ShaderMaterial( {  
					fragmentShader: shader.fragmentShader, 
					vertexShader: 	shader.vertexShader,
					uniforms: 		uniforms, 
					lights: 		false, 
					fog: 			true,
					morphTargets:   false,
					morphNormals:   false } )
				if useGlobal
					globalMaterial["PBR_Diffuse"] = mat
				return mat
			else return globalMaterial["PBR_Diffuse"]
		else if name == "PBR_Bump"
			if globalMaterial["PBR_Bump"] == undefined
				shader 	 = THREE.ShaderPBR[ "PBR_Env_Bump" ];
				uniforms = THREE.UniformsUtils.clone( shader.uniforms );
				mat = new THREE.ShaderMaterial( {  
					fragmentShader: shader.fragmentShader, 
					vertexShader: 	shader.vertexShader,
					uniforms: 		uniforms, 
					lights: 		false, 
					fog: 			true,
					morphTargets:   false,
					morphNormals:   false } )
				if useGlobal
					globalMaterial["PBR_Bump"] = mat
				return mat;
			else return globalMaterial["PBR_Bump"];
		else if name == "Bump"
			if globalMaterial["Bump"] == undefined
				shader 	 = THREE.ShaderShade[ "Env_Bump" ];
				uniforms = THREE.UniformsUtils.clone( shader.uniforms );
				mat = new THREE.ShaderMaterial( {  
					fragmentShader: shader.fragmentShader, 
					vertexShader: 	shader.vertexShader,
					uniforms: 		uniforms, 
					lights: 		false, 
					fog: 			true,
					morphTargets:   false,
					morphNormals:   false } )
				if useGlobal
					globalMaterial["Bump"] = mat
				return mat;
			else return globalMaterial["Bump"];
		else if name == "Diffuse"
			if globalMaterial["Diffuse"] == undefined
				shader 	 = THREE.ShaderShade[ "Env" ];
				uniforms = THREE.UniformsUtils.clone( shader.uniforms );
				mat = new THREE.ShaderMaterial( {  
					fragmentShader: shader.fragmentShader, 
					vertexShader: 	shader.vertexShader,
					uniforms: 		uniforms, 
					lights: 		false, 
					fog: 			true,
					morphTargets:   false,
					morphNormals:   false } )
				if useGlobal
					globalMaterial["Diffuse"] = mat
				return mat
			else return globalMaterial["Diffuse"]
		else if name == "Grid"
			if globalMaterial["Grid"] == undefined
				mat = new THREE.MeshBasicMaterial({color:0xffffff,wireframe:true,transparent: true, opacity: .01, blending: THREE.AdditiveBlending})
				if useGlobal
					globalMaterial["Grid"] = mat
				return mat
			else return globalMaterial["Grid"]
		else if name == "Basic"
			if globalMaterial["Basic"] == undefined
				mat = new THREE.MeshBasicMaterial({color:0x111111,wireframe:false,transparent: true, opacity: .75, blending: THREE.AdditiveBlending})
				if useGlobal
					globalMaterial["Basic"] = mat
				return mat
			else return globalMaterial["Basic"]
		else if name == "Normal"
			if globalMaterial["Normal"] == undefined
				mat = THREE.MeshNormalMaterial({wireframe:false})
				if useGlobal
					globalMaterial["Normal"] = mat
				return mat
			else return globalMaterial["Normal"]
		else if name == "Lambert"
			if globalMaterial["Lambert"] == undefined
				mat = new THREE.MeshLambertMaterial({
					color: 0x333333,
					emissive: 0x000000,
					wireframe: false,
					transparent: false,
					opacity: .6,
					#side: THREE.BackSide,
					map: THREE.ImageUtils.loadTexture('models/Sennheiser_Stone_LowPoly_UVed_COLOR.png'),
					#normalmap: THREE.ImageUtils.loadTexture('models/Sennheiser_Stone_LowPoly_UVed_NORMALS.png'),
				})
				if useGlobal
					globalMaterial["Lambert"] = mat
				return mat
			else return globalMaterial["Lambert"]
		else if name == "Depth"
			#this is for cloud pass
			if globalMaterial["Depth"] == undefined
				mat = new THREE.MeshDepthMaterial()
				if useGlobal
					globalMaterial["Depth"] = mat
				return mat
			else return globalMaterial["Depth"]
		return null

	@setGlobalMaterialUniform: (matName, uniformName, value) ->
		if globalMaterial[matName] == undefined
			return false
		property = globalMaterial[matName].uniforms[uniformName]
		if property == undefined
			return false
		property.value = value
		return true

	@createMaterialWithShader: (matName, shader) -> 
		if globalMaterial[matName] != undefined
			console.log("Material " + matName + " already exist")
			return globalMaterial[matName]
		if shader == undefined or shader == null 
			console.log "Shader does not exist"
			return null
		uniforms = THREE.UniformsUtils.clone( shader.uniforms );
		mat = new THREE.ShaderMaterial( {  
			fragmentShader: shader.fragmentShader, 
			vertexShader: 	shader.vertexShader,
			uniforms: 		uniforms, 
			fog: 			true } )
		globalMaterial[matName] = mat
		return mat

	@getGridMaterial: () ->
		return new THREE.MeshBasicMaterial({color:0xffffff,wireframe:true,transparent: true, opacity: .01, blending: THREE.AdditiveBlending})

	@getTestMaterial: () ->
		return @material

	@getMeshBasicMaterial: () ->
		return new THREE.MeshBasicMaterial({color:0x111111,wireframe:false,transparent: true, opacity: .75, blending: THREE.AdditiveBlending})

	@getMeshNormalMaterial: () ->
		return new THREE.MeshNormalMaterial({wireframe:false})

	@getMeshLambertMaterial: () ->
		#return new THREE.MeshNormalMaterial({wireframe:false})

		return new THREE.MeshLambertMaterial({
			color: 0x333333,
			emissive: 0x000000,
			wireframe: false,
			transparent: false,
			opacity: .6,
			#side: THREE.BackSide,
			map: THREE.ImageUtils.loadTexture('models/Sennheiser_Stone_LowPoly_UVed_COLOR.png'),
			normalmap: THREE.ImageUtils.loadTexture('models/Sennheiser_Stone_LowPoly_UVed_NORMALS.png'),
			})

	@getMeshDirk01Material: () ->
		#return new THREE.MeshNormalMaterial({wireframe:false})

		return new THREE.MeshLambertMaterial({
			color: 0x333333,
			emissive: 0x000000,
			wireframe: false,
			transparent: false,
			opacity: .6,
			#side: THREE.BackSide,
			map: THREE.ImageUtils.loadTexture('models/dirk/test3.png'),
			normalmap: THREE.ImageUtils.loadTexture('models/Sennheiser_Stone_LowPoly_UVed_NORMALS.png'),
			})

	@createSkybox: (suff) ->
		materials = [
		    new THREE.MeshBasicMaterial( { fog: false, map: THREE.ImageUtils.loadTexture(suff+'/px.jpg') } )
			new THREE.MeshBasicMaterial( { fog: false, map: THREE.ImageUtils.loadTexture(suff+'/nx.jpg') } )
			new THREE.MeshBasicMaterial( { fog: false, map: THREE.ImageUtils.loadTexture(suff+'/py.jpg') } )
			new THREE.MeshBasicMaterial( { fog: false, map: THREE.ImageUtils.loadTexture(suff+'/ny.jpg') } )
			new THREE.MeshBasicMaterial( { fog: false, map: THREE.ImageUtils.loadTexture(suff+'/pz.jpg') } )
			new THREE.MeshBasicMaterial( { fog: false, map: THREE.ImageUtils.loadTexture(suff+'/nz.jpg') } )
		]
		skybox = new THREE.Mesh(
		    new THREE.BoxGeometry(10000, 10000, 10000),
		    new THREE.MeshFaceMaterial(materials)
		)
		skybox.scale.x = - 1;
		return skybox

module.exports = MaterialFactory