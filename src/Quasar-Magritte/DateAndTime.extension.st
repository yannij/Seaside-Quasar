Extension { #name : 'DateAndTime' }

{ #category : '*Quasar-Magritte' }
DateAndTime >> printHtml5 [

	^ String streamContents: [ :stream |
		self printYMDOn: stream.
		stream nextPut: $T.
		self hour printOn: stream base: 10 length: 2 padded: true.
		stream nextPut: $:.
		self minute printOn: stream base: 10 length: 2 padded: true ]
]
