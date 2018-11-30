'use strict'

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

requirejs(['./node_modules/crypto-js/index.js'], function (CryptoJS) {

$(document).ready(function() {
	var $text1 = $("#text1");
	var $text2 = $("#text2");
	var $text3 = $("#text3");
	var $file = $("#file");
	var $key = $("#key");
	var $encrypt = $("#btn-encrypt");
	var $decrypt = $("#btn-decrypt");
	var $reset = $("#btn-reset");

	$encrypt.click(function () {
		var message = $text1.val();
		var keyHex = CryptoJS.enc.Utf8.parse($key.val());
		if (fileString != "") {
			message = fileString;
		}
		var encrypted = CryptoJS.DES.encrypt(message, keyHex, {
			iv: keyHex,
			mode: CryptoJS.mode.ECB,
			padding: CryptoJS.pad.Pkcs7
		});
		encrypted = encrypted.toString();

		if (fileString) {
			console.log(encrypted);
			doSave(encrypted, "text/latex", "result.txt");
			$text3.val(encrypted);
			fileString = "";
		} else {
			$text2.val(encrypted);
		}

	});

	$decrypt.click(function() {
		var encrypted = $text2.val();
		var keyHex = CryptoJS.enc.Utf8.parse($key.val());
		if (fileString != "") {
			encrypted = fileString;
		}
		//console.log(encrypted);
		var decrypted = CryptoJS.DES.decrypt(encrypted, keyHex, {
			iv: keyHex,
			mode: CryptoJS.mode.ECB,
			padding: CryptoJS.pad.Pkcs7
		});
		decrypted = CryptoJS.enc.Utf8.stringify(decrypted);

		if (fileString) {
			//console.log(decrypted);
			doSave(decrypted, "text/latex", "result.txt");
			$text3.val(decrypted);
			fileString = "";
		} else {
			//console.log(decrypted);
			if (decrypted == '') {
				decrypted = 'Wrong Key.';
			}
			$text1.val(decrypted);
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
});