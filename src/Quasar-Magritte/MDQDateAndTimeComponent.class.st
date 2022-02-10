Class {
	#name : #MDQDateAndTimeComponent,
	#superclass : #MDQTextInputComponent,
	#category : #'Quasar-Magritte'
}

{ #category : #accessing }
MDQDateAndTimeComponent >> datetimeHtml5 [

	^ self value
		ifNil: [ DateAndTime now printHtml5 ]
		ifNotNil: [ :t | t isString ifTrue: [ (DateAndTime fromString: t) printHtml5 ] ifFalse: [ t printHtml5 ] ]
]

{ #category : #accessing }
MDQDateAndTimeComponent >> datetimeHtml5: aString [

	aString isEmpty ifFalse: [
		self value: (DateAndTime fromString: aString) ]
]

{ #category : #rendering }
MDQDateAndTimeComponent >> inputAspect [

	^ true "self isChrome" ifTrue: [ #iso8601WithoutTZ ] ifFalse: [ #datetimeHtml5 ]
]

{ #category : #rendering }
MDQDateAndTimeComponent >> inputType [

	^ nil
]

{ #category : #accessing }
MDQDateAndTimeComponent >> iso8601 [

	^ self value
		ifNil: [ DateAndTime now printString ]
		ifNotNil: [ :t | t isString ifTrue: [ (DateAndTime fromString: t) printString ] ifFalse: [ t printString ] ]
]

{ #category : #accessing }
MDQDateAndTimeComponent >> iso8601: aString [

	aString isEmpty ifFalse: [
		self value: (DateAndTime fromString: aString) ]
]

{ #category : #accessing }
MDQDateAndTimeComponent >> iso8601WithoutTZ [
	| isoString |

	isoString := self value
		ifNil: [ DateAndTime now printString ]
		ifNotNil: [ :t | t isString ifTrue: [ (DateAndTime fromString: t) printString ] ifFalse: [ t printString ] ].

	^ isoString copyFrom: 1 to: 19
]

{ #category : #accessing }
MDQDateAndTimeComponent >> iso8601WithoutTZ: aString [

	aString isEmpty ifFalse: [
		self value: (DateAndTime fromString: aString) ]
]

{ #category : #rendering }
MDQDateAndTimeComponent >> renderDateTimeOn: html vModel: aName [

	html qTemplate vSlot: 'prepend'; with: [
		html qIcon name: 'event'; class: 'cursor-pointer'; with: [
			html qPopupProxy cover; transitionShow: 'scale'; transitionHide: 'scale'; with: [
				html qDate vModel: aName; mask: 'YYYY-MM-DD HH:mm:ss'; with: [
					html div class: 'row items-center justify-end'; with: [
						html qBtn vClosePopUp; label: 'Close'; color: 'primary'; flat ] ] ] ] ].
	html qTemplate vSlot: 'append'; with: [
		html qIcon name: 'access_time'; class: 'cursor-pointer'; with: [
			html qPopupProxy cover; transitionShow: 'scale'; transitionHide: 'scale'; with: [
				html qTime vModel: aName; mask: 'YYYY-MM-DD HH:mm:ss'; format24h; with: [
					html div class: 'row items-center justify-end'; with: [
						html qBtn vClosePopUp; label: 'Close'; color: 'primary'; flat ] ] ] ] ] 
]

{ #category : #rendering }
MDQDateAndTimeComponent >> renderFieldOn: html readonly: aReadonlyFlag [
	| inputTag inputLabel inputValue |

	inputLabel := self magritteDescription label.
	inputValue := self perform: self inputAspect.

	inputTag := html qInput.
	"self mdsTextFieldStyleIsFilled" false
		ifTrue: [ inputTag filled ]
		ifFalse: [ inputTag outlined ].

	inputTag label: inputLabel.

	aReadonlyFlag
		ifTrue: [
			inputTag readonly: true; modelValue: inputValue ]
		ifFalse: [ | modelName |
			modelName := inputLabel asCamelCase uncapitalized.
			self mdqApplicationGet vueRefsAdd: modelName -> inputValue.
			inputTag
				"name: modelName;" vModel: modelName;
				on: self inputAspect of: self;
				with: [ self renderDateTimeOn: html vModel: modelName ]
		].

	"self renderTextFieldHelpTextOn: html"
]
