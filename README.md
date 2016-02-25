# TextLayer for Framer.js

Framer.js module that simplifies the process of adding text to your prototypes.

![TextLayer](http://cl.ly/image/3q2m1q1w0x2w/TextLayer.png)

## Installation

Tested in [Framer Studio](http://framerjs.com) and [framer-cli](https://github.com/peteschaffner/framer-cli).

1. Run `npm install framer-textlayer` in your prototype's directory (usually MyPrototype.framer/)
2. Add a reference framer-textlayer by adding `textlayer = require("framer-textlayer")`. Where you do this depends on whether you're using Framer Studio or framer-cli

## Framer Studio

If you're using Framer Studio, you need to create an `npm.coffee` file in your modules folder, per [these instructions](http://framerjs.com/docs/#modules-npm-example).

`MyPrototype.framer/modules/npm.coffee`

```coffeescript
# npm.coffee is a simple module wrapper
exports.textlayer = require("framer-textlayer")
# You could require more npm modules that you have installed on additional lines. For example, assuming you have backbone installed:
#exports.backbone = require("backbone")
```

`MyPrototype.framer/app.coffee`

```coffeescript
npm = require("npm") # reference to your npm wrapper module
TextLayer = npm.textlayer # now you have direct access to the framer-textlayer npm module
```

## framer-cli

`index.coffee` (or index.js)

```coffeescript
pep = require("framer-textlayer")
```

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

##Contact

Twitter: [@andreaswah](http://twitter.com/andreaswah)
