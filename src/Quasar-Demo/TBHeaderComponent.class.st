Class {
	#name : 'TBHeaderComponent',
	#superclass : 'WAComponent',
	#instVars : [
		'component'
	],
	#category : 'Quasar-Demo-TinyBlog-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog-Components'
}

{ #category : 'instance creation' }
TBHeaderComponent class >> from: aComponent [

	^ self new
		  component: aComponent;
		  yourself
]

{ #category : 'accessing' }
TBHeaderComponent >> component [

	^ component
]

{ #category : 'accessing' }
TBHeaderComponent >> component: anObject [

	component := anObject
]

{ #category : 'rendering' }
TBHeaderComponent >> renderButtonsOn: html [
	"self renderSimpleAdminButtonOn: html"

	self session isLogged
		ifTrue: [ self renderSimpleAdminButtonOn: html ]
		ifFalse: [ self renderModalLoginButtonOn: html ]
]

{ #category : 'rendering' }
TBHeaderComponent >> renderContentOn: html [

	html qHeader
		elevated;
		heightHint: 98;
		class: 'bg-primary text-white';
		with: [
			html qToolbar with: [
					html qToolbarTitle with: [ html text: 'TinyBlog' ].
					self renderButtonsOn: html ] ]
]

{ #category : 'rendering' }
TBHeaderComponent >> renderModalLoginButtonOn: html [

	html render: (TBAuthentificationComponent from: component).
	html qBtn push
		icon: 'lock';
		label: 'Login';
		vOnClick: 'myAuthDialog = true'
]

{ #category : 'rendering' }
TBHeaderComponent >> renderSimpleAdminButtonOn: html [

	html qBtn
		href: (html urlForAction: [ component goToAdministrationView ]);
		icon: 'list';
		label: 'Admin View'
]
