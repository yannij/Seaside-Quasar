Class {
	#name : 'QuasarBtn',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarBtn >> align: aString [
	
	self attributes at: 'align' put: aString
]

{ #category : 'attributes' }
QuasarBtn >> color: aString [
	
	self attributes at: 'color' put: aString
]

{ #category : 'attributes' }
QuasarBtn >> dense [
	
	self attributes at: 'dense' put: true
]

{ #category : 'attributes' }
QuasarBtn >> disable [
	
	self attributes at: 'disable' put: true
]

{ #category : 'attributes' }
QuasarBtn >> disable: aBoolean [
	
	self attributes at: 'disable' put: aBoolean
]

{ #category : 'attributes' }
QuasarBtn >> fab [
	
	self attributes at: 'fab' put: true
]

{ #category : 'attributes' }
QuasarBtn >> fabMini [
	
	self attributes at: 'fab-mini' put: true
]

{ #category : 'attributes' }
QuasarBtn >> flat [
	
	self attributes at: 'flat' put: true
]

{ #category : 'attributes' }
QuasarBtn >> glossy [
	
	self attributes at: 'glossy' put: true
]

{ #category : 'attributes' }
QuasarBtn >> href: aString [
	
	self attributes at: 'href' put: aString
]

{ #category : 'attributes' }
QuasarBtn >> icon: aString [
	
	self attributes at: 'icon' put: aString
]

{ #category : 'attributes' }
QuasarBtn >> iconRight: aString [
	
	self attributes at: 'icon-right' put: aString
]

{ #category : 'attributes' }
QuasarBtn >> label: aString [
	
	self attributes at: 'label' put: aString
]

{ #category : 'attributes' }
QuasarBtn >> noCaps [
	
	self attributes at: 'no-caps' put: true
]

{ #category : 'attributes' }
QuasarBtn >> noWrap [
	
	self attributes at: 'no-wrap' put: true
]

{ #category : 'attributes' }
QuasarBtn >> outline [
	
	self attributes at: 'outline' put: true
]

{ #category : 'attributes' }
QuasarBtn >> padding: aString [
	
	self attributes at: 'padding' put: aString
]

{ #category : 'attributes' }
QuasarBtn >> push [
	
	self attributes at: 'push' put: true
]

{ #category : 'attributes' }
QuasarBtn >> ripple [
	
	self attributes at: 'ripple' put: true
]

{ #category : 'attributes' }
QuasarBtn >> round [
	
	self attributes at: 'round' put: true
]

{ #category : 'attributes' }
QuasarBtn >> rounded [
	
	self attributes at: 'rounded' put: true
]

{ #category : 'attributes' }
QuasarBtn >> size: aString [
	
	self attributes at: 'size' put: aString
]

{ #category : 'attributes' }
QuasarBtn >> square [
	
	self attributes at: 'square' put: true
]

{ #category : 'attributes' }
QuasarBtn >> stack [
	
	self attributes at: 'stack' put: true
]

{ #category : 'accessing' }
QuasarBtn >> tag [

	^ 'q-btn'
]

{ #category : 'attributes' }
QuasarBtn >> textColor: aString [
	
	self attributes at: 'text-color' put: aString
]

{ #category : 'attributes' }
QuasarBtn >> to: aStringOrJsonObject [
	
	self attributes at: 'to' put: aStringOrJsonObject
]

{ #category : 'attributes' }
QuasarBtn >> type: aString [
	
	self attributes at: 'type' put: aString
]

{ #category : 'attributes' }
QuasarBtn >> typeButton [

	self type: 'button'
]

{ #category : 'attributes' }
QuasarBtn >> typeReset [

	self type: 'reset'
]

{ #category : 'attributes' }
QuasarBtn >> typeSubmit [

	self type: 'submit'
]

{ #category : 'attributes' }
QuasarBtn >> unelevated [
	
	self attributes at: 'unelevated' put: true
]
