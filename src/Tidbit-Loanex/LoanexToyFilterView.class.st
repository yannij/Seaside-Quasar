Class {
	#name : #LoanexToyFilterView,
	#superclass : #LoanexFilterView,
	#instVars : [
		'both',
		'availableOnly',
		'notAvailableOnly',
		'toyOwner'
	],
	#category : #'Tidbit-Loanex-MaterialWeb'
}

{ #category : #accessing }
LoanexToyFilterView >> availableOnly [

	^ availableOnly
]

{ #category : #accessing }
LoanexToyFilterView >> availableOnly: anObject [

	availableOnly := anObject
]

{ #category : #accessing }
LoanexToyFilterView >> availableOnlyLazy [

	availableOnly ifNil: [
		availableOnly := (QuasarRefCallback name: 'filteravailableOnly' value: nil)
			callbackBlock: [ :ref :ajaxArg | self toyAvailable: #availableOnly  ];
			emitRefreshOn;
			yourself ].

	^ availableOnly
]

{ #category : #accessing }
LoanexToyFilterView >> both [

	^ both
]

{ #category : #accessing }
LoanexToyFilterView >> both: anObject [

	both := anObject
]

{ #category : #accessing }
LoanexToyFilterView >> bothLazy [

	both ifNil: [
		both := (QuasarRefCallback name: 'filterboth' value: nil)
			callbackBlock: [ :ref :ajaxArg | self toyAvailable: #both ];
			emitRefreshOn;
			yourself ].

	^ both
]

{ #category : #accessing }
LoanexToyFilterView >> notAvailableOnly [

	^ notAvailableOnly
]

{ #category : #accessing }
LoanexToyFilterView >> notAvailableOnly: anObject [

	notAvailableOnly := anObject
]

{ #category : #accessing }
LoanexToyFilterView >> notAvailableOnlyLazy [

	notAvailableOnly ifNil: [
		notAvailableOnly := (QuasarRefCallback name: 'filternotAvailableOnly' value: nil)
			callbackBlock: [ :ref :ajaxArg | self toyAvailable: #notAvailableOnly  ];
			emitRefreshOn;
			yourself ].

	^ notAvailableOnly
]

{ #category : #rendering }
LoanexToyFilterView >> renderContentOn: html [

	self renderFilterRadioButtonsOn: html.
	self renderFilterOwnerOn: html.
	self renderRefreshOn: html
]

{ #category : #rendering }
LoanexToyFilterView >> renderFilterOwnerOn: html [

	self app reactiveObjectsAddIfAbsent: self toyOwnerLazy.

	"self renderFieldLabel: 'Owner' on: html."

	html qInput
		label: 'Owner';
		vModel: self toyOwner refName;
		vOn: 'change' with: self toyOwner functionName, '(', self toyOwner refName, ')';
		yourself
]

{ #category : #rendering }
LoanexToyFilterView >> renderFilterRadioButtonsOn: html [
	| group |

	self renderFieldLabel: 'Availability' on: html.

	group := html radioGroup.
	{#both->'Both'. #availableOnly->'Available Only'. #notAvailableOnly->'Not Available Only'}
		do: [ :each | | optionId callbackRef |
			callbackRef := self perform: (each key, 'Lazy') asSymbol.
			self app reactiveObjectsAddIfAbsent: callbackRef.
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

	^ self app filterValues toyOwner
]

{ #category : #accessing }
LoanexToyFilterView >> toyOwner: anObject [

	self app filterValues toyOwner: anObject
]

{ #category : #accessing }
LoanexToyFilterView >> toyOwnerLazy [

	self app filterValues toyOwner ifNil: [
		self app filterValues toyOwner: ((QuasarRefCallback name: 'filterOwner' value: nil)
			callbackBlock: [ :ref :ajaxArg | self toyOwner refValue: ajaxArg. self toyOwner refValue ];
			emitRefreshOn;
			yourself) ].

	^ self app filterValues toyOwner
]
