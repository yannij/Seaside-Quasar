Class {
	#name : 'MDQTimeComponent',
	#superclass : 'MDQTextInputComponent',
	#category : 'Quasar-Magritte',
	#package : 'Quasar-Magritte'
}

{ #category : 'rendering' }
MDQTimeComponent >> inputAspect [

	^ true "self isChrome" ifTrue: [ #time24 ] ifFalse: [ #timeHtml5 ]
]

{ #category : 'rendering' }
MDQTimeComponent >> inputType [

	^ 'time'
]

{ #category : 'rendering' }
MDQTimeComponent >> renderTemplateOn: html vModel: aName [

	html qTemplate vSlot: 'append'; with: [
		html qIcon name: 'access_time'; class: 'cursor-pointer'; with: [
			html qPopupProxy cover; transitionShow: 'scale'; transitionHide: 'scale'; with: [
				html qTime vModel: aName; mask: 'HH:mm:ss'; format24h; withSeconds; with: [
					html div class: 'row items-center justify-end'; with: [
						html qBtn vClosePopUp; label: 'Close'; color: 'primary'; flat ] ] ] ] ] 
]

{ #category : 'accessing' }
MDQTimeComponent >> time24 [

	^ self value
		ifNil: [ nil ]
		ifNotNil: [ :t | t print24 ]
]

{ #category : 'accessing' }
MDQTimeComponent >> time24: aString [

	aString isEmpty ifFalse: [
		self value: (Time fromString: aString) ]
]

{ #category : 'accessing' }
MDQTimeComponent >> timeHtml5 [

	^ self value
		ifNil: [ nil ]
		ifNotNil: [ :t | t printHtml5 ]
]

{ #category : 'accessing' }
MDQTimeComponent >> timeHtml5: aString [

	aString isEmpty ifFalse: [
		self value: (Time fromString: aString) ]
]
