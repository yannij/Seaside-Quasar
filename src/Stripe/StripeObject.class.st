Class {
	#name : #StripeObject,
	#superclass : #Object,
	#instVars : [
		'id',
		'object'
	],
	#category : #Stripe
}

{ #category : #acccessing }
StripeObject class >> objectType [

	^ self subclassResponsibility
]

{ #category : #accessing }
StripeObject >> id [

	^ id
]

{ #category : #accessing }
StripeObject >> id: anObject [

	id := anObject
]

{ #category : #accessing }
StripeObject >> object [

	^ object
]

{ #category : #accessing }
StripeObject >> object: anObject [

	object := anObject
]
