Class {
	#name : #BrcChallengeTest,
	#superclass : #TestCase,
	#category : #'Quasar-Extras'
}

{ #category : #tests }
BrcChallengeTest >> runMeasurements: list [
	| urlPrefix inputData inputFileName expected |

	urlPrefix := 'https://raw.githubusercontent.com/gunnarmorling/1brc/main/src/test/resources/samples/'.
	inputFileName := 'test.dat'.

	list do: [ :baseName |
		inputData := (ZnEasy get: urlPrefix, baseName, '.txt') contents.
		File deleteFile: inputFileName.
		inputFileName asFileReference writeStreamDo: [ :stream | stream nextPutAll: inputData ].
		expected := (ZnEasy get: urlPrefix, baseName, '.out') contents.
		self assert: (BrcChallenge useMeasureObject: inputFileName) equals: expected ].

]

{ #category : #tests }
BrcChallengeTest >> testMeasurements [

	self runMeasurements: #(
'measurements-1'
'measurements-10'
'measurements-10000-unique-keys'
'measurements-2'
'measurements-20'
'measurements-3'
'measurements-boundaries'
'measurements-complex-utf8'
'measurements-dot'
"'measurements-rounding'"
'measurements-short'
'measurements-shortest'
	)
]

{ #category : #tests }
BrcChallengeTest >> testMeasurements10 [
	| inputFileName inputData expected |

	inputFileName := 'test.dat'.
	File deleteFile: inputFileName.
	inputData := #(
'Halifax;12.9'
'Zagreb;12.2'
'Cabo San Lucas;14.9'
'Adelaide;15.0'
'Ségou;25.7'
'Pittsburgh;9.7'
'Karachi;15.4'
'Xi''an;24.2'
'Dodoma;22.2'
'Tauranga;38.2'
).
	inputFileName asFileReference writeStreamDo: [ :stream |
		inputData do: [ :each | stream nextPutAll: each; lf ] ].
	expected := '{Adelaide=15.0/15.0/15.0, Cabo San Lucas=14.9/14.9/14.9, Dodoma=22.2/22.2/22.2, Halifax=12.9/12.9/12.9, Karachi=15.4/15.4/15.4, Pittsburgh=9.7/9.7/9.7, Ségou=25.7/25.7/25.7, Tauranga=38.2/38.2/38.2, Xi''an=24.2/24.2/24.2, Zagreb=12.2/12.2/12.2}', String lf.

	self assert: (BrcChallenge useHashNative: inputFileName) equals: expected.
	self assert: (BrcChallenge useHashInline: inputFileName) equals: expected.
	self assert: (BrcChallenge useMeasureObject: inputFileName) equals: expected.
]

{ #category : #tests }
BrcChallengeTest >> testMeasurementsRounding [

	self runMeasurements: #(
'measurements-rounding'
	)
]
