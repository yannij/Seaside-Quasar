Class {
	#name : 'QuasarDialog',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarDialog >> autoClose [
	
	self attributes at: 'auto-close' put: true
]

{ #category : 'attributes' }
QuasarDialog >> fullHeight [
	
	self attributes at: 'full-height' put: true
]

{ #category : 'attributes' }
QuasarDialog >> fullWidth [
	
	self attributes at: 'full-width' put: true
]

{ #category : 'attributes' }
QuasarDialog >> maximized [
	
	self attributes at: 'maximized' put: true
]

{ #category : 'attributes' }
QuasarDialog >> noBackdropDismiss [
	
	self attributes at: 'no-backdrop-dismiss' put: true
]

{ #category : 'attributes' }
QuasarDialog >> noEscDismiss [
	
	self attributes at: 'no-esc-dismiss' put: true
]

{ #category : 'attributes' }
QuasarDialog >> noFocus [
	
	self attributes at: 'no-focus' put: true
]

{ #category : 'attributes' }
QuasarDialog >> noRefocus [
	
	self attributes at: 'no-refocus' put: true
]

{ #category : 'attributes' }
QuasarDialog >> noRouteDismiss [
	
	self attributes at: 'no-route-dismiss' put: true
]

{ #category : 'attributes' }
QuasarDialog >> noShake [
	
	self attributes at: 'no-shake' put: true
]

{ #category : 'attributes' }
QuasarDialog >> persistent [
	
	self attributes at: 'persistent' put: true
]

{ #category : 'attributes' }
QuasarDialog >> position: anObject [
	
	self attributes at: 'position' put: anObject
]

{ #category : 'attributes' }
QuasarDialog >> seamless [
	
	self attributes at: 'seamless' put: true
]

{ #category : 'attributes' }
QuasarDialog >> square [
	
	self attributes at: 'square' put: true
]

{ #category : 'accessing' }
QuasarDialog >> tag [

	^ 'q-dialog'
]

{ #category : 'attributes' }
QuasarDialog >> transitionDuration: anObject [
	
	self attributes at: 'transition-duration' put: anObject
]

{ #category : 'attributes' }
QuasarDialog >> transitionHide: anObject [
	
	self attributes at: 'transition-hide' put: anObject
]

{ #category : 'attributes' }
QuasarDialog >> transitionShow: anObject [
	
	self attributes at: 'transition-show' put: anObject
]
