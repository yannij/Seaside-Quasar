Class {
	#name : #LoanexToyFilterView,
	#superclass : #LoanexFilterView,
	#category : #'Tidbit-Loanex-MaterialWeb'
}

{ #category : #rendering }
LoanexToyFilterView >> renderContentOn: html [

	self renderFilterRadioButtonsOn: html.
	self renderFilterOwnerOn: html.
	self renderRefreshOn: html
]

{ #category : #rendering }
LoanexToyFilterView >> renderFilterOwnerOn: html [

	self toyOwner ifNil: [ | callbackRef |
		callbackRef := (QuasarRefCallback name: 'filterOwner' value: nil)
			callbackBlock: [ :ref :ajaxArg | self toyOwner refValue: ajaxArg. self toyOwner refValue ];
			emitRefreshOn;
			yourself.
		self mdqApplicationGet reactiveObjectsAdd: callbackRef.
		self toyOwner: callbackRef ].

	"self renderFieldLabel: 'Owner' on: html."

	html qInput
		label: 'Owner';
		vModel: self toyOwner refName;
		vOn: 'change' with: self toyOwner functionName, '(', self toyOwner refName, ')';
		yourself
]

{ #category : #rendering }
LoanexToyFilterView >> renderFilterRadioButtonsOn: html [
	| group app |

	self renderFieldLabel: 'Availability' on: html.

	app := self mdqApplicationGet.
	group := html radioGroup.
	{#both->'Both'. #availableOnly->'Available Only'. #notAvailableOnly->'Not Available Only'}
		do: [ :each | | optionId callbackRef |
			(callbackRef := app reactiveObjectsNamed: 'filter', each key) ifNil: [
				callbackRef := (QuasarRefCallback name: 'filter', each key value: #both)
					callbackBlock: [ :ref :ajaxArg | self toyAvailable: each key ];
					emitRefreshOn;
					yourself.
				app reactiveObjectsAdd: callbackRef ].
			optionId := html nextId.
			html radioButton id: optionId; group: group;
				selected: self toyAvailable = each key;
				vOnClick: callbackRef functionName, '($event)';
				yourself.
			html label for: optionId; with: each value ]
		separatedBy: [ html break ]
]

{ #category : #accessing }
LoanexToyFilterView >> toyAvailable [

	^ self mdqApplicationGet filterValues toyAvailable
]

{ #category : #accessing }
LoanexToyFilterView >> toyAvailable: anObject [

	self mdqApplicationGet filterValues toyAvailable: anObject
]

{ #category : #accessing }
LoanexToyFilterView >> toyOwner [

	^ self mdqApplicationGet filterValues toyOwner
]

{ #category : #accessing }
LoanexToyFilterView >> toyOwner: anObject [

	self mdqApplicationGet filterValues toyOwner: anObject
]
