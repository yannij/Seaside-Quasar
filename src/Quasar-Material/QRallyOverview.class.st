Class {
	#name : #QRallyOverview,
	#superclass : #QRallyView,
	#category : #'Quasar-Material-Rally'
}

{ #category : #rendering }
QRallyOverview >> instanceList [
	"Do nothing"
]

{ #category : #rendering }
QRallyOverview >> instanceList: aList limit: aNumber [

	^ aList
		ifNotNil: [ :value | value copyFrom: 1 to: (aNumber min: value size) ]
		ifNil: [ #() ]
]

{ #category : #rendering }
QRallyOverview >> renderContentOn: html [

	self renderOverviewOn: html
]

{ #category : #rendering }
QRallyOverview >> renderHeading: aString on: html [

	html "heading level2" div class: 'q-pa-sm text-h6'; with: aString
]

{ #category : #rendering }
QRallyOverview >> renderOverviewOn: html [

	html div class: 'row'; with: [
		html div class: 'col-10 q-pl-lg'; with: [
			html div class: 'row q-col-gutter-lg'; with: [
				html div class: 'col-6'; with: [
					self renderHeading: 'Accounts' on: html.
					self renderSummary: self totalAccountBalance on: html.
					self renderAsList: (self instanceList: RallyAccount instanceList limit: 4) on: html ].
				html div class: 'col-6'; with: [
					self renderHeading: 'Bills' on: html.
					self renderSummary: self totalBillAmount on: html.
					self renderAsList: (self instanceList: RallyBill instanceList limit: 4) on: html ].
				html div class: 'col-12'; with: [
					self renderHeading: 'Budget Items' on: html.
					self renderSummary: self totalBudgetItemAmountSpent, ' / ', self totalBudgetItemAmount on: html.
					self renderAsList: (self instanceList: RallyBudgetItem instanceList limit: 4) on: html ] ] ].
		html div class: 'col-2 q-px-lg'; with: [
			self renderHeading: 'Alerts' on: html.
			self renderAsCards: (self instanceList: RallyAlert instanceList limit: 4) on: html ] ]
]

{ #category : #rendering }
QRallyOverview >> renderSummary: aString on: html [

	html "heading level2" div class: 'q-pa-sm text-h3'; with: aString
]

{ #category : #rendering }
QRallyOverview >> totalAccountBalance [

	^ (RallyAccount instanceList sum: #balance) displayString
]

{ #category : #rendering }
QRallyOverview >> totalBillAmount [

	^ (RallyBill instanceList sum: #amount) displayString
]

{ #category : #rendering }
QRallyOverview >> totalBudgetItemAmount [

	^ (RallyBudgetItem instanceList sum: #amount) displayString
]

{ #category : #rendering }
QRallyOverview >> totalBudgetItemAmountSpent [

	^ (RallyBudgetItem instanceList sum: #amountSpent) displayString
]
