# ProgressBar IOS Module

## Description

Simple progress bar module for iOS based on TiCircularProgress from Marcel Pociot

## Accessing the ProgressBar Module

To access this module from JavaScript, you would do the following:

    var progressbar = require("br.com.arlsoft.progressbar").createCircularView();

The progressbar variable is a reference to the ProgressBar View object.

## Accessing the ProgressBar Module with Alloy

Include the module tag in your view as following:

	<Module id="progressbar" module="br.com.arlsoft.progressbar" method="createCircularView" />

The $.progressbar variable is a reference to the ProgressBar View object.

### Customization options

//Color indicating the progress
//Required
progressTintColor (color)

//Color indicating the progress left
//Required
trackTintColor (color)

//Opacity index to the progress color
//Options : (transparent) 0.0 to 1.0 (solid)
//Default : 1.0
progressOpacity (float)

//Opacity index to the progress left color
//Options : (transparent) 0.0 to 1.0 (solid)
//Default : 1.0
trackOpacity (float)

//Use rounded corners for the progress indicator
//Default : false
roundedCorners (bool)

//Animate the progress updates
//Default : false
animatedProgress (bool)

//Progress indicator thickness
//Options : (none) 0.0 to 1.0 (full circle)
//Default : 0.3
thicknessRatio (float)

//Progress to display
//Options : (empty) 0.0 to 1.0 (full)
//Default : 0.0
progress (float)

//Inner text font color
//Default : 'white'
textColor (color)

//Inner text font color opacity
//Default : 1.0
textOpacity (float)

//Inner text font definition
//Default : system font, 12, bold
textFont (font)

//Inner text to display
//Default : empty
text (string)

## Usage

See example.

## Author

ArlSoft Tecnologia
contato@arlsoft.com.br

## License

Commercial : Copyright (c) 2014

All rights reserved.
This is proprietary software.
No warranty, explicit or implicit, provided.