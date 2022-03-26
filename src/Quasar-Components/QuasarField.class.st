Class {
	#name : #QuasarField,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarField >> autofocus [

	self attributes at: 'autofocus' put: true
]

{ #category : #attributes }
QuasarField >> bgColor: anObject [

	self attributes at: 'bg-color' put: anObject
]

{ #category : #attributes }
QuasarField >> borderless [

	self attributes at: 'borderless' put: true
]

{ #category : #attributes }
QuasarField >> clearable [

	self attributes at: 'clearable' put: true
]

{ #category : #attributes }
QuasarField >> color: anObject [

	self attributes at: 'color' put: anObject
]

{ #category : #attributes }
QuasarField >> dark [


	self attributes at: 'dark' put: true
]

{ #category : #attributes }
QuasarField >> dense [

	self attributes at: 'dense' put: true
]

{ #category : #attributes }
QuasarField >> disable [

	self attributes at: 'disable' put: true
]

{ #category : #attributes }
QuasarField >> filled [


	self attributes at: 'filled' put: true
]

{ #category : #attributes }
QuasarField >> for: anObject [

	self attributes at: 'for' put: anObject
]

{ #category : #attributes }
QuasarField >> hideBottomSpace [

	self attributes at: 'hide-bottom-space' put: true
]

{ #category : #attributes }
QuasarField >> hint: anObject [

	self attributes at: 'hint' put: anObject
]

{ #category : #attributes }
QuasarField >> itemAligned [

	self attributes at: 'item-aligned' put: true
]

{ #category : #attributes }
QuasarField >> label: anObject [

	self attributes at: 'label' put: anObject
]

{ #category : #attributes }
QuasarField >> labelColor: anObject [

	self attributes at: 'label-color' put: anObject
]

{ #category : #attributes }
QuasarField >> maxlength: anObject [

	self attributes at: 'maxlength' put: anObject
]

{ #category : #attributes }
QuasarField >> modelValue: anObject [

	self attributes at: ':model-value' put: anObject
]

{ #category : #attributes }
QuasarField >> name: anObject [

	self attributes at: 'name' put: anObject
]

{ #category : #attributes }
QuasarField >> outlined [


	self attributes at: 'outlined' put: true
]

{ #category : #attributes }
QuasarField >> readonly [

	self attributes at: 'readonly' put: true
]

{ #category : #attributes }
QuasarField >> rounded [

	self attributes at: 'rounded' put: true
]

{ #category : #attributes }
QuasarField >> square [

	self attributes at: 'square' put: true
]

{ #category : #attributes }
QuasarField >> stackLabel [
	
	self attributes at: 'stack-label' put: true
]

{ #category : #attributes }
QuasarField >> standout [

	self attributes at: 'standout' put: true
]

{ #category : #attributes }
QuasarField >> standout: anObject [

	self attributes at: 'standout' put: anObject
]

{ #category : #accessing }
QuasarField >> tag [

	^ 'q-field'
]
