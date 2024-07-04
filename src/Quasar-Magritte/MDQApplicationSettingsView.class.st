Class {
	#name : 'MDQApplicationSettingsView',
	#superclass : 'QuasarComponent',
	#instVars : [
		'mdqDensityComponent',
		'mdqThemeComponent',
		'mdqTypographyComponent'
	],
	#category : 'Quasar-Magritte',
	#package : 'Quasar-Magritte'
}

{ #category : 'initialization' }
MDQApplicationSettingsView >> initialize [

	super initialize.

	"self beHidden"
]

{ #category : 'accessing' }
MDQApplicationSettingsView >> mdqDensityComponent [
	^ mdqDensityComponent
]

{ #category : 'accessing' }
MDQApplicationSettingsView >> mdqDensityComponent: anObject [
	mdqDensityComponent := anObject
]

{ #category : 'accessing' }
MDQApplicationSettingsView >> mdqDensityComponentLazy [

	self mdqDensityComponent ifNil: [
		self mdqDensityComponent: self mdqApplicationGet appSettings mdqDensity asComponent addValidatedForm ].

	^ self mdqDensityComponent
]

{ #category : 'accessing' }
MDQApplicationSettingsView >> mdqThemeComponent [
	^ mdqThemeComponent
]

{ #category : 'accessing' }
MDQApplicationSettingsView >> mdqThemeComponent: anObject [
	mdqThemeComponent := anObject
]

{ #category : 'accessing' }
MDQApplicationSettingsView >> mdqThemeComponentLazy [

	self mdqThemeComponent ifNil: [
		self mdqThemeComponent: self mdqApplicationGet appSettings mdqTheme asComponent addValidatedForm ].

	^ self mdqThemeComponent
]

{ #category : 'accessing' }
MDQApplicationSettingsView >> mdqTypographyComponent [
	^ mdqTypographyComponent
]

{ #category : 'accessing' }
MDQApplicationSettingsView >> mdqTypographyComponent: anObject [
	mdqTypographyComponent := anObject
]

{ #category : 'accessing' }
MDQApplicationSettingsView >> mdqTypographyComponentLazy [

	self mdqTypographyComponent ifNil: [
		self mdqTypographyComponent: self mdqApplicationGet appSettings mdqTypography asComponent addValidatedForm ].

	^ self mdqTypographyComponent
]

{ #category : 'rendering' }
MDQApplicationSettingsView >> renderContentOn: html [

	"html div style: 'padding: 8px'; with: [
		self renderDismissButtonOn: html ]."

	html div style: 'padding: 8px'; with: [
		html div
			style: 'width: 320px';
			with: self mdqDensityComponentLazy  ].

	html div style: 'padding: 8px'; with: [
		html div
			style: 'width: 320px';
			with: self mdqTypographyComponentLazy  ].

	html div style: 'padding: 8px'; with: [
		html div
			style: 'width: 320px';
			with: self mdqThemeComponentLazy ]
]
