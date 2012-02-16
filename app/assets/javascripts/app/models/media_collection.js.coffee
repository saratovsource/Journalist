class App.MediaCollection extends Spine.Model
	@configure 'MediaCollection', 'title', 'slug', 'description', 'fullpath'
	@extend Spine.Model.Ajax

	@url: "/godmode/mediabank/media_collections"