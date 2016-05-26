# TextLayer for Framer.js


Framer.js module that simplifies the process of adding text to your prototypes.

NOTE: Latest version needs curly brackets when importing (see install instructions)

![TextLayer](http://cl.ly/image/3q2m1q1w0x2w/TextLayer.png)

## Installation

1. Download the TextLayer.coffee file
2. Create a framer project and drop TextLayer.coffee inside the /modules folder
3. Add `{TextLayer} = require 'TextLayer'` at the top of your document (case-sensitive).


More info about modules in Framer: [FramerJS Docs - Modules](http://framerjs.com/docs/#modules)


## Examples

### Basic usage

	t = new TextLayer
		text: "The quick brown fox jumps over the lazy dog"
		color: "#aaa"
		textAlign: "center"
		fontSize: 14
		width: 220
		height: 40
		fontFamily: "Georgia"
		
	t.center()

### Convert imported layers to TextLayers

Make sure the text layer in Sketch is inside a group. There can be no other layers inside that group.

	title = sketch.title.convertToTextLayer()
	title.text = "Custom text"

### AutoSize based on text length and styling

	t = new TextLayer
		autoSize: true
		text: "This text is longer than 100px, but that's ok"	

### Positioning and layout using the .setup guide
	
	t = new TextLayer
		text: "This is a headline"
		setup: true
		autoSize: true
		paddingRight: 20
		paddingLeft: 20
		
### Make text editable by user (input fields)

	t = new TextLayer 
		contentEditable: true
		width: 200
			
### Create a quick list of text

	for fruit, i in ["Apple", "Pear", "Kiwi", "Banana"]
		t = new TextLayer
			text: fruit
			y: i*30
		

## Properties

**.text** (string) - your text content

**.fontFamily** (string) - font. eg. "Arial", "Lato"

**.fontSize** (number) - size of font

**.color** (string) - color of text

**.lineHeight** (number) - line height (default is 1.25)

**.letterSpacing** (number) - letter spacing (default is 0)

**.fontWeight** (string) - weight of font

**.fontStyle** (string) - styling of font eg. "normal", "italic", "oblique"

**.fontVariant** (string) - font variant

**.letterSpacing** (number) - letter spacing

**.padding** (number) - padding on all sides

**.paddingTop** (number) - padding above text

**.paddingRight** (number) - padding on right side of text

**.paddingBottom** (number) - padding below the text

**.paddingLeft** (number) - padding on left side of text

**.textAlign** (string) - adjust alignment

**.textTransform** (string) - text transform using uppercase, lowercase or capitalize

**.length** (number) - number of characters in text

**.contentEditable** (boolean) - make the text editable by user

**.autoSize** (boolean) - resize the layer to automatically to fit text the content

**.autoSizeHeight** (boolean) - resize the height of the layer to automatically to fit the text content. great for fixed width columns

**.setup** (boolean) - show a transparent background to outline the layer's size

**.convertToTextLayer()** - converts an imported layer to a TextLayer

##Contact

Twitter: [@andreaswah](http://twitter.com/andreaswah)
