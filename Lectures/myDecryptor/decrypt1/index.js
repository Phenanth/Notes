var fileString = "";
function handleFile(files) {
	if (files.length) {
		var file = files[0];
		var reader = new FileReader();
		reader.readAsText(file);
		reader.onload = function() {
			fileString = this.result;
			//console.log(fileString);
		};
	}
}

function doSave(value, type, name) {
    var blob;
    if (typeof window.Blob == "function") {
        blob = new Blob([value], {type: type});
    } else {
        var BlobBuilder = window.BlobBuilder || window.MozBlobBuilder || window.WebKitBlobBuilder || window.MSBlobBuilder;
        var bb = new BlobBuilder();
        bb.append(value);
        blob = bb.getBlob(type);
    }
    var URL = window.URL || window.webkitURL;
    var bloburl = URL.createObjectURL(blob);
    var anchor = document.createElement("a");
    if ('download' in anchor) {
        anchor.style.visibility = "hidden";
        anchor.href = bloburl;
        anchor.download = name;
        document.body.appendChild(anchor);
        var evt = document.createEvent("MouseEvents");
        evt.initEvent("click", true, true);
        anchor.dispatchEvent(evt);
        document.body.removeChild(anchor);
    } else if (navigator.msSaveBlob) {
        navigator.msSaveBlob(blob, name);
    } else {
        location.href = bloburl;
    }
}

$(document).ready(function() {
	var $text1 = $("#text1");
	var $text2 = $("#text2");
	var $text3 = $("#text3");
	var $file = $("#file");
	var $key = $("#key");
	var $encrept = $("#btn-encrept");
	var $decrept = $("#btn-decrept");
	var $reset = $("#btn-reset");

	$encrept.click(function () {
		var string = $text1.val();
		var key = parseInt($key.val()) % 26 | 0;
		var result = new String();
		if (fileString != "") {
			string = fileString;
		}
		for (var i = 0; i < string.length; i++) {
			var temp = string.charCodeAt(i);
			//console.log(temp + ', ' + key);
			temp += key;
			result += String.fromCharCode(temp);
		}
		if (fileString) {
			console.log(result);
			doSave(result, "text/latex", "result.txt");
			$text3.val(result);
			fileString = "";
		} else {
			$text2.val(result);
		}
		
	});

	$decrept.click(function() {
		var string = $text2.val();
		var key = parseInt($key.val()) % 26 | 0;
		var result = new String();
		if (fileString != "") {
			string = fileString;
		}
		for (var i = 0; i < string.length; i++) {
			var temp = string.charCodeAt(i);
			//console.log(temp + ',' + key);
			temp -= key;
			result += String.fromCharCode(temp);
		}
		if (fileString) {
			console.log(result);
			doSave(result, "text/latex", "result.txt");
			$text3.val(result);
			fileString = "";
		} else {
			$text1.val(result);
		}
	});

	$reset.click(function() {
		$text1.val("");
		$text2.val("");
		$text3.val("");
		$key.val("");
		$file.after($file.clone().val(""));
		$file.remove();
		fileString = "";
	});

});
