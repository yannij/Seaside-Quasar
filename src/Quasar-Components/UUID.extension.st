Extension { #name : #UUID }

{ #category : #'*Quasar-Components' }
UUID >> jsonOn: aRenderer [

	aRenderer string: self printString
]

{ #category : #'*Quasar-Components' }
UUID class >> versionSafeNew [
	"Answer new UUID instance taking into account Pharo version"

	^ SystemVersion current major >= 12
		ifTrue: [ UUID new ]
		ifFalse: [ UUIDGenerator next ]
]
