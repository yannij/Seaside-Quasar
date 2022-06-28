Class {
	#name : #MDQHexColorDescription,
	#superclass : #MAStringDescription,
	#category : #'Quasar-Magritte'
}

{ #category : #accessing }
MDQHexColorDescription class >> mdqDefaultComponentClasses [

	^ Array with: MDQHexColorComponent
]

{ #category : #accessing }
MDQHexColorDescription class >> mdqDefaultValue [

	^ Color gray
]

{ #category : #visiting }
MDQHexColorDescription >> acceptMagritte: aVisitor [

	aVisitor visitHexColorDescription: self
]
