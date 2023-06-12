Class {
	#name : #QuasarTag,
	#superclass : #WATagBrush,
	#category : #'Quasar-Components'
}

{ #category : #'accessing - view style' }
QuasarTag >> dense [
	"Subclass would override, if supported"
]

{ #category : #'accessing - view style' }
QuasarTag >> dense: aBoolean [
	"Not supported by all subclasses. See #dense and #denseIf:"
	
	self attributes at: 'dense' put: aBoolean
]

{ #category : #'accessing - view style' }
QuasarTag >> denseIf: aBoolean [

	self viewStyle: #dense if: aBoolean
]

{ #category : #'accessing - view style' }
QuasarTag >> filledIf: aBoolean [

	self viewStyle: #filled if: aBoolean
]

{ #category : #'accessing - view style' }
QuasarTag >> flatIf: aBoolean [

	self viewStyle: #flat if: aBoolean
]

{ #category : #'vue special attributes' }
QuasarTag >> key: anObject [
	
	self attributes at: ':key' put: anObject
]

{ #category : #attributes }
QuasarTag >> modelValue: anObject [
	"Set model-value using direct assignment"
	"Note that some subclasses do not support model-value,
	so refer to Quasar docs"

	self attributes at: 'model-value' put: anObject
]

{ #category : #'accessing - view style' }
QuasarTag >> outlineIf: aBoolean [

	self viewStyle: #outline if: aBoolean
]

{ #category : #'accessing - view style' }
QuasarTag >> outlinedIf: aBoolean [

	self viewStyle: #outlined if: aBoolean
]

{ #category : #'vue special attributes' }
QuasarTag >> ref: anObject [
	
	self attributes at: 'ref' put: anObject
]

{ #category : #'accessing - view style' }
QuasarTag >> roundedIf: aBoolean [

	self viewStyle: #rounded if: aBoolean
]

{ #category : #attributes }
QuasarTag >> vModelValue: anObject [
	"Set model-value to a variable in our scope to allow dynamically changing it"
	"Note that some subclasses do not support model-value,
	so refer to Quasar docs"

	self vBind: 'model-value' with: anObject
]

{ #category : #attributes }
QuasarTag >> vOnUpdate: aString colon: aPropertyName [
	
	self attributes at: '@update:', aPropertyName put: aString
]

{ #category : #attributes }
QuasarTag >> vOnUpdateModelValue: aString [
	
	self attributes at: '@update:model-value' put: aString
]

{ #category : #'accessing - view style' }
QuasarTag >> viewStyle: aStyle if: aBoolean [

	aBoolean ifTrue: [
		self perform: aStyle ]
]
