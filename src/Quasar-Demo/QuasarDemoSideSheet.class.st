Class {
	#name : #QuasarDemoSideSheet,
	#superclass : #QuasarSubComponent,
	#instVars : [
		'content'
	],
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #accessing }
QuasarDemoSideSheet >> content [

	^ content
]

{ #category : #accessing }
QuasarDemoSideSheet >> content: anObject [

	content := anObject
]

{ #category : #rendering }
QuasarDemoSideSheet >> renderContentOn: html [

	html qDrawer
		ref: 'sideSheet'; side: 'right';
		"behavior: 'mobile';"
		"behavior: 'desktop';"
		"vIf: 'sideSheetOpen';"
		"vModel: 'sideSheetOpen';"
		vModelValue: 'sideSheetOpen';
		vOnUpdateModelValue: 'sideSheetOpenRefSet($event)';
		"When show-if-above is set, then initial open/close state is overwritten"
		"showIfAbove;"
		width: 400;
		with: [
			"html qScrollArea class: 'fit'; with: ["
				html qBtn "round;"
					denseIf: self qdemoApp viewStyleDense;
					class: 'full-width'; align: 'right'; flat;
					iconRight: 'unfold_less'; label: 'hide menu';
					vOnClick: 'this.$refs.sideSheet.hide($event)'.
				self renderSheetOn: html ] "]"
]

{ #category : #rendering }
QuasarDemoSideSheet >> renderSheetOn: html [

	"html render: self content"
	self qdemoApp renderTabPanelsOn: html
]
