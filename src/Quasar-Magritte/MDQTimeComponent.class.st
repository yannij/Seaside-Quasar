Class {
	#name : #MDQTimeComponent,
	#superclass : #MDQTextInputComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQTimeComponent >> inputAspect [

	^ true "self isChrome" ifTrue: [ #time24 ] ifFalse: [ #timeHtml5 ]
]

{ #category : #rendering }
MDQTimeComponent >> inputType [

	^ 'time'
]

{ #category : #accessing }
MDQTimeComponent >> time24 [

	^ self value
		ifNil: [ Time now print24 ]
		ifNotNil: [ :t | t print24 ]
]

{ #category : #accessing }
MDQTimeComponent >> time24: aString [

	aString isEmpty ifFalse: [
		self value: (Time fromString: aString) ]
]

{ #category : #accessing }
MDQTimeComponent >> timeHtml5 [

	^ self value
		ifNil: [ Time now printHtml5 ]
		ifNotNil: [ :t | t printHtml5 ]
]

{ #category : #accessing }
MDQTimeComponent >> timeHtml5: aString [

	aString isEmpty ifFalse: [
		self value: (Time fromString: aString) ]
]
