Class {
	#name : #LoanexFilterView,
	#superclass : #QuasarComponent,
	#category : #'Tidbit-Loanex-MaterialWeb'
}

{ #category : #rendering }
LoanexFilterView >> renderFieldLabel: aString on: html [

	html div
		class: 'text-subtitle1 q-py-md';
		with: aString
]

{ #category : #rendering }
LoanexFilterView >> renderRefreshOn: html [
	| callbackRef app |

	app := self mdqApplicationGet.
	(callbackRef := app reactiveObjectsNamed: 'refresh') ifNil: [
		callbackRef := (QuasarRefCallback name: 'refresh' value: nil)
				callbackBlock: [ :ref :ajaxArg | ];
				emitRefreshOn;
				yourself.
			app reactiveObjectsAdd: callbackRef ].

	html qBtn round;
		vOnClick: callbackRef functionName, '($event)';
		icon: 'refresh'
]
