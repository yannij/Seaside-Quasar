Class {
	#name : #MDQStripeCheckout,
	#superclass : #QuasarComponent,
	#instVars : [
		'cartVisible',
		'cartState',
		'cartItems'
	],
	#category : #'Quasar-Magritte'
}

{ #category : #testing }
MDQStripeCheckout class >> isVoyageRoot [

	^ true
]

{ #category : #stripe }
MDQStripeCheckout >> actionCancel [

	self mdqApplicationGet logString: 'Cancel'
]

{ #category : #stripe }
MDQStripeCheckout >> actionSuccess [

	self mdqApplicationGet logString: 'Success'.

	self cartState: self cartStatePaid
]

{ #category : #rendering }
MDQStripeCheckout >> addValidatedForm [

	^ self
]

{ #category : #rendering }
MDQStripeCheckout >> asComponent [

	^ self
]

{ #category : #accessing }
MDQStripeCheckout >> cartItems [
	^ cartItems
]

{ #category : #accessing }
MDQStripeCheckout >> cartItems: anObject [
	cartItems := anObject
]

{ #category : #accessing }
MDQStripeCheckout >> cartItemsAdd: aProduct [

	self cartItems add: aProduct
]

{ #category : #accessing }
MDQStripeCheckout >> cartItemsClear [

	self cartState: self cartStateShopping.

	self cartItems: OrderedCollection new.
	"self cartItems: (OrderedCollection with: Object new)"
]

{ #category : #accessing }
MDQStripeCheckout >> cartItemsRemove: aProduct [

	self cartItems remove: aProduct ifAbsent: [ nil ]
]

{ #category : #accessing }
MDQStripeCheckout >> cartState [
	^ cartState
]

{ #category : #accessing }
MDQStripeCheckout >> cartState: anObject [
	cartState := anObject
]

{ #category : #accessing }
MDQStripeCheckout >> cartStatePaid [

	^ #Paid
]

{ #category : #accessing }
MDQStripeCheckout >> cartStateShopping [

	^ #Shopping
]

{ #category : #accessing }
MDQStripeCheckout >> cartValues [
	| total |

	total := self cartItems inject: 0.0 into: [ :sum :each |  sum + (((each at: #priceAmount) \\ 10000) / 100.0) ].
	
	^ IdentityDictionary new
		at: #total put: total;
		yourself
]

{ #category : #accessing }
MDQStripeCheckout >> cartValuesOLD [
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
MDQStripeCheckout >> cartVisible [
	^ cartVisible
]

{ #category : #accessing }
MDQStripeCheckout >> cartVisible: anObject [
	cartVisible := anObject
]

{ #category : #stripe }
MDQStripeCheckout >> deprecatedCreateCheckoutSessionRequest: arg1 json: arg2 [

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
MDQStripeCheckout >> getRedirectUrls: html [
	| newToken serverString publicServerUrl successUrl cancelUrl |

	newToken := nil.
	(self session properties includesKey: #tokenFilterKey) ifTrue: [
		| tokenFilter |
		tokenFilter := self session tokenFallbackProtectionFilter.
		newToken := tokenFilter newToken ].

	serverString := DockerDeploy current configsAt: DockerDeploy defaultConfigName atKey: 'publicServerUrl'.
	serverString ifNil: [
		"serverString := 'http://localhost:8080/'"
		self error: 'publicServerUrl not configured' ].
	publicServerUrl := WAUrl absolute: serverString.
	successUrl := html urlForAction: [ self actionSuccess ] absolute: publicServerUrl.
	cancelUrl := html urlForAction: [ self actionCancel ] absolute: publicServerUrl.

	newToken ifNotNil: [
		successUrl addField: WATokenFallbackProtectionFilter tokenQueryFieldName value: newToken.
		cancelUrl addField: WATokenFallbackProtectionFilter tokenQueryFieldName value: newToken ].

self mdqApplicationGet logString: successUrl printString.
self mdqApplicationGet logString: cancelUrl printString.

	^ Array with: successUrl with: cancelUrl
]

{ #category : #'rendering - collapsed' }
MDQStripeCheckout >> imageFor: aModel [
	| value |

	value := aModel at: 'images'.
	^ value isCollection ifTrue: [ value first ] ifFalse: [ value ]
]

{ #category : #initialization }
MDQStripeCheckout >> initialize [

	super initialize.

	self cartVisible: false.
	self cartItemsClear.
]

{ #category : #utility }
MDQStripeCheckout >> printAsMoney: aValue [

	^ aValue printString.

	"^ '$', (aValue printShowingDecimalPlaces: 2)"
]

{ #category : #'rendering - shopping' }
MDQStripeCheckout >> renderCartHeaderOn: html [

	html div: [
		self renderDismissButtonOn: html.
		html space; space.
		self renderCartSummaryOn: html ]
]

{ #category : #'rendering - collapsed' }
MDQStripeCheckout >> renderCartItemImagesOn: html [

	self cartItems do: [ :eachItem |			
		html image
			style: 'padding-right: 4px';
			"style: 'max-height: 56px; max-width: 100px';"
			style: 'max-height: 56px; max-width: 56px';
			url: (self imageFor: eachItem) ]
]

{ #category : #'rendering - shopping' }
MDQStripeCheckout >> renderCartItemsOn: html [

	html qList
		separator; "bordered;"
		denseIf: self mdqApplicationGet viewStyleDense;
		with: [
	self cartItems
		do: [ :eachItem |
			html qItem class: 'q-py-md'; class: 'q-px-none'; "class: 'no-margon';" with: [
				html qItemSection class: 'q-pr-xs'; side; with: [
					html qBtn flat; class: 'q-pa-xs';
						type: 'a';
						icon: 'remove_circle_outline';
						href: (html urlForAction: [ self cartItemsRemove: eachItem ]) ].
				html qItemSection avatar; with: [
					html image
						style: 'max-height: 56px; max-width: 56px';
						url: (self imageFor: eachItem) ].
				html qItemSection top; with: [
					html qItemLabel with: (eachItem at: 'id').
					html qItemLabel caption with: (eachItem at: 'description') ].
				html qItemSection side; top; with: [
					html qItemLabel class: 'text-right'; with: (eachItem at: 'price') ] ] ] ]
]

{ #category : #'rendering - shopping' }
MDQStripeCheckout >> renderCartOn: html [

	self renderCartHeaderOn: html.
	
	self cartState = self cartStateShopping
		ifTrue: [ ^ self renderCartShoppingOn: html ].
		
	self cartState = self cartStatePaid
		ifTrue: [ ^ self renderCartPaidOn: html ].
		
	html text: 'Cart error'
]

{ #category : #'rendering - paid' }
MDQStripeCheckout >> renderCartPaidOn: html [

	self renderCartTotalsOn: html.
	html span class: 'text-h6'; with: 'Payment successful !'
]

{ #category : #'rendering - shopping' }
MDQStripeCheckout >> renderCartShoppingOn: html [

	html qSeparator spaced: 'md'.
	self renderCartItemsOn: html.
	html qSeparator spaced: 'md'.
	self renderCartTotalsOn: html.
	self renderCheckoutButtonOn: html
]

{ #category : #'rendering - shopping' }
MDQStripeCheckout >> renderCartSummaryOn: html [

	html span class: 'text-subtitle1'; with: [
		html text: 'CART'; space; space.
		html text: self cartItems size printString.
		html text: (self cartItems size = 1 ifTrue: [ ' ITEM' ] ifFalse: [ ' ITEMS' ]) ].
]

{ #category : #'rendering - shopping' }
MDQStripeCheckout >> renderCartTotalItem: lineItemName value: lineItemValue on: html [

	html qItem class: 'no-padding'; class: 'no-margin'; with: [
		html qItemSection with: [
			html qItemLabel with: lineItemName ].
		html qItemSection side; with: [
			html qItemLabel class: 'text-right'; style: 'font-size: 2rem'; with: lineItemValue ] ]
]

{ #category : #'rendering - shopping' }
MDQStripeCheckout >> renderCartTotalsOn: html [
	| cartValues |

	cartValues := self cartValues.
	html qList dense; padding; with: [
		self renderCartTotalItem: 'TOTAL' value: (self printAsMoney: (cartValues at: #total)) on: html.
		"self renderCartTotalItem: 'Subtotal' value: (self printAsMoney: (cartValues at: #subtotal)) on: html.
		self renderCartTotalItem: 'Shipping' value: (self printAsMoney: (cartValues at: #shipping)) on: html.
		self renderCartTotalItem: 'Tax' value: (self printAsMoney: (cartValues at: #tax)) on: html"
	]
]

{ #category : #'rendering - shopping' }
MDQStripeCheckout >> renderCheckoutButtonOn: html [
	| button |

	button := html qBtn.
	self cartItems isEmpty
		ifTrue: [ button disable ]
		ifFalse: [ button onClick: (self stripeRedirectScriptOn: html) ].
	button
		style: 'background: var(--q-primary)';
		with: 'Proceed to checkout'
]

{ #category : #'rendering - collapsed' }
MDQStripeCheckout >> renderCollapsedCartOn: html [

	html qBtn round; "class: 'q-pa-xs';"
		denseIf: self mdqApplicationGet viewStyleDense;
		type: 'a';
		icon: 'shopping_cart';
		href: (html urlForAction: [ self cartVisible: true ]).

	self renderCartItemImagesOn: html
]

{ #category : #rendering }
MDQStripeCheckout >> renderContentOn: html [

	html div with: [
		self cartVisible
			ifTrue: [ self renderCartOn: html ]
			ifFalse: [ self renderCollapsedCartOn: html ] ]
]

{ #category : #'rendering - shopping' }
MDQStripeCheckout >> renderDismissButtonOn: html [

	html qBtn
		denseIf: self mdqApplicationGet viewStyleDense;
		round; "class: 'q-pa-xs';"
		type: 'a';
		href: (html urlForAction: [ self cartVisible: false ]);
		icon: 'keyboard_arrow_up'
]

{ #category : #stripe }
MDQStripeCheckout >> serverUrl [

	^ self mdqPublicServerUrl
		ifNotNil: [ :value | value ]
		ifNil: [ self error: 'Public server URL not set' ]
]

{ #category : #stripe }
MDQStripeCheckout >> stripeRedirectScriptOn: html [

	"TODO: fix needed"
	^ html qAjax jsFetch
		json: [ :json | self deprecatedCreateCheckoutSessionRequest: html json: json ];
		onSuccess: (html javascript << (JSStream new
				nextPutAll: 'Stripe(''';
				nextPutAll: StripeAPI current stripePublishableKey;
				nextPutAll: ''').redirectToCheckout({sessionId: JSON.parse(arguments[0]).id})';
				yourself);
			yourself)
]
