Class {
	#name : #LoanexToyListView,
	#superclass : #LoanexListView,
	#category : #'Tidbit-Loanex-MaterialWeb'
}

{ #category : #rendering }
LoanexToyListView >> modelClass [

	^ LoanexToy
]

{ #category : #rendering }
LoanexToyListView >> renderInstancesOn: html [
	| app list ownerName |

	app := self mdqApplicationGet.
	list := app repository selectAll: self modelClass.

	ownerName := app filterValues toyOwner.
	(ownerName notNil and: [ ownerName notEmpty ]) ifTrue: [
		list := list select: [ :eachInstance | eachInstance owner username = ownerName ] ].

	app filterValues toyAvailable = #availableOnly
		ifTrue: [ list := list select: [ :eachTask | eachTask available ] ].

	app filterValues toyAvailable = #notAvailableOnly
		ifTrue: [ list := list reject: [ :eachTask | eachTask available ] ].

	self renderTitle: 'Toys' on: html.
	self renderAsCards: list on: html
]
