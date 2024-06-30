Class {
	#name : 'QuasarDemoMoviesShowTimeView',
	#superclass : 'QuasarDemoMoviesView',
	#category : 'Quasar-Demo-Movies',
	#package : 'Quasar-Demo',
	#tag : 'Movies'
}

{ #category : 'rendering' }
QuasarDemoMoviesShowTimeView >> renderDetailsOn: html [
	| theatres movies |

	theatres := self model theatresIn: self repositoryToUse.
	self renderDetail: theatres modelClass: QuasarDemoMoviesTheatre label: 'Theatres' on: html.

	movies := self model moviesIn: self repositoryToUse.
	self renderDetail: movies modelClass: QuasarDemoMoviesMovie label: 'Movies' on: html
]
