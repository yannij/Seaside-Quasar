Class {
	#name : #StripeSession,
	#superclass : #StripeObject,
	#instVars : [
		'success_url',
		'cancel_url',
		'payment_method_types',
		'line_items',
		'mode'
	],
	#category : #Stripe
}

{ #category : #acccessing }
StripeSession class >> objectType [

	^ 'checkout.session'
]

{ #category : #accessing }
StripeSession >> cancel_url [

	^ cancel_url
]

{ #category : #accessing }
StripeSession >> cancel_url: anObject [

	cancel_url := anObject
]

{ #category : #accessing }
StripeSession >> line_items [

	^ line_items
]

{ #category : #accessing }
StripeSession >> line_items: anObject [

	line_items := anObject
]

{ #category : #accessing }
StripeSession >> mode [

	^ mode
]

{ #category : #accessing }
StripeSession >> mode: anObject [

	mode := anObject
]

{ #category : #accessing }
StripeSession >> payment_method_types [

	^ payment_method_types
]

{ #category : #accessing }
StripeSession >> payment_method_types: anObject [

	payment_method_types := anObject
]

{ #category : #accessing }
StripeSession >> success_url [

	^ success_url
]

{ #category : #accessing }
StripeSession >> success_url: anObject [

	success_url := anObject
]
