/**
 * Commercial : Copyright (c) 2014
 * ArlSoft Tecnologia <contato@arlsoft.com.br>
 *
 * All rights reserved.
 * This is proprietary software.
 * No warranty, explicit or implicit, provided.
 */

var increment = 0.05;
setInterval(function() {
	$.progressbar.progress += increment;
	$.progressbar.text = Math.round($.progressbar.progress * 100) + '%';

	if (increment > 0 && $.progressbar.progress >= 1) {
		increment = increment * -1;
	}
	else if (increment < 0 && $.progressbar.progress <= 0) {
		increment = increment * -1;
	}
}, 100);

$.index.open();