/**
 * Commercial : Copyright (c) 2014
 * ArlSoft Tecnologia <contato@arlsoft.com.br>
 *
 * All rights reserved.
 * This is proprietary software.
 * No warranty, explicit or implicit, provided.
 */

var win = Ti.UI.createWindow({
	backgroundColor : 'black'
});

var progressbar = require('br.com.arlsoft.progressbar');

var progressView = progressbar.createCircularView({
	height: 50,
	width: 50,
	//Color indicating the progress
	progressTintColor: 'red',
	//Color indicating the progress left
	trackTintColor: 'yellow',
	//Opacity index to the progress color
	progressOpacity: 1,
	//Opacity index to the progress left color
	trackOpacity: 0.8,
	//Use rounded corners for the progress indicator
	roundedCorners: true,
	//Animate the progress updates
	animatedProgress: true,
	//Progress indicator thickness
	thicknessRatio: 0.3,
	//Progress to display
	progress: 0,
	//Inner text font color
	textColor: 'white',
	//Inner text font color opacity
	textOpacity: 1,
	//Inner text font definition
	textFont: {
		fontFamily: 'Helvetica',
		fontSize: 12,
		fontStyle: 'normal',
		fontWeight: 'bold'
	},
	//Inner text to display
	text : ''
});

win.add(progressView);

var increment = 0.05;
setInterval(function() {
	progressView.progress += increment;
	progressView.text = Math.round(progressView.progress * 100) + '%';

	if (increment > 0 && progressView.progress >= 1) {
		increment = increment * -1;
	}
	else if (increment < 0 && progressView.progress <= 0) {
		increment = increment * -1;
	}
}, 100);

win.open();