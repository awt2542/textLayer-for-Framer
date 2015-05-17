class module.exports extends Layer
		
	constructor: (options={}) ->
		@doAutoSize = false
		options.backgroundColor ?= if options.setup then "hsla(60, 90%, 47%, .4)" else "transparent"
		options.color ?= "red"
		options.lineHeight ?= 1.25
		options.fontFamily ?= "Helvetica"
		options.fontSize ?= 20
		options.text ?= "Use layer.text to add text"
		super options
		
	setStyle: (property, value, pxSuffix = false) ->
		@style[property] = if pxSuffix then value+"px" else value
		if @doAutoSize then @calcSize()
		
	calcSize: ->
		sizeAffectingStyles =
			lineHeight: @style["line-height"]
			fontSize: @style["font-size"]
			fontWeight: @style["font-weight"]
			paddingTop: @style["padding-top"]
			paddingRight: @style["padding-right"]
			paddingBottom: @style["padding-bottom"]
			paddingLeft: @style["padding-left"]
			textTransform: @style["text-transform"]
		size = Utils.textSize @text, sizeAffectingStyles
		@width = size.width
		@height = size.height

	@define "autoSize",
		get: -> @doAutoSize
		set: (value) -> 
			@doAutoSize = value
			if @doAutoSize then @calcSize()
	@define "contentEditable",
		set: (boolean) ->
			@_element.contentEditable = boolean
			@on Events.Click, -> return # make clicking text work in Framer Studio
	@define "text",
		get: -> @_element.textContent
		set: (value) ->
			@_element.textContent = value
			@emit("change:text", value)
			if @doAutoSize then @calcSize()
	@define "fontFamily", 
		get: -> @style.fontFamily
		set: (value) -> @setStyle("fontFamily", value)
	@define "fontSize", 
		get: -> @style.fontSize.replace("px","")
		set: (value) -> @setStyle("fontSize", value, true)
	@define "lineHeight", 
		get: -> @style.lineHeight 
		set: (value) -> @setStyle("lineHeight", value)
	@define "fontWeight", 
		get: -> @style.fontWeight 
		set: (value) -> @setStyle("fontWeight", value)
	@define "paddingTop", 
		get: -> @style.paddingTop.replace("px","")
		set: (value) -> @setStyle("paddingTop", value, true)
	@define "paddingRight", 
		get: -> @style.paddingRight.replace("px","")
		set: (value) -> @setStyle("paddingRight", value, true)
	@define "paddingBottom", 
		get: -> @style.paddingBottom.replace("px","")
		set: (value) -> @setStyle("paddingBottom", value, true)
	@define "paddingLeft",
		get: -> @style.paddingLeft.replace("px","")
		set: (value) -> @setStyle("paddingLeft", value, true)
	@define "textAlign",
		set: (value) -> @setStyle("textAlign", value)
	@define "length", 
		get: -> @text.length
	toUpperCase: -> @setStyle("text-transform", value)
	toLowerCase: -> @setStyle("text-transform", value)
	
	
