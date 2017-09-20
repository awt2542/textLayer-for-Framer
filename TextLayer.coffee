# TODO: Rename this class so there aren't namespace conflicts.
class TextLayer extends Layer
		
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
		@style.outline = "none" # no border when selected
		
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

convertToTextLayer = (layer, debug) ->

	# Create a text layer with all the basic properties.
	t = new TextLayer
		name: layer.name
		frame: layer.frame
		parent: layer.parent
		text: layer._info.metadata.string

	# Object for style props.
	styleObj = {}
	
	# Get CSS from metadata.
	css = layer._info.metadata.css

	# Go through each rule
	css.forEach (rule) ->

		# Ditch the dumb layer name.
		return if _.includes rule, '/*'
		
		# Split the key and value out
		arr = rule.split(': ')
		
		#Format the key and value properly
		prop = _.camelCase(arr[0])
		value = arr[1].replace(';','')
		
		#Convert to numbers for numeric properties
		if ["fontSize","letterSpacing","lineHeight"].indexOf(prop) > -1
			value = parseInt(value) 

		# Set the key and value in styleObj
		styleObj[prop] = value
		
	# Set the line-height as a proportion instead of pixel value.
	if styleObj.hasOwnProperty("lineHeight")
		styleObj["lineHeight"] =  styleObj.lineHeight / styleObj.fontSize
	else
		styleObj["lineHeight"] = 1.3
 		# TODO: Find a way to properly set text line-height for auto values in Sketch.
 		# Currently auto line-heights vary by font, so this is just setting a fallback arbitrarily.
	
	
	# Set the properties for every key in styleObj
	for key, val of styleObj
		t[key] = val

	# Offsets to compensate for Sketch's padding.
	t.y -= (t.fontSize / t.lineHeight) / (4 - t.lineHeight)
	t.x -= t.fontSize * 0.07
	t.width += t.fontSize * 0.5

	# Set up debug: if true, it doesn't destroy the layer so you can
	# manually position line-height and stuff.  Helpful.
	if debug then layer.opacity = .5 else layer.destroy()
	
	return t

Layer::convertToTextLayer = (debug) -> convertToTextLayer(@, debug)

convertTextLayers = (obj, debug) ->
	for prop,layer of obj
		if layer._info.kind is "text"
			obj[prop] = convertToTextLayer(layer, debug)


# Backwards compability. Replaced by convertToTextLayer()
Layer::frameAsTextLayer = (properties) ->
    t = new TextLayer
    t.frame = @frame
    t.superLayer = @superLayer
    _.extend t,properties
    @destroy()
    t

exports.TextLayer = TextLayer
exports.convertTextLayers = convertTextLayers
