Extension { #name : #UUID }

{ #category : #'*Quasar-Components' }
UUID >> jsonOn: aRenderer [

	aRenderer string: self printString
]
