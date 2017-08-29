function addGlobalStyle(css) {
	var head, style;
	head = document.getElementsByTagName('head')[0];
	if (!head) { return; }
	style = document.createElement('style');
	style.type = 'text/css';
	style.innerHTML = css;
	head.appendChild(style);
}
addGlobalStyle('.article__body--mask .article__premium-content { display: block !important; }');
addGlobalStyle('.article__body--mask .article__premium-content > * { display: block !important; }');
addGlobalStyle('div.factbox { display: block !important; }');
addGlobalStyle('div.paywall { display: none !important; }');
addGlobalStyle('div.ad { display: none !important; }');
addGlobalStyle('.article__body--mask .article__lead { position: initial !important; max-height: 1000px !important; }');
addGlobalStyle('div.ad--match-ad { display: none !important; }');
