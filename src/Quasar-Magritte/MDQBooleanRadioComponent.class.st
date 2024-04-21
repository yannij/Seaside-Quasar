Class {
	#name : #MDQBooleanRadioComponent,
	#superclass : #MDQRadioGroupComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQBooleanRadioComponent >> booleanValue [

	^ self value
]

{ #category : #rendering }
MDQBooleanRadioComponent >> booleanValue: aString [

	self value: (aString = self magritteDescription trueString)
]

{ #category : #rendering }
MDQBooleanRadioComponent >> inputAspect [

	^ #booleanValue
]

{ #category : #rendering }
MDQBooleanRadioComponent >> renderFieldOn: html readonly: aReadonlyFlag [
	| inputLabel modelName app fieldTag |

	app := self mdqApplicationGet.
	inputLabel := self magritteDescription label.
	modelName := inputLabel asCamelCase uncapitalized.

	fieldTag := html qField.
	self setFieldStyleOf: fieldTag.

	fieldTag
		"denseIf: true;"
		label: inputLabel withAsteriskIfRequired: self magritteDescription isRequired;
		vModel: modelName;
		with: [ super renderFieldOn: html readonly: aReadonlyFlag ]
]

{ #category : #rendering }
MDQBooleanRadioComponent >> valForOption: anOption [

	^ self labelForOption: anOption
]
