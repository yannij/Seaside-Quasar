Class {
	#name : #QuasarBadge,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarBadge >> align: aString [
	
	self attributes at: 'align' put: aString
]

{ #category : #attributes }
QuasarBadge >> color: aString [
	
	self attributes at: 'color' put: aString
]

{ #category : #attributes }
QuasarBadge >> floating [
	
	self attributes at: 'floating' put: true
]

{ #category : #attributes }
QuasarBadge >> label: aString [
	
	self attributes at: 'label' put: aString
]

{ #category : #attributes }
QuasarBadge >> multiLine [
	
	self attributes at: 'multi-line' put: true
]

{ #category : #attributes }
QuasarBadge >> outline [
	
	self attributes at: 'outline' put: true
]

{ #category : #attributes }
QuasarBadge >> rounded [
	
	self attributes at: 'rounded' put: true
]

{ #category : #accessing }
QuasarBadge >> tag [

	^ 'q-badge'
]

{ #category : #attributes }
QuasarBadge >> textColor: aString [
	
	self attributes at: 'text-color' put: aString
]

{ #category : #attributes }
QuasarBadge >> transparent [
	
	self attributes at: 'transparent' put: true
]
