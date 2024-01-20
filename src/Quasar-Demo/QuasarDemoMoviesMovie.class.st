Class {
	#name : #QuasarDemoMoviesMovie,
	#superclass : #QuasarDemoMoviesObject,
	#instVars : [
		'id',
		'name',
		'classification',
		'rating',
		'duration',
		'tags'
	],
	#category : #'Quasar-Demo-Movies'
}

{ #category : #printing }
QuasarDemoMoviesMovie class >> attributeData [

	^ #(id name classification rating duration tags)
]

{ #category : #printing }
QuasarDemoMoviesMovie class >> modelName [

	^ 'Movie'
]

{ #category : #accessing }
QuasarDemoMoviesMovie class >> viewClass [

	^ QuasarDemoMoviesMovieView
]

{ #category : #accessing }
QuasarDemoMoviesMovie >> classification [

	^ classification
]

{ #category : #accessing }
QuasarDemoMoviesMovie >> classification: anObject [

	classification := anObject
]

{ #category : #accessing }
QuasarDemoMoviesMovie >> duration [

	^ duration
]

{ #category : #accessing }
QuasarDemoMoviesMovie >> duration: anObject [

	duration := anObject
]

{ #category : #accessing }
QuasarDemoMoviesMovie >> id [

	^ id
]

{ #category : #accessing }
QuasarDemoMoviesMovie >> id: anObject [

	id := anObject
]

{ #category : #accessing }
QuasarDemoMoviesMovie >> name [

	^ name
]

{ #category : #accessing }
QuasarDemoMoviesMovie >> name: anObject [

	name := anObject
]

{ #category : #accessing }
QuasarDemoMoviesMovie >> rating [

	^ rating
]

{ #category : #accessing }
QuasarDemoMoviesMovie >> rating: anObject [

	rating := anObject
]

{ #category : #accessing }
QuasarDemoMoviesMovie >> tags [

	^ tags
]

{ #category : #accessing }
QuasarDemoMoviesMovie >> tags: anObject [

	tags := anObject
]
