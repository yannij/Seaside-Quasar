Class {
	#name : 'MDQTypography',
	#superclass : 'MDQModel',
	#instVars : [
		'fontFamily',
		'fontFamilies'
	],
	#classVars : [
		'AvailableFonts'
	],
	#category : 'Quasar-Magritte',
	#package : 'Quasar-Magritte'
}

{ #category : 'accessing' }
MDQTypography class >> availableFonts [

	AvailableFonts ifNil: [
		| list |
		list := DockerDeploy current configsAt: 'google-fonts' atKey: 'fonts'.
		list ifNil: [
			list := (WAJsonParser parse: self defaultGoogleFontsJson) at: 'fonts' ].
		AvailableFonts := list collect: [ :each | each first ] ].

	^ AvailableFonts
]

{ #category : 'accessing' }
MDQTypography class >> availableFontsClear [

	AvailableFonts := nil
]

{ #category : 'accessing' }
MDQTypography class >> defaultGoogleFontsJson [

	^ '
{
"fonts": [
	["Acme", "sans-serif" ],
	["Asap", "sans-serif" ],
	["Dancing Script", "handwriting" ],
	["Karma", "serif" ],
	["Newsreader", "serif" ],
	["Noto Emoji", "sans-serif" ],
	["Noto Sans", "sans-serif" ],
	["Noto Serif", "serif" ],
	["Noto Sans JP", "sans-serif" ],
	["Noto Serif JP", "serif" ],
	["Noto Sans KR", "sans-serif" ],
	["Noto Serif KR", "serif" ],
	["Noto Sans SC", "sans-serif" ],
	["Noto Serif SC", "serif" ],
	["Noto Sans TC", "sans-serif" ],
	["Noto Serif TC", "serif" ],
	["Noto Sans Devanagari", "sans-serif" ],
	["Noto Serif Devanagari", "serif" ],
	["Roboto", "sans-serif" ],
	["Roboto Condensed", "sans-serif" ],
	["Roboto Flex", "sans-serif" ],
	["Roboto Mono", "monospace" ],
	["Roboto Serif", "serif" ],
	["Roboto Slab", "serif" ],
	["Sansita", "sans-serif" ],
	["Sansita Swashed", "display" ],
	["Ubuntu", "sans-serif" ],
	["Ubuntu Condensed", "sans-serif" ],
	["Ubuntu Mono", "monospace" ],
	["Zhi Mang Xing", "handwriting" ] ]
}'
]

{ #category : 'accessing' }
MDQTypography class >> fontFamilyDefault [

	^ 'Roboto Flex'
]

{ #category : 'accessing' }
MDQTypography >> fontFamilies [
	^ fontFamilies
]

{ #category : 'accessing' }
MDQTypography >> fontFamilies: anObject [
	fontFamilies := anObject
]

{ #category : 'accessing' }
MDQTypography >> fontFamiliesAdd: aFontFamilyName [

	self fontFamilies add: aFontFamilyName
]

{ #category : 'accessing' }
MDQTypography >> fontFamily [
	^ fontFamily
]

{ #category : 'accessing' }
MDQTypography >> fontFamily: anObject [
	fontFamily := anObject
]

{ #category : 'accessing - magritte' }
MDQTypography >> fontFamilyDescription [
	<magritteDescription>

	^ MASingleOptionDescription new
		accessor: #fontFamily;
		default: '';
		label: 'FontFamily';
		options: self class availableFonts;
		priority: 10;
		yourself
]

{ #category : 'initialization' }
MDQTypography >> initialize [

	super initialize.

	self fontFamily: self class fontFamilyDefault.
	self fontFamilies: OrderedCollection new
]
