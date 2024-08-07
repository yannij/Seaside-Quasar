Class {
	#name : 'MDQHexColorDescription',
	#superclass : 'MAStringDescription',
	#category : 'Quasar-Magritte',
	#package : 'Quasar-Magritte'
}

{ #category : 'accessing' }
MDQHexColorDescription class >> mdqDefaultComponentClasses [

	^ Array with: MDQHexColorComponent
]

{ #category : 'accessing' }
MDQHexColorDescription class >> mdqDefaultValue [

	^ Color gray asHexString
]

{ #category : 'visiting' }
MDQHexColorDescription >> acceptMagritte: aVisitor [

	aVisitor visitHexColorDescription: self
]
