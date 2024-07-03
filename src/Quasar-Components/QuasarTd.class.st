Class {
	#name : 'QuasarTd',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarTd >> autoWidth [
	
	self attributes at: 'auto-width' put: true
]

{ #category : 'attributes' }
QuasarTd >> noHover [
	
	self attributes at: 'no-hover' put: true
]

{ #category : 'attributes' }
QuasarTd >> props: anObject [

	self vBind: 'props' with: anObject
]

{ #category : 'accessing' }
QuasarTd >> tag [

	^ 'q-td'
]
