Class {
	#name : #MDQDateComponent,
	#superclass : #MDQTextInputComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #accessing }
MDQDateComponent >> dateHtml5 [

	^ self value
		ifNil: [ Date today yyyymmdd ]
		ifNotNil: [ :t | t isString ifTrue: [ t asDate ] ifFalse: [ t asDate yyyymmdd ] ]

]

{ #category : #accessing }
MDQDateComponent >> dateHtml5: aString [

	aString isEmpty ifFalse: [
		self value: (Date fromString: aString) ]
]

{ #category : #rendering }
MDQDateComponent >> inputAspect [

	^ #dateHtml5
]

{ #category : #rendering }
MDQDateComponent >> inputType [

	^ 'date'
]

{ #category : #rendering }
MDQDateComponent >> renderTemplateOn: html vModel: aName [

	html qTemplate vSlot: 'append'; with: [
		html qIcon name: 'event'; class: 'cursor-pointer'; with: [
			html qPopupProxy cover; transitionShow: 'scale'; transitionHide: 'scale'; with: [
				html qDate vModel: aName; mask: 'YYYY-MM-DD'; with: [
					html div class: 'row items-center justify-end'; with: [
						html qBtn vClosePopUp; label: 'Close'; color: 'primary'; flat ] ] ] ] ]
]
