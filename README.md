# TextLayer for Framer.js

Framer.js module that simplifies the process of adding text to your prototypes.

## Installation

1. Download the textLayer.coffee file
2. Create a framer project and drop textLayer.coffee inside the /modules folder
3. Add `TextLayer = require 'textlayer'` at the top of your document


More info about modules in Framer: [FramerJS Docs - Modules](http://framerjs.com/docs/#modules]http://framerjs.com/docs/#modules)


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
	
### Positioning and layout using the .setup guide

	t = new TextLayer
		text: "This is a headline"
		setup: true
		x: 210
		paddingLeft: 10
	
### AutoSize based on text length and styling

	t = new TextLayer
		autoSize: true
		text: "This text is longer than 100px, but it's ok"
		
### Create a quick list of text

	for fruit, i in ["Apple", "Pear", "Kiwi", "Banana"]
		t = new TextLayer
			text: fruit
			y: i*30
		

## Properties

**.text** (string)

**.fontFamily** (string)

**.fontSize** (number)

**.color** (string) (part of Layer)

**.lineHeight** (number)

**.fontWeight** (string)

**.paddingTop** (number)

**.paddingRight** (number)

**.paddingBottom** (number)

**.paddingLeft** (number)

**.textAlign** (string)

**.length** (number)

**.textAlign** (string)

**.length** (number)

**.autoSize** (true,false)

**.setup** (true,false)

		
## Methods

**.toUpperCase()**

**.toLowerCase()**
