Class {
	#name : 'MDQListItemLabel',
	#superclass : 'QuasarComponent',
	#instVars : [
		'content',
		'caption',
		'header',
		'lines',
		'overline'
	],
	#category : 'Quasar-Magritte',
	#package : 'Quasar-Magritte'
}

{ #category : 'accessing' }
MDQListItemLabel >> caption [

	^ caption
]

{ #category : 'accessing' }
MDQListItemLabel >> caption: anObject [

	caption := anObject
]

{ #category : 'accessing' }
MDQListItemLabel >> content [

	^ content
]

{ #category : 'accessing' }
MDQListItemLabel >> content: anObject [

	content := anObject
]

{ #category : 'accessing' }
MDQListItemLabel >> header [

	^ header
]

{ #category : 'accessing' }
MDQListItemLabel >> header: anObject [

	header := anObject
]

{ #category : 'initialization' }
MDQListItemLabel >> initialize [

	super initialize.

	self caption: false.
	self header: false.
	self overline: false
]

{ #category : 'accessing' }
MDQListItemLabel >> lines [

	^ lines
]

{ #category : 'accessing' }
MDQListItemLabel >> lines: anObject [

	lines := anObject
]

{ #category : 'accessing' }
MDQListItemLabel >> overline [

	^ overline
]

{ #category : 'accessing' }
MDQListItemLabel >> overline: anObject [

	overline := anObject
]

{ #category : 'rendering' }
MDQListItemLabel >> renderContentOn: html [
	| tag |

	tag := html qItemLabel.

	self caption ifTrue: [ tag caption ].
	self header ifTrue: [ tag header ].
	self overline ifTrue: [ tag overline ].

	self lines ifNotNil: [ :value | tag lines: value ].

	tag with: [ html render: self content ]
]
