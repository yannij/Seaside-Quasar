Class {
	#name : 'QuasarForm',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarForm >> action: aString [
	
	self attributes at: 'action' put: aString
]

{ #category : 'attributes' }
QuasarForm >> autofocus [
	
	self attributes at: 'autofocus' put: true
]

{ #category : 'attributes' }
QuasarForm >> enctype: aString [
	
	self attributes at: 'enctype' put: aString
]

{ #category : 'attributes' }
QuasarForm >> greedy [
	
	self attributes at: 'greedy' put: true
]

{ #category : 'attributes' }
QuasarForm >> method: aString [
	
	self attributes at: 'method' put: aString
]

{ #category : 'attributes' }
QuasarForm >> noErrorfocus [
	
	self attributes at: 'no-error-focus' put: true
]

{ #category : 'attributes' }
QuasarForm >> noResetfocus [
	
	self attributes at: 'no-reset-focus' put: true
]

{ #category : 'accessing' }
QuasarForm >> tag [

	^ 'q-form'
]

{ #category : 'attributes' }
QuasarForm >> target: aString [
	
	self attributes at: 'target' put: aString
]

{ #category : 'attributes' }
QuasarForm >> vOnReset: aString [
	
	self attributes at: '@reset' put: aString
]

{ #category : 'attributes' }
QuasarForm >> vOnSubmit: aString [
	
	self attributes at: '@submit' put: aString
]
