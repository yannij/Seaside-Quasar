Class {
	#name : #LoanexFilterView,
	#superclass : #QuasarComponent,
	#instVars : [
		'app',
		'refRefresh'
	],
	#category : #'Tidbit-Loanex-MaterialWeb'
}

{ #category : #'instance creation' }
LoanexFilterView class >> on: anApplication [

	^ self new app: anApplication; yourself
]

{ #category : #accessing }
LoanexFilterView >> app [

	^ app
]

{ #category : #accessing }
LoanexFilterView >> app: anObject [

	app := anObject
]

{ #category : #accessing }
LoanexFilterView >> refRefresh [

	^ refRefresh
]

{ #category : #accessing }
LoanexFilterView >> refRefresh: anObject [

	refRefresh := anObject
]

{ #category : #accessing }
LoanexFilterView >> refRefreshLazy [

	refRefresh ifNil: [
		refRefresh := (QuasarRefCallback name: 'refresh' value: nil)
			callbackBlock: [ :ref :ajaxArg | ];
			emitRefreshOn;
			yourself ].

	^ refRefresh
]

{ #category : #rendering }
LoanexFilterView >> renderFieldLabel: aString on: html [

	html div
		class: 'text-subtitle1 q-py-md';
		with: aString
]

{ #category : #rendering }
LoanexFilterView >> renderRefreshOn: html [
	| callbackRef |

	callbackRef := self refRefreshLazy.
	self app reactiveObjectsAddIfAbsent: callbackRef.

	html qBtn round;
		vOnClick: callbackRef functionName, '($event)';
		icon: 'refresh'
]
