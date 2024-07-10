Class {
	#name : 'TB2PublicHeaderComponent',
	#superclass : 'TB2HeaderComponent',
	#category : 'Quasar-Demo-TinyBlog2-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog2-Components'
}

{ #category : 'rendering' }
TB2PublicHeaderComponent >> renderButtonsOn: html [

	self session isLogged
		ifTrue: [ self renderSimpleAdminButtonOn: html ]
		ifFalse: [ self renderModalLoginButtonOn: html ]
]

{ #category : 'rendering' }
TB2PublicHeaderComponent >> renderModalLoginButtonOn: html [

	html render: (TBAuthentificationComponent from: component).
	html qBtn push
		icon: 'lock';
		label: 'Login';
		vOnClick: 'myAuthDialog = true'
]

{ #category : 'rendering' }
TB2PublicHeaderComponent >> renderSimpleAdminButtonOn: html [

	html qBtn
		href: (html urlForAction: [ component goToAdministrationView ]);
		icon: 'list';
		label: 'Admin View'
]
