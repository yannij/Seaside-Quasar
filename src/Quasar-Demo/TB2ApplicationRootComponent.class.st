"
I am a demo application originating from the TinyBlog tutorial  at https://github.com/SquareBracketAssociates/TinyBlog-EN. Here, the Seaside-Quasar version of TinyBlog is further adjusted to use additional features of Seaside-Quasar.
"
Class {
	#name : 'TB2ApplicationRootComponent',
	#superclass : 'QuasarApplication',
	#instVars : [
		'main'
	],
	#category : 'Quasar-Demo-TinyBlog2-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog2-Components'
}

{ #category : 'class initialization' }
TB2ApplicationRootComponent class >> applicationPath [

	^ 'tb2'
]

{ #category : 'testing' }
TB2ApplicationRootComponent class >> canBeRoot [

	^ true
]

{ #category : 'accessing' }
TB2ApplicationRootComponent class >> categoryName [

	^ #demo
]

{ #category : 'class initialization' }
TB2ApplicationRootComponent class >> initialize [
	"self initialize"

	| app |
	app := WAAdmin register: self asApplicationAt: self applicationPath.
	app preferenceAt: #sessionClass put: TB2Session
]

{ #category : 'accessing' }
TB2ApplicationRootComponent >> applicationTitle [

	^ 'Blog2'
]

{ #category : 'hooks' }
TB2ApplicationRootComponent >> children [

	^ { main }
]

{ #category : 'initialization' }
TB2ApplicationRootComponent >> initialize [

	super initialize.

	self reactiveObjectsAddIfAbsent: self session currentCategoryRef.
	self reactiveObjectsAddIfAbsent: self session pageNumberRef.

	main := TB2PostsListComponent new
]

{ #category : 'accessing' }
TB2ApplicationRootComponent >> main: aComponent [

	main := aComponent
]

{ #category : 'rendering - quasar hooks' }
TB2ApplicationRootComponent >> quasarSetupReturnCustomList: aList with: anAjaxFactory [
	
	aList add: '
myAuthDialog: ref(false)'
]

{ #category : 'rendering' }
TB2ApplicationRootComponent >> renderLayoutOn: html [

	html qApp
		id: self appId;
		with: [
			html qLayout
				view: 'hHh lpR fFf';
				vCloak;
				with: [ html render: main ] ]
]
