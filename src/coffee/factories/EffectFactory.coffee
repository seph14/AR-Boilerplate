class EffectFactory 
	globalEffect = {}
	
	constructor:()->
		#TODO: add pre-defined value for clear syntax loading of textures
		console.log('EffectFactory.constructor')
		return

	@init:()->
		@isInit = true
	# @init()

	@loadTexture: (name, type, path, format) ->
		if globalTexture[name] != undefined
			console.log("Texture " + name + " already exist.")
			return globalTexture[name]
		#if type == TextureFormat.Diffuse or type == TextureFormat.Normal
		#cant get enum to work right in classes... need to fix this later
		if type == "Diffuse" or type == "Normal"
			tex = THREE.ImageUtils.loadTexture(path + format)
			globalTexture[name] = { type: type, map: tex }
		#if type == TextureFormat.Cube
		if type == "Cube"
			px = (path + 'px' + format)
			py = (path + 'py' + format)
			pz = (path + 'pz' + format)
			nx = (path + 'nx' + format)
			ny = (path + 'ny' + format)
			nz = (path + 'nz' + format)
			textureCube = THREE.ImageUtils.loadTextureCube( [px,nx,py,ny,pz,nz] )
			globalTexture[name] = { type: type, map: textureCube }
		return globalTexture[name].map

	@getTexture: (name) ->
		return globalTexture[name].map

module.exports = EffectFactory