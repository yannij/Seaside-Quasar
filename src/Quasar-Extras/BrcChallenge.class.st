"
I implement various approaches to the billion row challenge. See https://github.com/gunnarmorling/1brc
"
Class {
	#name : #BrcChallenge,
	#superclass : #Object,
	#category : #'Quasar-Extras'
}

{ #category : #running }
BrcChallenge class >> timeToRun: fileName using: method [
	| start end |

	start := DateAndTime now.
	self perform: method with: fileName.
	end := DateAndTime now.
	(method asString, ' ', (end - start) humanReadablePrintString) traceCr
]

{ #category : #running }
BrcChallenge class >> timeToRun: fileName usingAll: methods [

	'====' traceCr.
	methods do: [ :each | self timeToRun: fileName using: each ]
]

{ #category : #running }
BrcChallenge class >> timeToRunExamples [

	self timeToRun: 'measurements-1m.txt' using: #useMeasureObject:.
	self timeToRun: 'measurements-10m.txt' using: #useMeasureObject:.
	self timeToRun: 'measurements-100m.txt' using: #useMeasureObject:.

	self timeToRun: 'measurements-1000m.txt' using: #useMeasureObject:.

	self timeToRun: 'measurements-1m.txt' usingAll: #(#useNull: #useJosaid: #useHashNative: #useHashInline: #useMeasureObject:).
	self timeToRun: 'measurements-10m.txt' usingAll: #(#useNull: #useHashInline: #useMeasureObject:).
	self timeToRun: 'measurements-100m.txt' usingAll: #(#useNull: #useHashInline: #useMeasureObject:).

]

{ #category : #running }
BrcChallenge class >> useHashInline: fileName [
	"
	self timeToRun: 'measurements-1m.txt' using: #useHashInline:.
	self timeToRun: 'measurements-10m.txt' using: #useHashInline:.
	self timeToRun: 'measurements-100m.txt' using: #useHashInline:.
	"
	| bucketMin bucketMax bucketSum bucketCount cities initialHash stream result character lf buffer stringSize |

	lf := Character lf.
	bucketMin := IntegerArray new: 1048575 withAll: 1000.
	bucketMax := IntegerArray new: 1048575 withAll: -1000.
	bucketSum := IntegerArray new: 1048575.
	bucketCount := IntegerArray new: 1048575.
	cities := IdentityDictionary new: 1000.
	initialHash := ByteString hash bitAnd: 16rFFFFFFF.
	buffer := String new: 100.

	stream := fileName asFileReference readStream.
	[ (character := stream next) isNil ] whileFalse: [
		| cityNameHash temperature isNegative hash low |
		hash := initialHash + character asInteger.
		stringSize := 1.
		buffer at: 1 put: character.
		[ (character := stream nextElement) ~~ $; ] whileTrue: [
			hash := hash + character asInteger.
			low := hash bitAnd: 16383.
			hash := (16r260D * low + ((16r260D * (hash // 16384) + (16r0065 * low) bitAnd: 16383) * 16384)) bitAnd: 16r0FFFFFFF.
			buffer at: (stringSize := stringSize + 1) put: character ].
		cityNameHash := hash \\ 1048575.
		"cities
			at: cityNameHash
			ifPresent: [ :value | 1 to: stringSize do: [ :i | (value at: i) == (buffer at: i) ifFalse: [ self error: 'Hash collistion: ', value ] ] ]."
		cities at: cityNameHash ifAbsentPut: [ buffer copyFrom: 1 to: stringSize ].

		temperature := 0.
		isNegative := false.
		[ (character := stream nextElement) == lf ] whileFalse: [
			character ~~ $. ifTrue: [
				character == $-
					ifTrue: [ isNegative := true ]
					ifFalse: [ temperature := temperature * 10 + character asInteger - 48 ] ] ].
		isNegative ifTrue: [ temperature := temperature negated ].

		(temperature < (bucketMin at: cityNameHash)) ifTrue: [
			bucketMin at: cityNameHash put: temperature ].
		(temperature > (bucketMax at: cityNameHash)) ifTrue: [
			bucketMax at: cityNameHash put: temperature ].
		bucketSum at: cityNameHash put: (bucketSum at: cityNameHash) + temperature.
		bucketCount at: cityNameHash put: (bucketCount at: cityNameHash) + 1 ].

	result := String new: 20000 streamContents: [ :out |
		out nextPut: ${.
		cities values sorted
			do: [ :cityName | | cityNameHash count |
				cityNameHash := cities keyAtValue: cityName.
				out nextPutAll: cityName; nextPut: $=.
				out nextPutAll: ((bucketMin at: cityNameHash) / 10) asFloat asString; nextPut: $/.
				count := bucketCount at: cityNameHash.
				out nextPutAll: ((bucketSum at: cityNameHash) // count / 10) asFloat asString; nextPut: $/.
				out nextPutAll: ((bucketMax at: cityNameHash) / 10) asFloat asString ]
			separatedBy: [ out nextPut: $,; space ].
		out nextPut: $}; lf ].
	^ result
]

{ #category : #running }
BrcChallenge class >> useHashNative: fileName [
	"
	self timeToRun: 'measurements-1m.txt' using: #useHashNative:.
	self timeToRun: 'measurements-10m.txt' using: #useHashNative:.
	self timeToRun: 'measurements-100m.txt' using: #useHashNative:.
	"
	| bucketMin bucketMax bucketSum bucketCount cities stream result character lf |

	lf := Character lf.
	bucketMin := IntegerArray new: 1048575 withAll: 1000.
	bucketMax := IntegerArray new: 1048575 withAll: -1000.
	bucketSum := IntegerArray new: 1048575.
	bucketCount := IntegerArray new: 1048575.
	cities := IdentityDictionary new: 1000.

	stream := fileName asFileReference readStream.
	[ (character := stream next) isNil ] whileFalse: [
		| cityName cityNameHash temperature isNegative |
		cityName := String new: 10 streamContents: [ :out |
			            out nextPut: character.
			            [ (character := stream nextElement) ~~ $; ] whileTrue: [
				            out nextPut: character ] ].
		cityNameHash := cityName hash \\ 1048575.
		cities at: cityNameHash put: cityName.

		temperature := 0.
		isNegative := false.
		[ (character := stream nextElement) == lf ] whileFalse: [
			character ~~ $. ifTrue: [
				character == $-
					ifTrue: [ isNegative := true ]
					ifFalse: [ temperature := temperature * 10 + character asInteger - 48 ] ] ].
		isNegative ifTrue: [ temperature := temperature negated ].

		(temperature < (bucketMin at: cityNameHash)) ifTrue: [
			bucketMin at: cityNameHash put: temperature ].
		(temperature > (bucketMax at: cityNameHash)) ifTrue: [
			bucketMax at: cityNameHash put: temperature ].
		bucketSum at: cityNameHash put: (bucketSum at: cityNameHash) + temperature.
		bucketCount at: cityNameHash put: (bucketCount at: cityNameHash) + 1 ].

	result := String new: 20000 streamContents: [ :out |
		out nextPut: ${.
		cities values sorted
			do: [ :cityName | | cityNameHash count |
				cityNameHash := cities keyAtValue: cityName.
				out nextPutAll: cityName; nextPut: $=.
				out nextPutAll: ((bucketMin at: cityNameHash) / 10) asFloat asString; nextPut: $/.
				count := bucketCount at: cityNameHash.
				out nextPutAll: ((bucketSum at: cityNameHash) // count / 10) asFloat asString; nextPut: $/.
				out nextPutAll: ((bucketMax at: cityNameHash) / 10) asFloat asString ]
			separatedBy: [ out nextPut: $,; space ].
		out nextPut: $}; lf ].
	^ result
]

{ #category : #running }
BrcChallenge class >> useJosaid: fileName [
	"Code from https://discord.com/channels/223421264751099906/278558544146464778/1215795942943621250"
	"
	self timeToRun: 'measurements-1m.txt' using: #useJosaid:.
	self timeToRun: 'measurements-10m.txt' using: #useJosaid:.
	self timeToRun: 'measurements-100m.txt' using: #useJosaid:.
		useJosaid: 1 minute 32 seconds 919 milliseconds 49 microseconds
		extrapolated 1e9 time: 930 asDuration humanReadablePrintString '15 minutes 30 seconds'
	"
		| measurementsFile bucketMin bucketMax bucketSum bucketCount cities stream result character |
		measurementsFile := fileName asFileReference.

		bucketMin := IntegerArray new: 1048575 withAll: 1000.
		bucketMax := IntegerArray new: 1048575 withAll: -1000.
		bucketSum := IntegerArray new: 1048575.
		bucketCount := IntegerArray new: 1048575.
		cities := Array new: 1048575.

		stream := measurementsFile readStream.
		[ (character := stream next) isNil ] whileFalse: [
				| cityName cityNameHash temperature min max sum count isNegative |
				cityName := String new: 10 streamContents: [ :out |
						            out nextPut: character.
						            [ (character := stream nextElement) ~= $; ]
							            whileTrue: [ out nextPut: character ] ].
				cityNameHash := cityName hash \\ 1048575.
				cities at: cityNameHash put: cityName.

				temperature := 0.
				isNegative := false.

				[ (character := stream nextElement) isSeparator ] whileFalse: [
						character ~= $. ifTrue: [
								character = $-
									ifTrue: [ isNegative := true ]
									ifFalse: [
										temperature := temperature * 10 + character asInteger - 48 ] ] ].

				isNegative ifTrue: [ temperature := temperature negated ].

				min := bucketMin at: cityNameHash.
				temperature < min ifTrue: [
						bucketMin at: cityNameHash put: temperature ].

				max := bucketMax at: cityNameHash.
				temperature > max ifTrue: [
						bucketMax at: cityNameHash put: temperature ].

				sum := bucketSum at: cityNameHash.
				bucketSum at: cityNameHash put: sum + temperature.

				count := bucketCount at: cityNameHash.
				bucketCount at: cityNameHash put: count + 1 ].

		result := String new: 20000 streamContents: [ :out |
				          | sortedCities |
				          out nextPut: ${.

				          sortedCities := OrderedCollection
					                          new: cities size
					                          streamContents: [ :sortedCitiesOut |
						                          cities doWithIndex: [
								                          :cityName
								                          :cityNameHash |
								                          cityName ifNotNil: [
										                          sortedCitiesOut nextPut:
												                          cityName -> cityNameHash ] ] ].
				          sortedCities := sortedCities asSortedCollection: [ :a :b |
						                          a key < b key ].

				          sortedCities doWithIndex: [ :cityNameWithHash :index |
						          | cityName cityNameHash min max count sum |
						          cityName := cityNameWithHash key.
						          cityNameHash := cityNameWithHash value.
						          out nextPutAll: cityName.
						          out nextPut: $:.

						          min := bucketMin at: cityNameHash.
						          out nextPutAll: (min / 10) asFloat asString.
						          out nextPut: $/.

						          sum := bucketSum at: cityNameHash.
						          count := bucketCount at: cityNameHash.
						          out nextPutAll: (sum // count / 10) asFloat asString.
						          out nextPut: $/.

						          max := bucketMax at: cityNameHash.
						          out nextPutAll: (max / 10) asFloat asString.
						          out nextPut: $; ].
				          out position: out position - 1.
				          out nextPut: $} ].
		^ result
]

{ #category : #running }
BrcChallenge class >> useMeasureObject: fileName [
	"
	self timeToRun: 'measurements-1m.txt' using: #useMeasureObject:.
	self timeToRun: 'measurements-10m.txt' using: #useMeasureObject:.
	self timeToRun: 'measurements-100m.txt' using: #useMeasureObject:.
		useMeasureObject: 13 minutes 2 seconds 777 milliseconds 451 microseconds
	"
	| cities initialHash stream result character lf tenFloat buffer stringSize |

	lf := Character lf.
	tenFloat := 10 asFloat.
	cities := IdentityDictionary new: 1000.
	initialHash := ByteString hash bitAnd: 16rFFFFFFF.
	buffer := String new: 100.

	stream := fileName asFileReference readStream.
	[ (character := stream next) isNil ] whileFalse: [
		| temperature isNegative hash low measure |
		hash := initialHash + character asInteger.
		stringSize := 1.
		buffer at: 1 put: character.
		[ (character := stream nextElement) ~~ $; ] whileTrue: [
			hash := hash + character asInteger.
			low := hash bitAnd: 16383.
			hash := (16r260D * low + ((16r260D * (hash // 16384) + (16r0065 * low) bitAnd: 16383) * 16384)) bitAnd: 16r0FFFFFFF.
			buffer at: (stringSize := stringSize + 1) put: character ].
		measure := cities at: hash ifAbsentPut: [ BrcMeasure city: (buffer copyFrom: 1 to: stringSize) ].

		temperature := 0.
		isNegative := false.
		[ (character := stream nextElement) == lf ] whileFalse: [
			character ~~ $. ifTrue: [
				character == $-
					ifTrue: [ isNegative := true ]
					ifFalse: [ temperature := temperature * 10 + character asInteger - 48 ] ] ].
		temperature := temperature asFloat / tenFloat.
		isNegative ifTrue: [ temperature := temperature negated ].

		(temperature < measure min) ifTrue: [
			measure min: temperature ].
		(temperature > measure max) ifTrue: [
			measure max: temperature ].
		measure sumIncrementBy: temperature.
		measure countIncrement ].

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

{ #category : #running }
BrcChallenge class >> useNull: fileName [
	"
	self timeToRun: 'measurements-1m.txt' using: #useNull:.
	self timeToRun: 'measurements-10m.txt' using: #useNull:.
	self timeToRun: 'measurements-100m.txt' using: #useNull:.
	self timeToRun: 'measurements-1000m.txt' using: #useNull:.
		doNull: 6 minutes 39 seconds 164 milliseconds 722 microseconds
	"
	| stream character lf |

	lf := Character lf.
	stream := fileName asFileReference readStream.
	[ (character := stream next) isNil ] whileFalse: [
		[ (character := stream nextElement) == lf ] whileFalse: [  ] ]
]
