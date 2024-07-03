Class {
	#name : 'QuasarAvatar',
	#superclass : 'QuasarTag',
	#category : 'Quasar-Components',
	#package : 'Quasar-Components'
}

{ #category : 'attributes' }
QuasarAvatar >> color: aString [
	
	self attributes at: 'color' put: aString
]

{ #category : 'attributes' }
QuasarAvatar >> fontSize: aString [
	
	self attributes at: 'font-size' put: aString
]

{ #category : 'attributes' }
QuasarAvatar >> icon: aString [
	
	self attributes at: 'icon' put: aString
]

{ #category : 'attributes' }
QuasarAvatar >> rounded [
	
	self attributes at: 'rounded' put: true
]

{ #category : 'attributes' }
QuasarAvatar >> size: aString [
	
	self attributes at: 'size' put: aString
]

{ #category : 'attributes' }
QuasarAvatar >> square [
	
	self attributes at: 'square' put: true
]

{ #category : 'accessing' }
QuasarAvatar >> tag [

	^ 'q-avatar'
]

{ #category : 'attributes' }
QuasarAvatar >> textColor: aString [
	
	self attributes at: 'text-color' put: aString
]
