MaterialFactory = require('factories/MaterialFactory')
TextureFactory  = require('factories/TextureFactory')

class RockController
	config = null
	rockMaterial = null
	coreMaterial = null
	rockParticle = null

	constructor:()->

		console.log('RockController.constructor')
		
		config = {
			distThreshold 		: 950,
			# = square distance of click for rock crack
			rockParticleCnt		: 100000,
			#maximum particle count
			terrainLevel		: -600,
			#average terrain level, TODO: make this little more accurate by doing raycaster
			dropPercentage		: 0.6,
			#how much cracks will be dropping, other than orbiting
			gravity				: 0.0045,
			#gravity, accerleration for dropping pieces
			crackOrbitScaler	: 2.5,
			#crack orbit speed scaler
			crackOrbitRadius	: 0.65,
			#crack orbiting parameter
			velocityLimit		: 0.25,
			#maximum speed on every axis
			tickThreshold		: 210,
			#first 2s let the collision only dropping cracks move away from monolite
			minMoveThreshold	: 0.5,
			#minimum move threshold for physics detection, if smaller than this, set the crack be static
			particleDroprate	: 20 }

		return

	@init:(options)->
		if(@isInit)
			return

        colorMap = TextureFactory.loadTexture("RockDiffuse", "Diffuse", options.diffuse.path, options.diffuse.format )
		normalMap = TextureFactory.loadTexture("RockNormal", "Normal", options.normal.path, options.normal.format )
        textureCube = TextureFactory.loadTexture("RockEnvCube", "Cube", options.cube.path, options.cube.format )
        	
		if options.material == 'simple'
			rockMaterial = MaterialFactory.getMaterial("Bump")

        	MaterialFactory.setGlobalMaterialUniform("Bump", "uBaseColorMap", colorMap)
        	MaterialFactory.setGlobalMaterialUniform("Bump", "uNormalMap", normalMap)
        	MaterialFactory.setGlobalMaterialUniform("Bump", "uCubeMapTex", textureCube)
    
        	MaterialFactory.setGlobalMaterialUniform("Bump", "uWorldTop", 100.0 )
        	MaterialFactory.setGlobalMaterialUniform("Bump", "uExposure", 6.3375)
        	MaterialFactory.setGlobalMaterialUniform("Bump", "uGamma",    2.2   )
        	MaterialFactory.setGlobalMaterialUniform("Bump", "uSunPosition", new THREE.Vector3(0,70,0))
        	MaterialFactory.setGlobalMaterialUniform("Bump", "uBaseColor",   new THREE.Color( 0x1d1b1c ))
        
        	coreMaterial = MaterialFactory.getMaterial("Diffuse")

        else
        	rockMaterial = MaterialFactory.getMaterial("PBR_Bump")

        	MaterialFactory.setGlobalMaterialUniform("PBR_Bump", "uBaseColorMap", colorMap)
        	MaterialFactory.setGlobalMaterialUniform("PBR_Bump", "uNormalMap",    normalMap)
        	MaterialFactory.setGlobalMaterialUniform("PBR_Bump", "uCubeMapTex",   textureCube)
    
			MaterialFactory.setGlobalMaterialUniform("PBR_Bump", "uRoughness", 0.8);	
			MaterialFactory.setGlobalMaterialUniform("PBR_Bump", "uRoughness4", 0.8*0.8*0.8*0.8);	
			MaterialFactory.setGlobalMaterialUniform("PBR_Bump", "uMetallic", 0.3);	
			MaterialFactory.setGlobalMaterialUniform("PBR_Bump", "uSpecular", 0.3);	
			MaterialFactory.setGlobalMaterialUniform("PBR_Bump", "uDetails",  1.0);	
			MaterialFactory.setGlobalMaterialUniform("PBR_Bump", "uExposure", 6.3375)
        	MaterialFactory.setGlobalMaterialUniform("PBR_Bump", "uGamma",    2.2   )
        	MaterialFactory.setGlobalMaterialUniform("PBR_Bump", "uBaseColor",   new THREE.Color( 0x1d1b1c ))
      	
      		coreMaterial = MaterialFactory.getMaterial("PBR_Diffuse")

