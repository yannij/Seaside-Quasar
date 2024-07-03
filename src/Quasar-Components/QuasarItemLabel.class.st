Class {
	#name : 'QuasarItemLabel',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarItemLabel >> caption [
	
	self attributes at: 'caption' put: true
]

{ #category : 'attributes' }
QuasarItemLabel >> header [
	
	self attributes at: 'header' put: true
]

{ #category : 'attributes' }
QuasarItemLabel >> lines: aString [
	
	self attributes at: 'lines' put: aString
]

{ #category : 'attributes' }
QuasarItemLabel >> overline [
	
	self attributes at: 'overline' put: true
]

{ #category : 'accessing' }
QuasarItemLabel >> tag [

	^ 'q-item-label'
]
