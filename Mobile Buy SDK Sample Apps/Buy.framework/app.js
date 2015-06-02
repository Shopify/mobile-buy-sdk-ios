window.nativeApp = {
	execute: function(eventName, options) {
		options.eventName = eventName;
		window.webkit.messageHandlers.nativeApp.postMessage(options);
	}
};

/**
 * This does a very simple request to fetch the shop's cart, then send the "checkout" event back to the native app.
 */
function fetchCart() {
	var cartRequest = new XMLHttpRequest();
	cartRequest.open("GET", "/cart.json", false);
	cartRequest.onreadystatechange = function() {
		if (cartRequest.readyState == 4 && cartRequest.status == 200) {
			window.nativeApp.execute('com.shopify.hybrid.checkout', JSON.parse(cartRequest.responseText));
		}
	}
	
	cartRequest.send(null);
}