Class {
	#name : 'QuasarDemoMoviesShowTime',
	#superclass : 'QuasarDemoMoviesObject',
	#instVars : [
		'id',
		'movieId',
		'theatreId',
		'showDate',
		'showStartTime'
	],
	#category : 'Quasar-Demo-Movies',
	#package : 'Quasar-Demo',
	#tag : 'Movies'
}

{ #category : 'printing' }
QuasarDemoMoviesShowTime class >> attributeData [

	^ #(id movieId theatreId showDate showStartTime)
]

{ #category : 'printing' }
QuasarDemoMoviesShowTime class >> modelName [

	^ 'Show Time'
]

{ #category : 'accessing' }
QuasarDemoMoviesShowTime class >> viewClass [

	^ QuasarDemoMoviesShowTimeView
]

{ #category : 'accessing' }
QuasarDemoMoviesShowTime >> id [

	^ id
]

{ #category : 'accessing' }
QuasarDemoMoviesShowTime >> id: anObject [

	id := anObject
]

{ #category : 'accessing' }
QuasarDemoMoviesShowTime >> movieId [

	^ movieId
]

{ #category : 'accessing' }
QuasarDemoMoviesShowTime >> movieId: anObject [

	movieId := anObject
]

{ #category : 'accessing' }
QuasarDemoMoviesShowTime >> moviesIn: aRepo [

	^ aRepo
		selectMany: QuasarDemoMoviesMovie
		where: [ :each | each id = self movieId ]
]

{ #category : 'accessing' }
QuasarDemoMoviesShowTime >> name [

	^ ''
]

{ #category : 'accessing' }
QuasarDemoMoviesShowTime >> showDate [

	^ showDate
]

{ #category : 'accessing' }
QuasarDemoMoviesShowTime >> showDate: anObject [

	showDate := anObject
]

{ #category : 'accessing' }
QuasarDemoMoviesShowTime >> showStartTime [

	^ showStartTime
]

{ #category : 'accessing' }
QuasarDemoMoviesShowTime >> showStartTime: anObject [

	showStartTime := anObject
]

{ #category : 'accessing' }
QuasarDemoMoviesShowTime >> theatreId [

	^ theatreId
]

{ #category : 'accessing' }
QuasarDemoMoviesShowTime >> theatreId: anObject [

	theatreId := anObject
]

{ #category : 'accessing' }
QuasarDemoMoviesShowTime >> theatresIn: aRepo [

	^ aRepo
		selectMany: QuasarDemoMoviesTheatre
		where: [ :each | each id = self theatreId ]
]
