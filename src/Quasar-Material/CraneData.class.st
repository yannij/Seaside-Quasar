Class {
	#name : #CraneData,
	#superclass : #Object,
	#category : #'Quasar-Material-Crane'
}

{ #category : #'class initialization' }
CraneData class >> createCraneAirports [
	| craneClass |

	craneClass := CraneAirport.
	craneClass instanceList: nil.

	#(
	('GMP' 'Gimpo International' ('Seoul' 'Korea'))
	('DPS' 'Ngurah Rai (Bali) International' ('Bali' 'Indonesia'))
	('YYZ' 'Lester B. Pearson International' ('Toronto' 'Canada'))
	) do: [ :data | | newObject cityData |
		cityData := data third.
		newObject := craneClass new
				airportIATA: data first;
				airportName: data second;
				city: (self findCity: cityData first country: cityData second);
			yourself.
		craneClass instanceListAdd: newObject ]
]

{ #category : #'class initialization' }
CraneData class >> createCraneCities [
	| craneClass |

	craneClass := CraneCity.
	craneClass instanceList: nil.

	#(
	('Seoul' 'Korea')
	('Khumbu Valley' 'Nepal')
	('Maldives' 'South Asia')
	('Machu Picchu' 'Peru')
	('Aspen' 'USA' 'Colorado')
	('Bali' 'Indonesia')
	('Big Sur' 'USA' 'California')
	('Havanna' 'Cuba')
	('Tulum' 'Mexico')
	('Naples' 'Italy')
	('Dallas' 'USA' 'Texas')
	('Cordoba' 'Argentina')
	('Toronto' 'Canada')
	) do: [ :data | | newObject |
		newObject := craneClass new
				cityName: data first;
				countryName: data second;
			yourself.
		craneClass instanceListAdd: newObject ]
]

{ #category : #'class initialization' }
CraneData class >> createCraneLodgings [
	| craneClass |

	craneClass := CraneLodging.
	craneClass instanceList: nil.

	#(
	('Sandlewig Suites' 'Hotel' '1000 Hotel Alley' ('Bali' 'Indonesia') 988)
	('Cozy Bali Apartment' 'Apartment' '77 Beach Front' ('Bali' 'Indonesia') 205)
	('Bay Side Bungalows' 'Hotel' '19 Hotel Alley' ('Bali' 'Indonesia') 345)
	('Ever Hotels' 'Hotel' '40 Far Away' ('Bali' 'Indonesia') 285)
	('The General' 'Hotel' '10 Okay Place' ('Bali' 'Indonesia') 488)
	('Hotel Turquoise' 'Hotel' '80 Far Away' ('Bali' 'Indonesia') 198)
	) do: [ :data | | newObject cityData |
		cityData := data fourth.
		newObject := craneClass new
				lodgingName: data first;
				lodgingType: data second;
				address: data third;
				city: (self findCity: cityData first country: cityData second);
				price: ('$ ', (100 atRandom + 100) printString);
				distance: ((100 atRandom / 10.0) printString, ' km');
			yourself.
		craneClass instanceListAdd: newObject ]
]

{ #category : #'class initialization' }
CraneData class >> createCraneRestaurants [
	| craneClass |

	craneClass := CraneRestaurant.
	craneClass instanceList: nil.

	#(
	('Thai Eatery' 'Thai' '10 Beach Tree Rd' ('Bali' 'Indonesia'))
	('Le Steak' 'French' '100 Westerners Way' ('Bali' 'Indonesia'))
	('Good Eatery' 'fast-food' '123 Eat St' ('Dallas' 'USA'))
	('Greasy Spoon' 'cheap' '777 Dive Av' ('Dallas' 'USA'))
	) do: [ :data | | newObject cityData |
		cityData := data fourth.
		newObject := craneClass new
				restaurantName: data first;
				cuisine: data second;
				address: data third;
				city: (self findCity: cityData first country: cityData second);
			yourself.
		craneClass instanceListAdd: newObject ]
]

{ #category : #'class initialization' }
CraneData class >> createData [
	"
	self createData
	"

	self createCraneCities.
	self createCraneLodgings.
	self createCraneRestaurants.
	self createCraneAirports.
	"self createCraneAirlineFlights.
	self createCraneAirTrips"

]

{ #category : #'class initialization' }
CraneData class >> findCity: aCityName country: aCountryName [

	^ CraneCity instanceList
		detect: [ :eachCity | eachCity cityName = aCityName and: [ eachCity countryName = aCountryName ] ]
		ifNone: [ nil ]
]

{ #category : #'class initialization' }
CraneData class >> initialize [

	self createData
]
