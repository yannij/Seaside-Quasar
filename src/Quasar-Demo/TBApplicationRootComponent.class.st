"
I am a demo application originating from the TinyBlog tutorial at  https://github.com/SquareBracketAssociates/TinyBlog-EN. This version has been adjusted to use Seaside-Quasar, instead of Bootstrap CSS.
"
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

{ #category : 'class initialization' }
TBApplicationRootComponent class >> applicationPath [

	^ 'TinyBlog'
]

{ #category : 'testing' }
TBApplicationRootComponent class >> canBeRoot [

	^ true
]

{ #category : 'accessing' }
TBApplicationRootComponent class >> categoryName [

	^ #demo
]

{ #category : 'class initialization' }
TBApplicationRootComponent class >> initialize [
	"self initialize"

	| app |
	app := WAAdmin register: self asApplicationAt: self applicationPath.
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
account: ref(null),
password: ref(null),
myAuthDialog: ref(false)'
]

{ #category : 'rendering' }
TBApplicationRootComponent >> renderLayoutOn: html [

	html qApp
		id: self appId;
		with: [
			html qLayout
				view: 'hHh lpR fFf';
				vCloak;
				with: [ html render: main ] ]
]

{ #category : 'updating' }
TBApplicationRootComponent >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.
	anHtmlRoot beHtml5.
	anHtmlRoot title: 'TinyBlog'
]
