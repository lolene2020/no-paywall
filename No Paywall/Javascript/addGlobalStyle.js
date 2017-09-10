function hashCode(s) {
	return s.split("")
	.reduce( function(a,b) {
		a=((a<<5)-a)+b.charCodeAt(0);
		return a&a
	},0);
}

function addGlobalStyle(css) {
	var head, style, hash;
	head = document.getElementsByTagName('head')[0];
	if (!head) {
		return;
	}
	hash = hashCode(css);
	if( document.getElementById("hash-" + hash) === null ) {
		style = document.createElement('style');
		style.type = 'text/css';
		style.id = 'hash-' + hash;
		style.innerHTML = css;
		head.appendChild(style);
	} else {
		console.log('Tried to insert duplicate CSS-rules');
	}
}
