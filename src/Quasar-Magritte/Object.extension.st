Extension { #name : #Object }

{ #category : #'*Quasar-Magritte' }
Object >> mdBackgroundColor [

	^ '#', self mdColorCode asHexString
]

{ #category : #'*Quasar-Magritte' }
Object >> mdColorCode [

	^ Color lightGray
]

{ #category : #'*Quasar-Magritte' }
Object >> mdIcon [

	^ 'star'
]

{ #category : #'*Quasar-Magritte' }
Object >> mdImageUrl [

	^ nil
]

{ #category : #'*Quasar-Magritte' }
Object >> mdPrimaryString [

	^ self printString
]

{ #category : #'*Quasar-Magritte' }
Object >> mdSecondaryString [

	^ '<', self hash printString, '>'
]

{ #category : #'*Quasar-Magritte' }
Object >> mdTertiaryString [

	^ ''
]
