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
	| inputLabel modelName app |

	inputLabel := self magritteDescription label.
	modelName := inputLabel asCamelCase uncapitalized.
	app := self mdqApplicationGet.

	html qField
		filledIf: app viewStyleFilled;
		outlinedIf: app viewStyleOutlined;
		denseIf: "app viewStyleDense" true;
		label: inputLabel;
		vModel: modelName;
		with: [ super renderFieldOn: html readonly: aReadonlyFlag ]
]

{ #category : #rendering }
MDQBooleanRadioComponent >> valForOption: anOption [

	^ self labelForOption: anOption
]
