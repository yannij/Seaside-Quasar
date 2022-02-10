Class {
	#name : #MDQApplicationSettingsView,
	#superclass : #QuasarComponent,
	#instVars : [
		'mdcDensityComponent',
		'mdcTypographyComponent',
		'mdcThemeComponent'
	],
	#category : #'Quasar-Magritte'
}

{ #category : #initialization }
MDQApplicationSettingsView >> initialize [

	super initialize.

	"self beHidden"
]

{ #category : #accessing }
MDQApplicationSettingsView >> mdcDensityComponent [
	^ mdcDensityComponent
]

{ #category : #accessing }
MDQApplicationSettingsView >> mdcDensityComponent: anObject [
	mdcDensityComponent := anObject
]

{ #category : #accessing }
MDQApplicationSettingsView >> mdcDensityComponentLazy [

	self mdcDensityComponent ifNil: [
		self mdcDensityComponent: self mdqApplicationGet appSettings mdcDensity asComponent addValidatedForm ].

	^ self mdcDensityComponent
]

{ #category : #accessing }
MDQApplicationSettingsView >> mdcThemeComponent [
	^ mdcThemeComponent
]

{ #category : #accessing }
MDQApplicationSettingsView >> mdcThemeComponent: anObject [
	mdcThemeComponent := anObject
]

{ #category : #accessing }
MDQApplicationSettingsView >> mdcThemeComponentLazy [

	self mdcThemeComponent ifNil: [
		self mdcThemeComponent: self mdqApplicationGet appSettings mdcTheme asComponent addValidatedForm ].

	^ self mdcThemeComponent
]

{ #category : #accessing }
MDQApplicationSettingsView >> mdcTypographyComponent [
	^ mdcTypographyComponent
]

{ #category : #accessing }
MDQApplicationSettingsView >> mdcTypographyComponent: anObject [
	mdcTypographyComponent := anObject
]

{ #category : #accessing }
MDQApplicationSettingsView >> mdcTypographyComponentLazy [

	self mdcTypographyComponent ifNil: [
		self mdcTypographyComponent: self mdqApplicationGet appSettings mdcTypography asComponent addValidatedForm ].

	^ self mdcTypographyComponent
]

{ #category : #rendering }
MDQApplicationSettingsView >> renderContentOn: html [

	html div style: 'padding: 8px'; with: [
		self renderDismissButtonOn: html ].

	html div style: 'padding: 8px'; with: [
		html div
			style: 'width: 320px';
			with: self mdcDensityComponentLazy  ].

	html div style: 'padding: 8px'; with: [
		html div
			style: 'width: 320px';
			with: self mdcTypographyComponentLazy  ].

	html div style: 'padding: 8px'; with: [
		html div
			style: 'width: 320px';
			with: self mdcThemeComponentLazy ]
]

{ #category : #rendering }
MDQApplicationSettingsView >> renderDismissButtonOn: html [

	html anchor
		mdcIconButton;
		mdcButton_raised;
		callback: [ self mdqApplicationGet configureStyle ];
		with: [
			html span mdcMaterialIcons; with: 'expand_less' ]
]
