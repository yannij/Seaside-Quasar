Extension { #name : #Time }

{ #category : #'*Quasar-Components' }
Time >> jsonOn: aRenderer [

	aRenderer string: self printHtml5
]
