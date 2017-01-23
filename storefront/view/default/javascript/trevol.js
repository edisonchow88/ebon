<!-- START: general -->
	function isset(x) {
		if(typeof x != 'undefined' && x != null && x != 'null' && x != '') {
			return true;
		}
		else {
			return false;
		}
	}
	
	<!-- START: [popover alert] -->
		function showAlert(text) {
			$(".popover-alert").html(text);
			$(".popover-alert").show();
			$(".popover-load").hide();
			setTimeout(function() { $(".popover-alert").delay(1000).fadeOut(300); }, 2000);
		}
	<!-- END -->
	<!-- START: [popover hint] -->
		function showHint(text) {
			$(".popover-hint").html(text);
			$(".popover-hint").show();
			$(".popover-load").hide();
			setTimeout(function() { $(".popover-hint").delay(1000).fadeOut(300); }, 2000);
		}
	<!-- END -->
	<!-- START: [popover loading] -->
		function showLoad(text) {
			$(".popover-load").html('<i class="fa fa-circle-o-notch fa-spin fa-fw"></i><i class="fa fa-fw"></i>'+text+'...');
			$(".popover-load").show();
		}
		
		function hideLoad() {
			$(".popover-load").hide();
		}
	<!-- END -->
	
	function escapeRegExp(str) {
		return str.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1");
	}
	function replaceAll(str, find, replace) {
		return str.replace(new RegExp(escapeRegExp(find), 'g'), replace);
	}
	
	<!-- START: jquery function to serialize form -->
		$.fn.serializeObject = function() {
			var o = {};
			var a = this.serializeArray();
			$.each(a, function() {
				if (o[this.name] !== undefined) {
					if (!o[this.name].push) {
						o[this.name] = [o[this.name]];
					}
					o[this.name].push(this.value || '');
				} else {
					o[this.name] = this.value || '';
				}
			});
			return o;
		};
	<!-- END -->
	
	/**
		sortList({
			container:'result',
			element:'result-row',
			dataset:[{data:'date',order:'asc'},{data:'name',order:'desc'}]
		});
	**/
	function sortList(obj) {
		$(obj.element).sort(function(a,b) {
			for(i=0;i<obj.dataset.length;i++) {
				if(i == obj.dataset.length) {
					return 0;
				}
				else {
					if($(a).data(obj.dataset[i].data) < $(b).data(obj.dataset[i].data)) {
						if(obj.dataset[i].order == 'asc') {
							return -1;
						}
						else {
							return 1;
						}
					}
					else if($(a).data(obj.dataset[i].data) > $(b).data(obj.dataset[i].data)) {
						if(obj.dataset[i].order == 'asc') {
							return 1;
						}
						else {
							return -1;
						}
					}
				}
			}
		}).appendTo(obj.container);
	}
	
	function convertUrlToText(url) {
		var text = url;
		if(isset(url)) {
			if(url.indexOf('http') >= 0) {
				var text = url.substring(url.indexOf('//')+2||0);
			}
		}
    	return text;
	}
	
	function convertTextToUrl(text) {
		var url = text;
		if(isset(text)) {
			if(text.indexOf('http') < 0) {
				var url = 'http://' + text;
			}
		}
    	return url;
	}
	
	function convertTimeToMinute(time) {
		var hrs = parseInt(time.substring(0, time.indexOf(':')));
		var mins =  parseInt(time.substring(time.indexOf(':')+1));
		return (hrs * 60 + mins);
	}
	
	function convertMinuteToTime(minute) {
		var hrs = Math.floor(minute / 60);          
		var mins = minute % 60;
		hrs = ("0" + hrs).slice(-2);
		mins = ("0" + mins).slice(-2);
		var string = hrs + ':' + mins;
		return (string);
	}
	
	function addDurationToTime(time,duration) {
		time = convertTimeToMinute(time);
		duration = parseInt(duration);
		var new_time = time + duration;
		new_time = convertMinuteToTime(new_time);
		return new_time;
	}
	
	function addDayToDate(date, day) {
		var result = new Date(date);
		result = new Date(result.setDate(result.getDate() + parseInt(day)));
		return result;
	}
	
	function processError(error) {
		alert(error['code'] + ': ' + error['title'] + '. ' + error['text']);
	}
	
	function fromNow(timestamp) {
		var then = new Date(timestamp);
		var now  = new Date;
		var text;
		d = Math.round((now - then) / (1000 * 60 * 60 * 24)); 
		if(d > 730) {
			y = Math.round(d/365);
			text = y + ' years ago';
		}
		else if(d > 365) {
			text = '1 year ago';
		}
		else if(d > 60) {
			m = Math.round(d/365);
			text = m + ' months ago';
		}
		else if(d > 30) {
			text = '1 month ago';
		}
		else if(d > 1) {
			text = d + ' days ago';
		}
		else if(d > 0) {
			text = '1 day ago';
		}
		else if(d > -1 && d <= 0) {
			text = 'today';
		}
		return text;
	}
	
	function date(format, timestamp) {
		var that = this;
		var jsdate, f;
		// Keep this here (works, but for code commented-out below for file size reasons)
		// var tal= [];
		var txt_words = [
		'Sun', 'Mon', 'Tues', 'Wednes', 'Thurs', 'Fri', 'Satur',
		'January', 'February', 'March', 'April', 'May', 'June',
		'July', 'August', 'September', 'October', 'November', 'December'
		];
		// trailing backslash -> (dropped)
		// a backslash followed by any character (including backslash) -> the character
		// empty string -> empty string
		var formatChr = /\\?(.?)/gi;
		var formatChrCb = function(t, s) {
		return f[t] ? f[t]() : s;
		};
		var _pad = function(n, c) {
		n = String(n);
		while (n.length < c) {
		n = '0' + n;
		}
		return n;
		};
		f = {
		// Day
		d: function() { // Day of month w/leading 0; 01..31
		return _pad(f.j(), 2);
		},
		D: function() { // Shorthand day name; Mon...Sun
		return f.l()
		.slice(0, 3);
		},
		j: function() { // Day of month; 1..31
		return jsdate.getDate();
		},
		l: function() { // Full day name; Monday...Sunday
		return txt_words[f.w()] + 'day';
		},
		N: function() { // ISO-8601 day of week; 1[Mon]..7[Sun]
		return f.w() || 7;
		},
		S: function() { // Ordinal suffix for day of month; st, nd, rd, th
		var j = f.j();
		var i = j % 10;
		if (i <= 3 && parseInt((j % 100) / 10, 10) == 1) {
		i = 0;
		}
		return ['st', 'nd', 'rd'][i - 1] || 'th';
		},
		w: function() { // Day of week; 0[Sun]..6[Sat]
		return jsdate.getDay();
		},
		z: function() { // Day of year; 0..365
		var a = new Date(f.Y(), f.n() - 1, f.j());
		var b = new Date(f.Y(), 0, 1);
		return Math.round((a - b) / 864e5);
		},
		
		// Week
		W: function() { // ISO-8601 week number
		var a = new Date(f.Y(), f.n() - 1, f.j() - f.N() + 3);
		var b = new Date(a.getFullYear(), 0, 4);
		return _pad(1 + Math.round((a - b) / 864e5 / 7), 2);
		},
		
		// Month
		F: function() { // Full month name; January...December
		return txt_words[6 + f.n()];
		},
		m: function() { // Month w/leading 0; 01...12
		return _pad(f.n(), 2);
		},
		M: function() { // Shorthand month name; Jan...Dec
		return f.F()
		.slice(0, 3);
		},
		n: function() { // Month; 1...12
		return jsdate.getMonth() + 1;
		},
		t: function() { // Days in month; 28...31
		return (new Date(f.Y(), f.n(), 0))
		.getDate();
		},
		
		// Year
		L: function() { // Is leap year?; 0 or 1
		var j = f.Y();
		return j % 4 === 0 & j % 100 !== 0 | j % 400 === 0;
		},
		o: function() { // ISO-8601 year
		var n = f.n();
		var W = f.W();
		var Y = f.Y();
		return Y + (n === 12 && W < 9 ? 1 : n === 1 && W > 9 ? -1 : 0);
		},
		Y: function() { // Full year; e.g. 1980...2010
		return jsdate.getFullYear();
		},
		y: function() { // Last two digits of year; 00...99
		return f.Y()
		.toString()
		.slice(-2);
		},
		
		// Time
		a: function() { // am or pm
		return jsdate.getHours() > 11 ? 'pm' : 'am';
		},
		A: function() { // AM or PM
		return f.a()
		.toUpperCase();
		},
		B: function() { // Swatch Internet time; 000..999
		var H = jsdate.getUTCHours() * 36e2;
		// Hours
		var i = jsdate.getUTCMinutes() * 60;
		// Minutes
		var s = jsdate.getUTCSeconds(); // Seconds
		return _pad(Math.floor((H + i + s + 36e2) / 86.4) % 1e3, 3);
		},
		g: function() { // 12-Hours; 1..12
		return f.G() % 12 || 12;
		},
		G: function() { // 24-Hours; 0..23
		return jsdate.getHours();
		},
		h: function() { // 12-Hours w/leading 0; 01..12
		return _pad(f.g(), 2);
		},
		H: function() { // 24-Hours w/leading 0; 00..23
		return _pad(f.G(), 2);
		},
		i: function() { // Minutes w/leading 0; 00..59
		return _pad(jsdate.getMinutes(), 2);
		},
		s: function() { // Seconds w/leading 0; 00..59
		return _pad(jsdate.getSeconds(), 2);
		},
		u: function() { // Microseconds; 000000-999000
		return _pad(jsdate.getMilliseconds() * 1000, 6);
		},
		
		// Timezone
		e: function() { // Timezone identifier; e.g. Atlantic/Azores, ...
		// The following works, but requires inclusion of the very large
		// timezone_abbreviations_list() function.
		/*              return that.date_default_timezone_get();
		*/
		throw 'Not supported (see source code of date() for timezone on how to add support)';
		},
		I: function() { // DST observed?; 0 or 1
		// Compares Jan 1 minus Jan 1 UTC to Jul 1 minus Jul 1 UTC.
		// If they are not equal, then DST is observed.
		var a = new Date(f.Y(), 0);
		// Jan 1
		var c = Date.UTC(f.Y(), 0);
		// Jan 1 UTC
		var b = new Date(f.Y(), 6);
		// Jul 1
		var d = Date.UTC(f.Y(), 6); // Jul 1 UTC
		return ((a - c) !== (b - d)) ? 1 : 0;
		},
		O: function() { // Difference to GMT in hour format; e.g. +0200
		var tzo = jsdate.getTimezoneOffset();
		var a = Math.abs(tzo);
		return (tzo > 0 ? '-' : '+') + _pad(Math.floor(a / 60) * 100 + a % 60, 4);
		},
		P: function() { // Difference to GMT w/colon; e.g. +02:00
		var O = f.O();
		return (O.substr(0, 3) + ':' + O.substr(3, 2));
		},
		T: function() { // Timezone abbreviation; e.g. EST, MDT, ...
		// The following works, but requires inclusion of the very
		// large timezone_abbreviations_list() function.
		/*              var abbr, i, os, _default;
		if (!tal.length) {
		tal = that.timezone_abbreviations_list();
		}
		if (that.php_js && that.php_js.default_timezone) {
		_default = that.php_js.default_timezone;
		for (abbr in tal) {
		for (i = 0; i < tal[abbr].length; i++) {
		if (tal[abbr][i].timezone_id === _default) {
		return abbr.toUpperCase();
		}
		}
		}
		}
		for (abbr in tal) {
		for (i = 0; i < tal[abbr].length; i++) {
		os = -jsdate.getTimezoneOffset() * 60;
		if (tal[abbr][i].offset === os) {
		return abbr.toUpperCase();
		}
		}
		}
		*/
		return 'UTC';
		},
		Z: function() { // Timezone offset in seconds (-43200...50400)
		return -jsdate.getTimezoneOffset() * 60;
		},
		
		// Full Date/Time
		c: function() { // ISO-8601 date.
		return 'Y-m-d\\TH:i:sP'.replace(formatChr, formatChrCb);
		},
		r: function() { // RFC 2822
		return 'D, d M Y H:i:s O'.replace(formatChr, formatChrCb);
		},
		U: function() { // Seconds since UNIX epoch
		return jsdate / 1000 | 0;
		}
		};
		this.date = function(format, timestamp) {
		that = this;
		jsdate = (timestamp === undefined ? new Date() : // Not provided
		(timestamp instanceof Date) ? new Date(timestamp) : // JS Date()
		new Date(timestamp * 1000) // UNIX timestamp (auto-convert to int)
		);
		return format.replace(formatChr, formatChrCb);
		};
		return this.date(format, timestamp);
	}
<!-- END -->