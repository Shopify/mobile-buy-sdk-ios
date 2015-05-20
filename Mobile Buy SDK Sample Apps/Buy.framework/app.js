window.nativeApp = {
	execute: function(eventName, options) {
		options.eventName = eventName;
		window.webkit.messageHandlers.nativeApp.postMessage(options);
	}
};

/**
 * Method invoked by the native app to initialize the web view.
 */
function nativeAppSetup() {
	createBuyNowButtons();
	createCheckoutBuyNowButtons();
}

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

/**
 * This will turn 'Buy Now' buttons on a product page into an ApplePay button.
 *
 * For this to work, you must add a button and a hidden input field to your product page. This can be done by customizing the liquid of your product page.
 *
 * 1. Add a hidden button to the product page.
 *     <button type="button" name="buyNowButton" class="hidden">
 *         Buy Now
 *     </button>
 *
 * **Note**: The 'hidden' class is removed by the script. It is recommended that you add: `.hidden { display: none; }` to your theme.
 *
 * 2. For the input, in the form that submits to `/cart/add`, add:
 *
 *    <input id="handle" type="hidden" value="{{ product.handle }}">
 *
 */
function createBuyNowButtons() {
	var buyNowButtons = document.querySelectorAll("button[name=buyNowButton]");
	for (var i = 0; i < buyNowButtons.length; ++i) {
		var button = buyNowButtons[i];
		console.log('Found a Buy Now button');
		button.classList.remove('hidden');
		
		button.onclick = function(event) {
			console.log('Intercepted cart redirect');
			
			var form = button.form;
			var handle = getProductHandle(form);
			var variantId = getSelectedVariantId(form);
			console.log('User selected variantId: ' + variantId);
			
			checkoutWithLineItems([{ 'quantity' : 1, 'handle': handle, 'variantId': variantId }]);
		};
	}
}

/**
 * This will turn 'Buy Now' buttons on the cart page into an ApplePay button.
 *
 * For this to work, you must make a few modifications to the cart liquid.
 *
 * 1. You must add a button with name of 'nativeCheckout'. You can customize the name in the script below.
 *
 *     <button type="button" name="nativeCheckout" class="hidden">
 *         Buy Now
 *     </button>
 *
 * **Note**: The 'hidden' class is removed by the script. It is recommended that you add: `.hidden { display: none; }` to your theme.
 *
 *
 * 2. You must add the follow attributes to the /cart form's quantity inputs:
 *
 *     product-handle="{{ item.product.handle }}" variant-id="{{ item.variant.id }}"
 *
 * For example:
 *
 *     <input type="number"
 *            name="updates[]"
 *            id="updates_{{ item.id }}"
 *            value="{{ item.quantity }}"
 *            min="0" product-handle="{{ item.product.handle }}"
 *            variant-id="{{ item.variant.id }}">
 *
 */
function createCheckoutBuyNowButtons() {
	var nativeCheckoutButtons = document.querySelectorAll("button[name=nativeCheckout]");
	for (var i = 0; i < nativeCheckoutButtons.length; ++i) {
		var button = nativeCheckoutButtons[i];
		console.log('Found a Native Checkout button');
		button.classList.remove('hidden');
		
		button.onclick = function(event) {
			var form = button.form;
			var elements = form.elements;
			
			var lineItems = [];
			
			for (var j = 0; j < elements.length; ++j) {
				var element = elements[j];
				
				var variantId = element.getAttribute('variant-id');
				var handle = element.getAttribute('product-handle');
				var quantity = element.value;
				
				if (variantId && handle && quantity) {
					lineItems.push({ 'quantity' : quantity, 'handle' : handle, 'variantId' : variantId });
				}
			}
			
			checkoutWithLineItems(lineItems);
		};
	}
}

function getProductHandle(form) {
	var inputs = form.querySelectorAll("input[id=handle]");
	var handle = "";
	if (inputs.length > 0) {
		handle = inputs[0].value;
	}
	return handle;
}

function getSelectedVariantId(form) {
	var inputs = form.querySelectorAll("select[name=id]");
	var variantId = -1;
	if (inputs.length > 0) {
		variantId = inputs[0].value;
	}
	return variantId;
}

function checkoutWithLineItems(lineItems) {
	var cart = { 'cart' : { 'lineItems' : lineItems }};
	console.log('User checking out with cart: ' + cart);
	
	window.nativeApp.execute('com.shopify.hybrid.buynow', cart);
}
