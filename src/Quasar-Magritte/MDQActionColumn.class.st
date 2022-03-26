Class {
	#name : #MDQActionColumn,
	#superclass : #MAActionColumn,
	#instVars : [
		'commandBlock'
	],
	#category : #'Quasar-Magritte'
}

{ #category : #accessing }
MDQActionColumn >> commandBlock [
	^ commandBlock
]

{ #category : #accessing }
MDQActionColumn >> commandBlock: anObject [
	commandBlock := anObject
]

{ #category : #rendering }
MDQActionColumn >> renderCellFormContent: anObject on: html [

	html submitButton
		callback: [ self commandBlock value: anObject ];
		text: '>'
]

{ #category : #rendering }
MDQActionColumn >> renderCellLinkContent: anObject on: html [

	"html anchor
		callback: [ self commandBlock value: anObject ];
		with: '>'"

	html qBtn
		onClick: ((html jQuery ajax)
			callback: [ self commandBlock value: anObject ];
			onComplete: html javascript refresh);
		icon: 'chevron_right'
]
