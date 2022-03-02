Class {
	#name : #QuasarTh,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarTh >> autoWidth [
	
	self attributes at: 'auto-width' put: true
]

{ #category : #attributes }
QuasarTh >> props: anObject [

	self vBind: 'props' with: anObject
]

{ #category : #accessing }
QuasarTh >> tag [

	^ 'q-td'
]
