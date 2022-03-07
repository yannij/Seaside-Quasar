Class {
	#name : #QuasarToolbarTitle,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarToolbarTitle >> shrink [
	
	self attributes at: 'shrink' put: true
]

{ #category : #accessing }
QuasarToolbarTitle >> tag [

	^ 'q-toolbar-title'
]
