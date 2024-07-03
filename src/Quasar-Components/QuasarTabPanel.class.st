Class {
	#name : 'QuasarTabPanel',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarTabPanel >> dark [
	
	self attributes at: 'dark' put: true
]

{ #category : 'attributes' }
QuasarTabPanel >> disable [
	
	self attributes at: 'disable' put: true
]

{ #category : 'attributes' }
QuasarTabPanel >> name: anObject [

	self attributes at: 'name' put: anObject
]

{ #category : 'accessing' }
QuasarTabPanel >> tag [

	^ 'q-tab-panel'
]
