Class {
	#name : 'MDQListItem',
	#superclass : 'QuasarComponent',
	#instVars : [
		'label',
		'icon',
		'callbackBlock',
		'active',
		'insetLevel'
	],
	#category : 'Quasar-Magritte',
	#package : 'Quasar-Magritte'
}

{ #category : 'instance creation' }
MDQListItem class >> iconName: aMaterialIconName itemText: aString callback: aBlock [

	^ self label: aString icon: aMaterialIconName callback: aBlock
]

{ #category : 'instance creation' }
MDQListItem class >> itemText: aString [

	^ self label: aString icon: nil callback: nil
]

{ #category : 'instance creation' }
MDQListItem class >> itemText: aString callback: aBlock [

	^ self label: aString icon: nil callback: aBlock
]

{ #category : 'instance creation' }
MDQListItem class >> itemText: aString iconName: aMaterialIconName callback: aBlock [

	^ self label: aString icon: aMaterialIconName callback: aBlock
]

{ #category : 'instance creation' }
MDQListItem class >> label: aString [

	^ self label: aString icon: nil callback: nil
]

{ #category : 'instance creation' }
MDQListItem class >> label: aString callback: aBlock [

	^ self label: aString icon: nil callback: aBlock
]

{ #category : 'instance creation' }
MDQListItem class >> label: aString icon: anIconName [

	^ self label: aString icon: anIconName callback: nil
]

{ #category : 'instance creation' }
MDQListItem class >> label: aString icon: anIconName callback: aBlock [

	^ self new
		label: aString;
		icon: anIconName;
		callbackBlock: aBlock;
		yourself
]

{ #category : 'accessing' }
MDQListItem >> active [

	^ active
]

{ #category : 'accessing' }
MDQListItem >> active: anObject [

	active := anObject
]

{ #category : 'accessing' }
MDQListItem >> callbackBlock [

	^ callbackBlock
]

{ #category : 'accessing' }
MDQListItem >> callbackBlock: anObject [

	callbackBlock := anObject
]

{ #category : 'accessing' }
MDQListItem >> icon [

	^ icon
]

{ #category : 'accessing' }
MDQListItem >> icon: anObject [

	icon := anObject
]

{ #category : 'initialization' }
MDQListItem >> initialize [

	super initialize.

	self active: false
]

{ #category : 'accessing' }
MDQListItem >> insetLevel [

	^ insetLevel
]

{ #category : 'accessing' }
MDQListItem >> insetLevel: anObject [

	insetLevel := anObject
]

{ #category : 'accessing' }
MDQListItem >> label [

	^ label
]

{ #category : 'accessing' }
MDQListItem >> label: anObject [

	label := anObject
]

{ #category : 'rendering' }
MDQListItem >> renderContentOn: html [

	self renderListItemOn: html
]

{ #category : 'rendering' }
MDQListItem >> renderListItemOn: html [
	| itemTag |

	itemTag := html qItem.

	self callbackBlock ifNotNil: [ :aBlock |
		itemTag qTag: 'a'; href: (html urlForAction: aBlock) ].

	self insetLevel ifNotNil: [ :aBlock |
		itemTag insetLevel: self insetLevel ].

	itemTag
		id: html nextId;
		"callback: self callbackBlock if: self callbackBlock notNil;"
		with: [
			self icon ifNotNil: [ :value | html qItemSection avatar; with: [ html qIcon name: value ] ].
			html qItemSection with: self label ]
]
