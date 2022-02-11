Class {
	#name : #LoanexFilterView,
	#superclass : #QuasarComponent,
	#category : #'Tidbit-Loanex-MaterialWeb'
}

{ #category : #rendering }
LoanexFilterView >> renderFieldLabel: aString on: html [

	html heading
		level6;
		"mdcTypography_subtitle1;"
		style: 'margin: 16px 0 8px';
		style: 'padding: 0 12px';
		with: aString
]

{ #category : #rendering }
LoanexFilterView >> renderRefreshOn: html [

	html button "mdcButton; mdcButton_unelevated; style: 'margin: 8px 0 0 0';"
		onClick: ((html jQuery ajax)
			"callback: [  ];"
			onComplete: html javascript refresh);
		with: [ html span "mdcMaterialIcons; mdcIconButton__icon;" with: 'refresh' ].
]
