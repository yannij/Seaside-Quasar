Class {
	#name : 'TBAuthentificationComponent',
	#superclass : 'WAComponent',
	#instVars : [
		'password',
		'account',
		'component'
	],
	#category : 'Quasar-Demo-TinyBlog-Components',
	#package : 'Quasar-Demo',
	#tag : 'TinyBlog-Components'
}

{ #category : 'instance creation' }
TBAuthentificationComponent class >> from: aComponent [

	^ self new
		  component: aComponent;
		  yourself
]

{ #category : 'accessing' }
TBAuthentificationComponent >> account [

	^ account
]

{ #category : 'accessing' }
TBAuthentificationComponent >> account: anObject [

	account := anObject
]

{ #category : 'accessing' }
TBAuthentificationComponent >> component [

	^ component
]

{ #category : 'accessing' }
TBAuthentificationComponent >> component: anObject [

	component := anObject
]

{ #category : 'accessing' }
TBAuthentificationComponent >> password [

	^ password
]

{ #category : 'accessing' }
TBAuthentificationComponent >> password: anObject [

	password := anObject
]

{ #category : 'rendering' }
TBAuthentificationComponent >> renderAccountFieldOn: html [

	html qInput
		label: 'Account';
		name: 'account';
		vModel: 'account';
		on: #account of: self
]

{ #category : 'rendering' }
TBAuthentificationComponent >> renderBodyOn: html [

	html qForm
		vOnSubmit: '$event.target.submit()';
		method: 'post';
		action: (html urlForAction: [ self validate ]);
		with: [
			html qCardSection with: [
				self renderAccountFieldOn: html.
				self renderPasswordFieldOn: html ].
			html qCardSection with: [
				self renderButtonsOn: html ] ]
]

{ #category : 'rendering' }
TBAuthentificationComponent >> renderButtonsOn: html [

	html qBtn noCaps
		label: 'Cancel';
		vOnClick: self vModelName, '=false'.

	html qBtn noCaps typeSubmit
		label: 'SignIn'
]

{ #category : 'rendering' }
TBAuthentificationComponent >> renderContentOn: html [

	html qDialog
		vModel: self vModelName;
		with: [
			html qCard class: 'q-pa-md'; with: [
					self renderHeaderOn: html.
					self renderBodyOn: html ].
			"html qCard class: 'q-pa-md'; with: [
					self renderHeaderOn: html.
					self renderNativeBodyOn: html ]" ]
]

{ #category : 'rendering' }
TBAuthentificationComponent >> renderHeaderOn: html [

	html div class: 'text-h6'; with:'Authentication'
]

{ #category : 'rendering' }
TBAuthentificationComponent >> renderNativeAccountFieldOn: html [

	html textInput on: #account of: self
]

{ #category : 'rendering' }
TBAuthentificationComponent >> renderNativeBodyOn: html [

	html form with: [
		self renderNativeAccountFieldOn: html.
		html break.
		self renderNativePasswordFieldOn: html.
		html break.
		self renderNativeButtonsOn: html ]
]

{ #category : 'rendering' }
TBAuthentificationComponent >> renderNativeButtonsOn: html [

	html qBtn noCaps
		label: 'Cancel';
		vOnClick: self vModelName, '=false'.

	html submitButton
		callback: [ self validate ];
		text: 'SignIn'
]

{ #category : 'rendering' }
TBAuthentificationComponent >> renderNativePasswordFieldOn: html [

	html textInput on: #password of: self
]

{ #category : 'rendering' }
TBAuthentificationComponent >> renderPasswordFieldOn: html [

	html qInput
		label: 'Password';
		name: 'password';
		vModel: 'password';
		on: #password of: self
]

{ #category : 'rendering' }
TBAuthentificationComponent >> vModelName [

	^ 'myAuthDialog'
]

{ #category : 'rendering' }
TBAuthentificationComponent >> validate [

	^ component
		  tryConnectionWithLogin: self account
		  andPassword: self password
]
