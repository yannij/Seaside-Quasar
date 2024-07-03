Class {
	#name : 'TBApplicationRootComponent',
	#superclass : 'QuasarApplication',
	#instVars : [
		'main'
	],
	#category : 'Quasar-Demo-TinyBlog-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog-Components'
}

{ #category : 'testing' }
TBApplicationRootComponent class >> canBeRoot [

	^ true
]

{ #category : 'class initialization' }
TBApplicationRootComponent class >> initialize [
	"self initialize"

	| app |
	app := WAAdmin register: self asApplicationAt: 'TinyBlog'.
	app preferenceAt: #sessionClass put: TBSession
]

{ #category : 'accessing' }
TBApplicationRootComponent >> applicationTitle [

	^ 'Tiny Blog'
]

{ #category : 'hooks' }
TBApplicationRootComponent >> children [

	^ { main }
]

{ #category : 'initialization' }
TBApplicationRootComponent >> initialize [

	super initialize.
	main := TBPostsListComponent new
]

{ #category : 'accessing' }
TBApplicationRootComponent >> main: aComponent [

	main := aComponent
]

{ #category : 'rendering - quasar hooks' }
TBApplicationRootComponent >> quasarSetupReturnCustomList: aList with: anAjaxFactory [
	
	aList add: '
myAuthDialog: ref(false)'
]

{ #category : 'rendering' }
TBApplicationRootComponent >> renderLayoutOn: html [

	html qApp
		id: self appId;
		with: [
			html qLayout
				view: 'hHh lpR fFf';
				with: [ html render: main ] ]
]

{ #category : 'updating' }
TBApplicationRootComponent >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.
	anHtmlRoot beHtml5.
	anHtmlRoot title: 'TinyBlog'
]
