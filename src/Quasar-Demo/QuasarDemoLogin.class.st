Class {
	#name : #QuasarDemoLogin,
	#superclass : #WAComponent,
	#instVars : [
		'username',
		'password',
		'message'
	],
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #initialization }
QuasarDemoLogin >> initialize [

	super initialize.

	self username: 'tu1@test.co'
]

{ #category : #accessing }
QuasarDemoLogin >> message [

	^ message
]

{ #category : #accessing }
QuasarDemoLogin >> message: anObject [

	message := anObject
]

{ #category : #accessing }
QuasarDemoLogin >> password [

	^ password
]

{ #category : #accessing }
QuasarDemoLogin >> password: anObject [

	password := anObject
]

{ #category : #rendering }
QuasarDemoLogin >> renderContentOn: html [

	html div class: 'row justify-center'; style: 'height: 100vh; align-items: center'; with: [
		html div class: 'col-xs-12 col-sm-8 col-md-4'; with: [
			html div class: 'q-pa-md'; with: [
				self renderLoginFormOn: html ] ] ]
]

{ #category : #rendering }
QuasarDemoLogin >> renderField: aLabel type: anInputType for: anAspect on: html [

	html qField
		filled; stackLabel;
		label: aLabel;
		with: [
			html textInput
				style: 'width: 100%; outline: none; border: none; border-color: transparent; background: inherit';
				type: anInputType;
				on: anAspect of: self ]
]

{ #category : #rendering }
QuasarDemoLogin >> renderLoginFormOn: html [

	html qForm
		vOnSubmit: '$event.target.submit()';
		method: 'post';
		action: (html urlForAction: [ self tryLogin ]);
		with: [
			html div class: 'column q-gutter-md'; with: [
				html div class: 'text-h6 text-center'; with: self mdqApplicationGet applicationTitle.
				html div with: 'Login'.
				self renderField: 'Enter email (e.g. tu1@test.co)' type: 'text' for: #username on: html.
				self renderField: 'Enter password' type: 'text' for: #password on: html.
				html div class: 'text-right';  with: [  	
					html qBtn flat; round; type: 'reset'; icon: 'cancel'.
					html qBtn flat; round; type: 'submit'; icon: 'done' ].
				html div with: self message ] ]
]

{ #category : #rendering }
QuasarDemoLogin >> tryLogin [ 

	"Transcript crShow: 'triggered: ', DateAndTime now asFileNameCompatibleString, ', username:', self username, ', password: ', self password."
	self username ifNotNil: [ :value |
		value ifNotEmpty: [
			| user |
			user := self qdemoApp repository selectOne: QuasarDemoAccountingUser where: [ :each | each email = value ].
			user
				ifNil: [
					self message: 'User not found' ]
				ifNotNil: [
					self message: nil.
					self password: nil. "Don't leave password in image memory"
					self mdqApplicationGet userSet: user ] ] ]
]

{ #category : #accessing }
QuasarDemoLogin >> username [

	^ username
]

{ #category : #accessing }
QuasarDemoLogin >> username: anObject [

	username := anObject
]
