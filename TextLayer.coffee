class module.exports extends Layer
		
	constructor: (options={}) ->
		@doAutoSize = false
		@doAutoSizeHeight = false
		options.backgroundColor ?= if options.setup then "hsla(60, 90%, 47%, .4)" else "transparent"
		options.color ?= "red"
		options.lineHeight ?= 1.25
		options.fontFamily ?= "Helvetica"
		options.fontSize ?= 20
		options.text ?= "Use layer.text to add text"
		super options
		@style.whiteSpace = "pre-line" # allow \n in .text
		
	setStyle: (property, value, pxSuffix = false) ->
		@style[property] = if pxSuffix then value+"px" else value
		@emit("change:#{property}", value)
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
			borderWidth: @style["border-width"]
			letterSpacing: @style["letter-spacing"]
			fontFamily: @style["font-family"]
			fontStyle: @style["font-style"]
			fontVariant: @style["font-variant"]
		constraints = {}
		if @doAutoSizeHeight then constraints.width = @width
		size = Utils.textSize @text, sizeAffectingStyles, constraints
		if @style.textAlign is "right"
			@width = size.width
			@x = @x-@width
		else
			@width = size.width
		@height = size.height

	@define "autoSize",
		get: -> @doAutoSize
		set: (value) -> 
			@doAutoSize = value
			if @doAutoSize then @calcSize()
	@define "autoSizeHeight",
		set: (value) -> 
			@doAutoSize = value
			@doAutoSizeHeight = value
			if @doAutoSize then @calcSize()
	@define "contentEditable",
		set: (boolean) ->
			@_element.contentEditable = boolean
			@ignoreEvents = !boolean
			@on "input", -> @calcSize() if @doAutoSize
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
	@define "fontStyle", 
		get: -> @style.fontStyle
		set: (value) -> @setStyle("fontStyle", value)
	@define "fontVariant", 
		get: -> @style.fontVariant
		set: (value) -> @setStyle("fontVariant", value)
	@define "padding",
		set: (value) -> 
			@setStyle("paddingTop", value, true)
			@setStyle("paddingRight", value, true)
			@setStyle("paddingBottom", value, true)
			@setStyle("paddingLeft", value, true)
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
	@define "textTransform", 
		get: -> @style.textTransform 
		set: (value) -> @setStyle("textTransform", value)
	@define "letterSpacing", 
		get: -> @style.letterSpacing.replace("px","")
		set: (value) -> @setStyle("letterSpacing", value, true)
	@define "length", 
		get: -> @text.length
