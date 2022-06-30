Class {
	#name : #QuasarSplitter,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarSplitter >> afterClass: anObject [

	self attributes at: 'after-class' put: anObject
]

{ #category : #attributes }
QuasarSplitter >> beforeClass: anObject [

	self attributes at: 'before-class' put: anObject
]

{ #category : #attributes }
QuasarSplitter >> dark [
	
	self attributes at: 'dark' put: true
]

{ #category : #attributes }
QuasarSplitter >> disable [
	
	self attributes at: 'disable' put: true
]

{ #category : #attributes }
QuasarSplitter >> emitImmediately [
	
	self attributes at: 'emit-immediately' put: true
]

{ #category : #attributes }
QuasarSplitter >> horizontal [
	
	self attributes at: 'horizontal' put: true
]

{ #category : #attributes }
QuasarSplitter >> limits: anObject [

	self attributes at: 'limits' put: anObject
]

{ #category : #attributes }
QuasarSplitter >> reverse [
	
	self attributes at: 'reverse' put: true
]

{ #category : #attributes }
QuasarSplitter >> separatorClass: anObject [

	self attributes at: 'separator-class' put: anObject
]

{ #category : #attributes }
QuasarSplitter >> separatorStyle: anObject [

	self attributes at: 'separator-style' put: anObject
]

{ #category : #accessing }
QuasarSplitter >> tag [

	^ 'q-splitter'
]

{ #category : #attributes }
QuasarSplitter >> unit: anObject [

	self attributes at: 'unit' put: anObject
]
