Class {
	#name : #MDQTheme,
	#superclass : #MDQModel,
	#instVars : [
		'data'
	],
	#category : #'Quasar-Magritte'
}

{ #category : #accessing }
MDQTheme class >> colorThemeQuasar [
	"self colorThemeQuasar"

	^ self fromString:
'{
	"name": "Quasar",
	"isDark": false,
	"colors": {
		"primary": "#1976d2",
		"secondary": "#26a69a",
		"accent": "#9c27b0",

		"positive": "#21ba45",
		"negative": "#c10015",
		"info": "#31ccec",
		"warning": "#f2c037",

		"background": "#fff"
	}
}'
]

{ #category : #accessing }
MDQTheme class >> colorThemeQuasarDark [
	"self colorThemeQuasarDark"

	^ self fromString:
'{
	"name": "Quasar Dark",
	"isDark": true,
	"colors": {
		"primary": "#6d6d6d",
		"secondary": "#5d5d5d",
		"accent": "#4d4d4d",

		"positive": "#20615b",
		"negative": "#a21232",
		"info": "#3e35a8",
		"warning": "#c1a54d",

		"background": "#2c2c2c"
	}
}'
]

{ #category : #accessing }
MDQTheme class >> colorThemeSynthwave [
	"self colorThemeSynthwave"

	^ self fromString:
'{
	"name": "Synthwave",
	"isDark": true,
	"colors": {
		"primary": "#ff7edb",
		"secondary": "#b893ce8f",
		"accent": "#9c27b0",

		"positive": "#20615b",
		"negative": "#a21232",
		"info": "#3e35a8",
		"warning": "#c1a54d",

		"background": "#262335"
	}
}'
]

{ #category : #'instance creation' }
MDQTheme class >> fromString: aJsonString [

	^ self new
		data: (self materialize: aJsonString);
		yourself
]

{ #category : #private }
MDQTheme class >> materialize: aString [

	^NeoJSONReader fromString: aString
]

{ #category : #accessing }
MDQTheme >> colors [

	^ self data at: 'colors' ifAbsent: [ nil ]
]

{ #category : #accessing }
MDQTheme >> data [

	^ data
]

{ #category : #accessing }
MDQTheme >> data: anObject [

	data := anObject
]

{ #category : #accessing }
MDQTheme >> isDark [

	^ self data at: 'isDark' ifAbsent: [ nil ]
]

{ #category : #accessing }
MDQTheme >> name [

	^ self data at: 'name' ifAbsent: [ nil ]
]

{ #category : #accessing }
MDQTheme >> themeItemsSet: ignore [
]
