Class {
	#name : 'QuasarTr',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarTr >> noHover [
	
	self attributes at: 'no-hover' put: true
]

{ #category : 'attributes' }
QuasarTr >> props: anObject [

	self vBind: 'props' with: anObject
]

{ #category : 'accessing' }
QuasarTr >> tag [

	^ 'q-td'
]
