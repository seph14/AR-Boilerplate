class MaterialFactory 

	constructor:()->
		return

	@init:()->
		@isInit = true
	# @init()

	@getMeshBasicMaterial: () ->
		return new THREE.MeshBasicMaterial({color:0x334455,wireframe:true})

module.exports = MaterialFactory