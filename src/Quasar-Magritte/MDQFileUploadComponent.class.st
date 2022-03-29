Class {
	#name : #MDQFileUploadComponent,
	#superclass : #MAFileUploadComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQFileUploadComponent >> inputAspect [

	^ #string
]

{ #category : #rendering }
MDQFileUploadComponent >> renderEditorOn: html [

	self renderFieldOn: html readonly: false
]

{ #category : #rendering }
MDQFileUploadComponent >> renderFieldOn: html readonly: aReadonlyFlag [
	| inputTag inputLabel inputValue app |

	app := self mdqApplicationGet.
	inputLabel := self magritteDescription label.
	inputValue := self perform: self inputAspect.

	inputTag := html qFile.
	self setFieldStyleOf: inputTag.
	inputTag label: inputLabel.

	aReadonlyFlag
		ifTrue: [
			inputTag readonly: true; modelValue: inputValue ]
		ifFalse: [ | modelName |
			modelName := inputLabel asCamelCase uncapitalized.
			app vueRefsAdd: modelName -> inputValue.
			inputTag
				"name: modelName;" vModel: modelName;
				on: self inputAspect of: self;
				with: [ self renderTemplateOn: html vModel: modelName ]
		]
]

{ #category : #rendering }
MDQFileUploadComponent >> renderTemplateOn: html vModel: aName [
	"Subclasses may enhance"
]

{ #category : #rendering }
MDQFileUploadComponent >> renderViewerOn: html [

	self renderFieldOn: html readonly: true
]
