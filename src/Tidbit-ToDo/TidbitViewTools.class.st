Class {
	#name : #TidbitViewTools,
	#superclass : #QuasarComponent,
	#category : #'Tidbit-ToDo-MaterialWeb'
}

{ #category : #rendering }
TidbitViewTools >> renderButton: aButtonText caption: aCaptionText callback: aBlock on: html [

	html qBtn
		type: 'a'; href: (html urlForAction: [ aBlock value ]);
		with: aButtonText.
	html space; space.
	html span class: 'text_caption'; with: aCaptionText
]

{ #category : #rendering }
TidbitViewTools >> renderContentOn: html [

	html div style: 'padding: 8px'; with: [
		html div class: 'text_subtitle1'; with: 'Tools'.
		self
			renderButton: 'Reset connection'
			caption: 'Reset the repository connection which is cached in a class variable'
			callback: [ self mdqApplicationGet repositoryResetConnection ]
			on: html.
		html break; break.
		self
			renderButton: 'Reset database'
			caption: 'Delete current database content, and recreate original demo content. Will logout'
			callback: [ self mdqApplicationGet repositoryRecreateTestData; logout ]
			on: html.
		html break; break.
		html span class: 'text_subtitle1'; with: 'Mongo config'.
		html preformatted: 'mongo-host: ', TidbitExampleDatabase mongoHost printString.
		html preformatted: 'mongo-port: ', TidbitExampleDatabase mongoPort printString.
		html preformatted: 'mongo-database: ', TidbitExampleDatabase mongoDatabase printString ]
]
