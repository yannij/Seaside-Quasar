Class {
	#name : 'QuasarCheckbox',
	#superclass : 'QuasarFormComponent',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarCheckbox >> color: anObject [

	self attributes at: 'color' put: anObject
]

{ #category : 'attributes' }
QuasarCheckbox >> dark [
	
	self attributes at: 'dark' put: true
]

{ #category : 'attributes' }
QuasarCheckbox >> disable [
	
	self attributes at: 'disable' put: true
]

{ #category : 'attributes' }
QuasarCheckbox >> falseValue: anObject [

	self attributes at: 'false-value' put: anObject
]

{ #category : 'attributes' }
QuasarCheckbox >> label: anObject [

	self attributes at: 'label' put: anObject
]

{ #category : 'attributes' }
QuasarCheckbox >> leftLabel [
	
	self attributes at: 'left-label' put: true
]

{ #category : 'attributes' }
QuasarCheckbox >> name: anObject [

	self attributes at: 'name' put: anObject
]

{ #category : 'attributes' }
QuasarCheckbox >> size: anObject [

	self attributes at: 'size' put: anObject
]

{ #category : 'accessing' }
QuasarCheckbox >> tag [

	^ 'q-checkbox'
]

{ #category : 'attributes' }
QuasarCheckbox >> trueValue: anObject [

	self attributes at: 'true-value' put: anObject
]
