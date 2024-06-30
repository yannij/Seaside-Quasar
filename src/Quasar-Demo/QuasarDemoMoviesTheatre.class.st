Class {
	#name : 'QuasarDemoMoviesTheatre',
	#superclass : 'QuasarDemoMoviesObject',
	#instVars : [
		'id',
		'name',
		'address',
		'phone'
	],
	#category : 'Quasar-Demo-Movies',
	#package : 'Quasar-Demo',
	#tag : 'Movies'
}

{ #category : 'printing' }
QuasarDemoMoviesTheatre class >> attributeData [

	^ #(id name address phone)
]

{ #category : 'printing' }
QuasarDemoMoviesTheatre class >> modelName [

	^ 'Theatre'
]

{ #category : 'accessing' }
QuasarDemoMoviesTheatre class >> viewClass [

	^ QuasarDemoMoviesTheatreView
]

{ #category : 'accessing' }
QuasarDemoMoviesTheatre >> address [

	^ address
]

{ #category : 'accessing' }
QuasarDemoMoviesTheatre >> address: anObject [

	address := anObject
]

{ #category : 'accessing' }
QuasarDemoMoviesTheatre >> id [

	^ id
]

{ #category : 'accessing' }
QuasarDemoMoviesTheatre >> id: anObject [

	id := anObject
]

{ #category : 'accessing' }
QuasarDemoMoviesTheatre >> name [

	^ name
]

{ #category : 'accessing' }
QuasarDemoMoviesTheatre >> name: anObject [

	name := anObject
]

{ #category : 'accessing' }
QuasarDemoMoviesTheatre >> phone [

	^ phone
]

{ #category : 'accessing' }
QuasarDemoMoviesTheatre >> phone: anObject [

	phone := anObject
]
