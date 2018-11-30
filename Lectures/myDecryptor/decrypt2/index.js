function sortNumber (a, b) {
	return b - a;
}

// 可以安排一定字典库，对字串进行替换，进行人工与软件结合辅助解密。

$(document).ready(function () {
	var $text1 = $("#text1");
	var $text2 = $("#text2");
	var $text3 = $("#text3");
	var $static = $("#btn-static");
	var $sort = $("#btn-sort");
	var $decrept = $("#btn-decrept");
	var frq = new Array(26);
	var frq_sort = new Array(26);
	var FRQ = [	'e', 't', 'a', 'o', 'i', 'n', 'r', 's', 'h',
					'c', 'l', 'd', 'u', 'f', 
					'g', 'm', 'b', 'y', 'p', 'k', 'x',
					'j', 'v', 'k', 'w', 'q', 'z'];

	$static.click(function () {

		var m = $text1.val();
		var str_frq = new String();
		
		for (var i = 0; i < 26; i++) {
			frq[i] = 0;
		}

		for (var i = 0; i < m.length; i++) {
			var ch = m.charCodeAt(i);
			ch = parseInt(ch);
			frq[ch - 65] += 1;
		}

		for (var i = 0; i < 26; i++) {
			var ch = String.fromCharCode(i + 65);
			str_frq += ch + ': ' + frq[i] + String.fromCharCode(13);
		}

		$text2.val(str_frq);

	});

	$sort.click(function () {

		var str_frq_sorted = new String();
		var max = frq[0], formerMax = frq[0];

		for (var i = 0; i < 26; i++) {
			frq_sort[i] = 0;
		}

		for (var i = 0; i < 26; i++) {
			max = 0;
			for (var j = 0; j < 26; j++) {
				if (i == 0) {
					if (frq[j] > max) {
						//console.log('max:' + max);
						max = frq[j];
						frq_sort[i] = j
					}
				} else {
					if (frq[j] > max && frq[j] < formerMax) {
						//console.log('max:' + max);
						max = frq[j];
						frq_sort[i] = j;
					} else if (frq[j] == 0 && i > 24) {
						frq_sort[i] = j;
					}
				}
			}

			//console.log('formermax:' + max);
			formerMax = max;
		}

		for (var i = 0; i < 26; i++) {
			frq_sort[i] = String.fromCharCode(frq_sort[i] + 65);
		}

		frq.sort(sortNumber);

		for (var i = 0; i < 26; i++) {
			var ch = String.fromCharCode(i + 65);
			str_frq_sorted += frq_sort[i] + ': ' + frq[i] + String.fromCharCode(13);
		}

		console.log(str_frq_sorted);
		$text2.val(str_frq_sorted);

	});

	$decrept.click(function () {

		var m = $text1.val();
		var result = new String();
		//console.log(frq);
		for (var j = 0; j < m.length; j++) {
			var ch = m[j];
			for (var i = 0; i < 26; i++) {
				if (ch == frq_sort[i]) {
					result += FRQ[i];
				}
			}
		}

		console.log(result);

		$text3.val(result);

	})

});