Class {
	#name : #BrcSoilTest,
	#superclass : #TestCase,
	#instVars : [
		'soil'
	],
	#category : #'Quasar-Extras'
}

{ #category : #accessing }
BrcSoilTest >> path [ 
	^ 'soil-brc' asFileReference
]

{ #category : #tests }
BrcSoilTest >> processFile: fileName [
	| tx stream character lf tenFloat buffer stringSize lineNumber cities result |

	self soilAddRoot.
	tx := soil newTransaction.

	"Parse and load data"
	lf := Character lf.
	tenFloat := 10 asFloat.
	buffer := String new: 100.
	lineNumber := 0.
	stream := fileName asFileReference readStream.
	[ (character := stream next) isNil ] whileFalse: [
		| city temperature isNegative |
		stringSize := 1.
		buffer at: 1 put: character.
		[ (character := stream nextElement) ~~ $; ] whileTrue: [
			buffer at: (stringSize := stringSize + 1) put: character ].

		temperature := 0.
		isNegative := false.
		[ (character := stream nextElement) == lf ] whileFalse: [
			character ~~ $. ifTrue: [
				character == $-
					ifTrue: [ isNegative := true ]
					ifFalse: [ temperature := temperature * 10 + character asInteger - 48 ] ] ].
		temperature := temperature asFloat / tenFloat.
		isNegative ifTrue: [ temperature := temperature negated ].

		lineNumber := lineNumber + 1.
		city := buffer copyFrom: 1 to: stringSize.
		tx root at: lineNumber put: city -> temperature ].
	tx commit.

	"Query and compute result"
	cities := IdentityDictionary new: 1000.
	tx := soil newTransaction.
	tx root do: [ :each | | city temperature measure |.
		city := each key.
		temperature := each value.
		measure := cities at: city asSymbol ifAbsentPut: [ BrcMeasure city: city ].
		(temperature < measure min) ifTrue: [
			measure min: temperature ].
		(temperature > measure max) ifTrue: [
			measure max: temperature ].
		measure sumIncrementBy: temperature.
		measure countIncrement ].

	"Format result output"
	result := String new: 20000 streamContents: [ :out | | list |
		out nextPut: ${.
		list := (SortedCollection sortBlock: [ :a :b | a cityName < b cityName ])
			addAll: cities values;
			yourself.
		list do: [ :measure |
				out nextPutAll: measure cityName; nextPut: $=.
				out nextPutAll: (measure min printShowingDecimalPlaces: 1); nextPut: $/.
				out nextPutAll: ((measure sum / measure count) printShowingDecimalPlaces: 1); nextPut: $/.
				out nextPutAll: (measure max printShowingDecimalPlaces: 1) asString ]
			separatedBy: [ out nextPut: $,; space ].
		out nextPut: $}; lf ].
	^ result
]

{ #category : #tests }
BrcSoilTest >> readmePostgres [
	"
From: https://ftisiot.net/posts/1brows/
...The timing was a, not astonishing,
9m16.135s with the majority
(6m:24.376s spent on copying the data)
and 2m:51.443s on aggregating.

-- Load the data
DROP TABLE TEST;
CREATE UNLOGGED TABLE TEST(CITY TEXT, TEMPERATURE FLOAT);
COPY TEST(CITY, TEMPERATURE) FROM '<PATH_TO_FILE>/measurements.txt' DELIMITER ';' CSV;

-- Run calculations
WITH AGG AS(
    SELECT city,
           MIN(temperature) min_measure,
           cast(AVG(temperature) AS DECIMAL(8,1)) mean_measure,
           MAX(temperature) max_measure
    FROM test
    GROUP BY city
    )
SELECT STRING_AGG(CITY || '=' || CONCAT(min_measure,'/', mean_measure,'/', max_measure),', ' ORDER BY CITY)
FROM AGG
	"
]

{ #category : #running }
BrcSoilTest >> setUp [ 
	super setUp.
	soil := Soil path: self path.
	soil 
		destroy;
		initializeFilesystem 
]

{ #category : #tests }
BrcSoilTest >> soilAddRoot [ 
	| tx skipList |
	tx := soil newTransaction.
	skipList := SoilSkipListDictionary new 
		maxLevel: 16;
		keySize: 10.
	tx root: skipList.
	tx commit.
]

{ #category : #running }
BrcSoilTest >> tearDown [ 
	super tearDown.
	soil ifNotNil: [ 
		soil close ]
]

{ #category : #tests }
BrcSoilTest >> testMeasurements10 [
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

	self assert: (self processFile: inputFileName) equals: expected.
]
