Extension { #name : #Time }

{ #category : #'*Quasar-Magritte' }
Time >> jsonOn: aRenderer [

	aRenderer string: self printHtml5
]

{ #category : #'*Quasar-Magritte' }
Time >> printHtml5 [
 	"Return as string 'hh:mm'  "
 
 	^ String new: 8 streamContents: [ :aStream | 
		self print24: true showSeconds: false on: aStream ]
 
]
