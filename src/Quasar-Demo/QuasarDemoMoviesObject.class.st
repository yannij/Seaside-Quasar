Class {
	#name : 'QuasarDemoMoviesObject',
	#superclass : 'Object',
	#category : 'Quasar-Demo-Movies',
	#package : 'Quasar-Demo',
	#tag : 'Movies'
}

{ #category : 'printing' }
QuasarDemoMoviesObject class >> attributeData [

	^ #()
]

{ #category : 'printing' }
QuasarDemoMoviesObject class >> modelName [

	^ 'abstract'
]

{ #category : 'accessing' }
QuasarDemoMoviesObject class >> viewClass [

	self subclassResponsibility
]

{ #category : 'converting' }
QuasarDemoMoviesObject >> asMap [
	| map |

	map := Dictionary new.

	self class attributeData do: [ :each |
		map at: each put: (self perform: each asSymbol) ].

	^ map
]

{ #category : 'printing' }
QuasarDemoMoviesObject >> attributeData [

	^ self class attributeData
]

{ #category : 'printing' }
QuasarDemoMoviesObject >> modelName [

	^ self class modelName
]

{ #category : 'printing' }
QuasarDemoMoviesObject >> summaryString [

	^ self modelName, ': ', ('/' join: (self attributeData collect: [ :each | self perform: each ]))
]

{ #category : 'converting' }
QuasarDemoMoviesObject >> updateFromMap: aMap [

	self class attributeData do: [ :each |
		aMap
			at: each
			ifPresent: [ :value |
				(self perform: each asSymbol) = value ifFalse: [
					self perform: each asSymbol asMutator with: value ] ] ]
]

{ #category : 'printing' }
QuasarDemoMoviesObject >> viewClass [

	^ self class viewClass
]
