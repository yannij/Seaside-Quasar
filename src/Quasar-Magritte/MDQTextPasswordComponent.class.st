Class {
	#name : #MDQTextPasswordComponent,
	#superclass : #MATextPasswordComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQTextPasswordComponent >> htmlIdPassword [

	^ self ajaxId, '-password'
]

{ #category : #rendering }
MDQTextPasswordComponent >> inputAspect [

	^ #string
]

{ #category : #rendering }
MDQTextPasswordComponent >> inputType [

	^ 'password'
]

{ #category : #rendering }
MDQTextPasswordComponent >> renderEditorOn: html [

	self renderFieldOn: html readonly: false

]

{ #category : #rendering }
MDQTextPasswordComponent >> renderFieldOn: html readonly: aReadonlyFlag [
	| element |

	element := html label.
	self magritteDescription currentCssClasses do: [ :eachCssClass | element class: eachCssClass ].
	element
		with: [
			html span
				id: self labelId;
				with: self magritteDescription label.
			html passwordInput
				id: self htmlIdPassword;
				readonly: aReadonlyFlag;
				on: self inputAspect of: self ]
]

{ #category : #rendering }
MDQTextPasswordComponent >> renderViewerOn: html [

	self renderFieldOn: html readonly: true

]
