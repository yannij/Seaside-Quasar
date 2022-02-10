"
I am a shopping cart that uses Stripe to process the transaction
"
Class {
	#name : #StripeShoppingCart,
	#superclass : #QuasarComponent,
	#instVars : [
		'cartVisible',
		'cartState',
		'cartItems'
	],
	#category : #Stripe
}

{ #category : #testing }
StripeShoppingCart class >> isVoyageRoot [

	^ true
]

{ #category : #stripe }
StripeShoppingCart >> actionCancel [

	self mdqApplicationGet logString: 'Cancel'
]

{ #category : #stripe }
StripeShoppingCart >> actionSuccess [

	self mdqApplicationGet logString: 'Success'.

	self cartState: self cartStatePaid
]

{ #category : #rendering }
StripeShoppingCart >> addValidatedForm [

	^ self
]

{ #category : #rendering }
StripeShoppingCart >> asComponent [

	^ self
]

{ #category : #accessing }
StripeShoppingCart >> cartItems [
	^ cartItems
]

{ #category : #accessing }
StripeShoppingCart >> cartItems: anObject [
	cartItems := anObject
]

{ #category : #accessing }
StripeShoppingCart >> cartItemsAdd: aProduct [

	self cartItems add: aProduct
]

{ #category : #accessing }
StripeShoppingCart >> cartItemsClear [

	self cartState: self cartStateShopping.

	self cartItems: OrderedCollection new.
	"self cartItems: (OrderedCollection with: Object new)"
]

{ #category : #accessing }
StripeShoppingCart >> cartState [
	^ cartState
]

{ #category : #accessing }
StripeShoppingCart >> cartState: anObject [
	cartState := anObject
]

{ #category : #accessing }
StripeShoppingCart >> cartStatePaid [

	^ #Paid
]

{ #category : #accessing }
StripeShoppingCart >> cartStateShopping [

	^ #Shopping
]

{ #category : #accessing }
StripeShoppingCart >> cartValues [
	| total |

	total := self cartItems inject: 0.0 into: [ :sum :each |  sum + (((each at: #priceAmount) \\ 10000) / 100.0) ].
	
	^ IdentityDictionary new
		at: #total put: total;
		yourself
]

{ #category : #accessing }
StripeShoppingCart >> cartValuesOLD [
	| subtotal shipping tax |

	subtotal := self cartItems inject: 0.0 into: [ :sum :each |  sum + ((each hash \\ 10000) / 100.0) ].
	shipping := self cartItems ifEmpty: [ 0.0 ] ifNotEmpty: [ 10.00 ].
	tax := subtotal * 0.1.
	
	^ IdentityDictionary new
		at: #total put: (subtotal + shipping + tax);
		at: #subtotal put: subtotal;
		at: #shipping put: shipping;
		at: #tax put: tax;
		yourself
]

{ #category : #accessing }
StripeShoppingCart >> cartVisible [
	^ cartVisible
]

{ #category : #accessing }
StripeShoppingCart >> cartVisible: anObject [
	cartVisible := anObject
]

{ #category : #stripe }
StripeShoppingCart >> deprecatedCreateCheckoutSessionRequest: arg1 json: arg2 [

	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 tmp7 |
	tmp2 := Array with: 'v1' with: 'checkout' with: 'sessions'.
	tmp3 := self getRedirectUrls: arg1.
	tmp7 := Dictionary new.
	tmp7
		at: 'success_url' put: tmp3 first printString;
		at: 'cancel_url' put: tmp3 second printString;
		at: 'payment_method_types[0]' put: 'card';
		at: 'mode' put: 'payment'.
	tmp4 := tmp7 yourself.
	self cartItems withIndexDo: [ :arg3 :arg4 | 
		| tmp8 |
		tmp8 := (arg4 - 1) printString.
		tmp4
			at: 'line_items[' , tmp8 , '][name]' put: (arg3 at: 'id');
			at: 'line_items[' , tmp8 , '][description]'
			put: (arg3 at: 'description');
			at: 'line_items[' , tmp8 , '][amount]'
			put: (arg3 at: 'priceAmount') asString;
			at: 'line_items[' , tmp8 , '][currency]'
			put: (arg3 at: 'priceCurrency') asString asLowercase;
			at: 'line_items[' , tmp8 , '][quantity]' put: '1';
			yourself ].
	tmp5 := StripeAPI current path: tmp2 request: tmp4 postAs: nil.
	self mdqApplicationGet logString: tmp5.
	tmp6 := WAJsonParser parse: tmp5.
	(tmp6 includesKey: 'id') ifFalse: [ 
		self mdqApplicationGet logString: 'Stripe error response: ' , tmp5 ].
	^ arg2 string: tmp5
]

{ #category : #stripe }
StripeShoppingCart >> getRedirectUrls: html [
	| newToken serverString publicServerUrl successUrl cancelUrl |

	newToken := nil.
	(self session properties includesKey: #tokenFilterKey) ifTrue: [
		| tokenFilter |
		tokenFilter := self session tokenFallbackProtectionFilter.
		newToken := tokenFilter newToken ].

	serverString := DockerDeploy current configsAt: DockerDeploy defaultConfigName atKey: 'publicServerUrl'.
	serverString ifNil: [
		serverString := 'http://localhost:8080/'
		"self error: 'publicServerUrl not defned'" ].
	publicServerUrl := WAUrl absolute: serverString.
	successUrl := html urlForAction: [ self actionSuccess ] absolute: (WAUrl absolute: 'http://localhost:8080/').
	cancelUrl := html urlForAction: [ self actionCancel ] absolute: (WAUrl absolute: 'http://localhost:8080/').

	newToken ifNotNil: [
		successUrl addField: WATokenFallbackProtectionFilter tokenQueryFieldName value: newToken.
		cancelUrl addField: WATokenFallbackProtectionFilter tokenQueryFieldName value: newToken ].

self mdqApplicationGet logString: successUrl printString.
self mdqApplicationGet logString: cancelUrl printString.

	^ Array with: successUrl with: cancelUrl
]

{ #category : #initialization }
StripeShoppingCart >> initialize [

	super initialize.

	self cartVisible: false.
	self cartItemsClear.
]

{ #category : #utility }
StripeShoppingCart >> printAsMoney: aValue [

	^ aValue printString.

	"^ '$', (aValue printShowingDecimalPlaces: 2)"
]

{ #category : #rendering }
StripeShoppingCart >> renderCartHeaderOn: html [

	html div: [
		self renderDismissButtonOn: html.
		html space; space.
		self renderCartSummaryOn: html ]
]

{ #category : #rendering }
StripeShoppingCart >> renderCartItemImagesOn: html [

	self cartItems do: [ :eachItem |			
		html image
			style: 'padding-right: 4px';
			"style: 'max-height: 56px; max-width: 100px';"
			style: 'max-height: 56px; max-width: 56px';
			url: (eachItem at: 'images') first ]
]

{ #category : #rendering }
StripeShoppingCart >> renderCartItemsOn: html [

	html unorderedList mdcDeprecatedList; mdcTheme_surface; mdcDeprecatedList_twoLine; mdcDeprecatedList_imageList; with: [
		self cartItems do: [ :eachItem |			
			html listItem mdcDeprecatedListItem; with: [
				html span mdcDeprecatedListItem__graphic; with: [
					html image
						style: 'max-height: 56px; max-width: 56px';
						url: (eachItem at: 'images') first ].
				html span mdcDeprecatedListItem__text; with: [
					html span mdcListItem__primaryText; with: (eachItem at: 'id').
					html span mdcListItem__secondaryText; with: (eachItem at: 'price') ] ] ] ]
]

{ #category : #rendering }
StripeShoppingCart >> renderCartLine: lineItemName total: lineItemValue on: html [

	html span mdcTypography_body1; with: lineItemName.
	html text: ' . . . '.
	html span mdcTypography_body1; with: lineItemValue.
	html break
]

{ #category : #rendering }
StripeShoppingCart >> renderCartOn: html [

	self renderCartHeaderOn: html.
	
	self cartState = self cartStateShopping
		ifTrue: [ ^ self renderCartShoppingOn: html ].
		
	self cartState = self cartStatePaid
		ifTrue: [ ^ self renderCartPaidOn: html ].
		
	html text: 'Cart error'
]

{ #category : #rendering }
StripeShoppingCart >> renderCartPaidOn: html [

	self renderCartTotalsOn: html.
	html span mdcTypography_headline6; with: 'Payment successful !'.
	self renderClearCartButtonOn: html
]

{ #category : #rendering }
StripeShoppingCart >> renderCartShoppingOn: html [

	self renderCartItemsOn: html.
	self renderCartTotalsOn: html.
	self renderCheckoutButtonOn: html.
	self renderClearCartButtonOn: html
]

{ #category : #rendering }
StripeShoppingCart >> renderCartSummaryOn: html [

	html span mdcTypography_subtitle1; with: [
		html text: 'CART'; space; space; space.
		html text: self cartItems size printString.
		html text: (self cartItems size = 1 ifTrue: [ ' ITEM' ] ifFalse: [ ' ITEMS' ]) ].
]

{ #category : #rendering }
StripeShoppingCart >> renderCartTotalsOn: html [
	| cartValues |

	cartValues := self cartValues.

	self renderCartLine: 'TOTAL' total: (self printAsMoney: (cartValues at: #total)) on: html.
	"self renderCartLine: 'Subtotal' total: (self printAsMoney: (cartValues at: #subtotal)) on: html.
	self renderCartLine: 'Shipping' total: (self printAsMoney: (cartValues at: #shipping)) on: html.
	self renderCartLine: 'Tax' total: (self printAsMoney: (cartValues at: #tax)) on: html."
]

{ #category : #rendering }
StripeShoppingCart >> renderCheckoutButtonOn: html [

	html button
		mdcButton;
		mdcButton_raised;
		style: 'margin-bottom: 8px; width: 100%';
		onClick: (self stripeRedirectScriptOn: html);
		with: 'Proceed to checkout'
]

{ #category : #rendering }
StripeShoppingCart >> renderClearCartButtonOn: html [

	html anchor
		mdcButton;
		mdcButton_raised;
		style: 'width: 100%';
		callback: [ self cartItemsClear ];
		with: 'Clear cart'
]

{ #category : #rendering }
StripeShoppingCart >> renderContentOn: html [

	html div
		style: 'padding: 8px';
		style: 'background: var(--mdc-theme-secondary)';
		with: [
			self cartVisible
				ifTrue: [ self renderCartOn: html ]
				ifFalse: [ self renderShowCartButtonOn: html ] ]

	
]

{ #category : #rendering }
StripeShoppingCart >> renderDismissButtonOn: html [

	html anchor mdcMaterialIcons; mdcIconButton; "mdcButton_raised;"
		callback: [ self cartVisible: false ];
		with: [ html div mdcButton__ripple; with:'expand_less' ]
]

{ #category : #rendering }
StripeShoppingCart >> renderShowCartButtonOn: html [

	html anchor mdcMaterialIcons; mdcIconButton; "mdcButton_unelevated;" "mdcButton_raised;"
		callback: [ self cartVisible: true ];
		with: [ html div mdcButton__ripple; with: 'shopping_cart' ].

	self renderCartItemImagesOn: html
]

{ #category : #stripe }
StripeShoppingCart >> serverUrl [

	^ self mdqPublicServerUrl
		ifNotNil: [ :value | value ]
		ifNil: [ self error: 'Public server URL not set' ]
]

{ #category : #stripe }
StripeShoppingCart >> stripeRedirectScriptOn: html [

	^ html jQuery getJson 
		json: [ :json | self deprecatedCreateCheckoutSessionRequest: html json: json ];
		onSuccess: (html javascript << (JSStream new
				nextPutAll: 'Stripe(''';
				nextPutAll: StripeAPI current stripePublishableKey;
				nextPutAll: ''').redirectToCheckout({sessionId: JSON.parse(arguments[0]).id})';
				yourself);
			yourself)
]
