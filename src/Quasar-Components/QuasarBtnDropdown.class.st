Class {
	#name : 'QuasarBtnDropdown',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarBtnDropdown >> align: anObject [

	self attributes at: 'align' put: anObject
]

{ #category : 'attributes' }
QuasarBtnDropdown >> autoClose [

	self attributes at: 'auto-close' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> color: aString [
	
	self attributes at: 'color' put: aString
]

{ #category : 'attributes' }
QuasarBtnDropdown >> contentClass: aString [
	
	self attributes at: 'content-class' put: aString
]

{ #category : 'attributes' }
QuasarBtnDropdown >> contentStyle: aString [
	
	self attributes at: 'content-style' put: aString
]

{ #category : 'attributes' }
QuasarBtnDropdown >> cover [

	self attributes at: 'cover' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> dense [

	self attributes at: 'dense' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> disable [

	self attributes at: 'disable' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> disableDropdown [

	self attributes at: 'disable-dropdown' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> disableMainBtn [

	self attributes at: 'disable-main-btn' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> dropdownIcon: aString [
	
	self attributes at: 'dropdown-icon' put: aString
]

{ #category : 'attributes' }
QuasarBtnDropdown >> fab [

	self attributes at: 'fab' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> fabMini [

	self attributes at: 'fab-mini' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> flat [

	self attributes at: 'flat' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> glossy [

	self attributes at: 'glossy' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> href: aString [
	
	self attributes at: 'href' put: aString
]

{ #category : 'attributes' }
QuasarBtnDropdown >> icon: aString [
	
	self attributes at: 'icon' put: aString
]

{ #category : 'attributes' }
QuasarBtnDropdown >> iconRight: aString [
	
	self attributes at: 'icon-right' put: aString
]

{ #category : 'attributes' }
QuasarBtnDropdown >> label: anObject [

	self attributes at: 'label' put: anObject
]

{ #category : 'attributes' }
QuasarBtnDropdown >> loading [

	self attributes at: 'loading' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> menuAnchor: aString [
	
	self attributes at: 'menu-anchor' put: aString
]

{ #category : 'attributes' }
QuasarBtnDropdown >> menuOffset: aString [
	
	self attributes at: 'menu-offset' put: aString
]

{ #category : 'attributes' }
QuasarBtnDropdown >> menuSelf: aString [
	
	self attributes at: 'menu-self' put: aString
]

{ #category : 'attributes' }
QuasarBtnDropdown >> noCaps [
	
	self attributes at: 'no-caps' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> noIconAnimation [

	self attributes at: 'no-icon-animation' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> noRouteDismiss [

	self attributes at: 'no-route-dismiss' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> noWrap [

	self attributes at: 'no-wrap' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> outline [

	self attributes at: 'outline' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> padding: aString [
	
	self attributes at: 'padding' put: aString
]

{ #category : 'attributes' }
QuasarBtnDropdown >> persistent [

	self attributes at: 'persistent' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> push [

	self attributes at: 'push' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> replace [

	self attributes at: 'replace' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> ripple [

	self attributes at: 'ripple' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> rounded [

	self attributes at: 'rounded' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> size: aString [
	
	self attributes at: 'size' put: aString
]

{ #category : 'attributes' }
QuasarBtnDropdown >> split [

	self attributes at: 'split' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> square [

	self attributes at: 'square' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> stack [

	self attributes at: 'stack' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> stretch [

	self attributes at: 'stretch' put: true
]

{ #category : 'attributes' }
QuasarBtnDropdown >> tabindex: aString [
	
	self attributes at: 'tabindex' put: aString
]

{ #category : 'accessing' }
QuasarBtnDropdown >> tag [

	^ 'q-btn-dropdown'
]

{ #category : 'attributes' }
QuasarBtnDropdown >> target: aString [
	
	self attributes at: 'target' put: aString
]

{ #category : 'attributes' }
QuasarBtnDropdown >> textColor: aString [
	
	self attributes at: 'text-color' put: aString
]

{ #category : 'attributes' }
QuasarBtnDropdown >> to: aString [
	
	self attributes at: 'to' put: aString
]

{ #category : 'attributes' }
QuasarBtnDropdown >> transitionDuration: aString [
	
	self attributes at: 'transition-hide' put: aString
]

{ #category : 'attributes' }
QuasarBtnDropdown >> transitionHide: aString [
	
	self attributes at: 'transition-hide' put: aString
]

{ #category : 'attributes' }
QuasarBtnDropdown >> transitionShow: aString [
	
	self attributes at: 'transition-show' put: aString
]

{ #category : 'attributes' }
QuasarBtnDropdown >> type: aString [
	
	self attributes at: 'type' put: aString
]

{ #category : 'attributes' }
QuasarBtnDropdown >> unelevated: aString [
	
	self attributes at: 'unelevated' put: aString
]
