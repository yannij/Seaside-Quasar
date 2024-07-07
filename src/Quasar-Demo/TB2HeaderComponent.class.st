Class {
	#name : 'TB2HeaderComponent',
	#superclass : 'WAComponent',
	#instVars : [
		'component'
	],
	#category : 'Quasar-Demo-TinyBlog2-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog2-Components'
}

{ #category : 'instance creation' }
TB2HeaderComponent class >> from: aComponent [

	^ self new
		  component: aComponent;
		  yourself
]

{ #category : 'accessing' }
TB2HeaderComponent >> component [

	^ component
]

{ #category : 'accessing' }
TB2HeaderComponent >> component: anObject [

	component := anObject
]

{ #category : 'rendering' }
TB2HeaderComponent >> renderButtonsOn: html [

	self session isLogged
		ifTrue: [ self renderSimpleAdminButtonOn: html ]
		ifFalse: [ self renderModalLoginButtonOn: html ]
]

{ #category : 'rendering' }
TB2HeaderComponent >> renderContentOn: html [

	html qHeader
		elevated;
		heightHint: 98;
		class: 'bg-primary text-white';
		with: [
			html qToolbar with: [
					html qToolbarTitle with: [ html text: 'Blog2' ].
					self renderButtonsOn: html ] ]
]

{ #category : 'rendering' }
TB2HeaderComponent >> renderModalLoginButtonOn: html [

	html render: (TBAuthentificationComponent from: component).
	html qBtn push
		icon: 'lock';
		label: 'Login';
		vOnClick: 'myAuthDialog = true'
]

{ #category : 'rendering' }
TB2HeaderComponent >> renderSimpleAdminButtonOn: html [

	html qBtn
		href: (html urlForAction: [ component goToAdministrationView ]);
		icon: 'list';
		label: 'Admin View'
]
