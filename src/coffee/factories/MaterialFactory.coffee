class MaterialFactory 

	constructor:()->
		return

	@init:()->
		@isInit = true
	# @init()

	@getGridMaterial: () ->
		return new THREE.MeshBasicMaterial({color:0xffffff,wireframe:true,transparent: true, opacity: .01, blending: THREE.AdditiveBlending})

	@getMeshBasicMaterial: () ->
		return new THREE.MeshBasicMaterial({color:0x111111,wireframe:true})

	@getMeshNormalMaterial: () ->
		return new THREE.MeshNormalMaterial({wireframe:false})

	@createSkybox: (suff) ->
		materials = [
		    new THREE.MeshBasicMaterial( { map: THREE.ImageUtils.loadTexture(suff+'/px.jpg') } )
			new THREE.MeshBasicMaterial( { map: THREE.ImageUtils.loadTexture(suff+'/nx.jpg') } )
			new THREE.MeshBasicMaterial( { map: THREE.ImageUtils.loadTexture(suff+'/py.jpg') } )
			new THREE.MeshBasicMaterial( { map: THREE.ImageUtils.loadTexture(suff+'/ny.jpg') } )
			new THREE.MeshBasicMaterial( { map: THREE.ImageUtils.loadTexture(suff+'/pz.jpg') } )
			new THREE.MeshBasicMaterial( { map: THREE.ImageUtils.loadTexture(suff+'/nz.jpg') } )
		]
		skybox = new THREE.Mesh(
		    new THREE.BoxGeometry(10000, 10000, 10000),
		    new THREE.MeshFaceMaterial(materials)
		)
		skybox.scale.x = - 1;
		return skybox

module.exports = MaterialFactory