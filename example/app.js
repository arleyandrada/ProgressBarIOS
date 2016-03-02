/**
 * MIT License
 * Copyright (c) 2014-present
 * ArlSoft Tecnologia <contato@arlsoft.com.br>
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
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