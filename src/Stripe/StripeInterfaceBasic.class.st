"
I am a basic interface to the Stripe domain. Unless a custom domain interface is needed, interactions with Stripe should be done through this interface.
"
Class {
	#name : #StripeInterfaceBasic,
	#superclass : #Object,
	#category : #Stripe
}

{ #category : #testing }
StripeInterfaceBasic class >> isVoyageRoot [

	^ true
]

{ #category : #adding }
StripeInterfaceBasic >> shoppingCart: aShoppingCart addProduct: aProduct [

	aShoppingCart cartItemsAdd: aProduct
]

{ #category : #adding }
StripeInterfaceBasic >> shoppingCartNew [

	^ StripeShoppingCart new
]
