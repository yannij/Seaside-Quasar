Extension { #name : 'MANumberDescription' }

{ #category : '*Quasar-Magritte' }
MANumberDescription class >> mdqDefaultComponentClasses [

	^ Array with: MDQStringComponent
]

{ #category : '*Quasar-Magritte' }
MANumberDescription >> mdqTableAlign [

	^ self propertyAt: #mdqTableAlign ifAbsent: [ 'right' ]
]
