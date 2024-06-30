Class {
	#name : 'CraneData',
	#superclass : 'Object',
	#category : 'Quasar-Material-Crane',
	#package : 'Quasar-Material',
	#tag : 'Crane'
}

{ #category : 'class initialization' }
CraneData class >> createCraneAirTrips [
	| craneClass |

	craneClass := CraneAirTrip.
	craneClass instanceList: nil.

	#(
	('SD100' 'SD101')
	('FS200' 'FS201')
	('ZA300' 'ZA301')
	('PA400' 'PA401')
	) do: [ :data | | newObject depart return |
		depart := self findAirlineFlight: data first.
		return := self findAirlineFlight: data second.
		newObject := craneClass new
			departFlight: depart;
			returnFlight: return;
			price: depart price + return price;
			yourself.
		craneClass instanceListAdd: newObject ]
]

{ #category : 'class initialization' }
CraneData class >> createCraneAirlineFlights [
	| craneClass today |

	craneClass := CraneAirlineFlight.
	craneClass instanceList: nil.

	today := Date today.

	#(
	('SD100' 'Sunny Day Air' 'GMP' 'DPS' (0 480) 630 500)
	('SD101' 'Sunny Day Air' 'DPS' 'GMP' (7 600) 690 550)
	('FS200' 'Fly Swift' 'GMP' 'YYZ' (3 660) 1200 1500)
	('FS201' 'Fly Swift' 'YYZ' 'GMP' (10 600) 1260 1600)
	('ZA300' 'Zip Airline' 'GMP' 'DPS' (7 480) 600 501)
	('ZA301' 'Zip Airline' 'DPS' 'GMP' (14 600) 660 551)
	('PA400' 'Pop Air' 'GMP' 'YYZ' (10 660) 1200 1400)
	('PA401' 'Pop Air' 'YYZ' 'GMP' (17 600) 1260 1400)
	) do: [ :data | | newObject departureData departureAt arrivalAt |
		departureData := data at: 5.
		departureAt := DateAndTime
			date: (today addDays: departureData first)
			time: (Time fromSeconds: (Duration minutes: departureData second) asSeconds).
		arrivalAt := departureAt + (Duration minutes: (data at: 6)).
		newObject := craneClass new
			id: data first;
			airline: data second;
			origin: (self findAirport: data third);
			destination: (self findAirport: data fourth);
			departureDateTimeUTC: departureAt;
			arrivalDateTimeUTC: arrivalAt;
			price: (data at: 7);
			yourself.
		craneClass instanceListAdd: newObject ]
]

{ #category : 'class initialization' }
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

{ #category : 'class initialization' }
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

{ #category : 'class initialization' }
CraneData class >> createCraneLodgings [
	| craneClass |

	craneClass := CraneLodging.
	craneClass instanceList: nil.

	#(
	('Sandlewig Suites' 'Hotel' '1000 Hotel Alley' ('Bali' 'Indonesia'))
	('Cozy Bali Apartment' 'Apartment' '77 Beach Front' ('Bali' 'Indonesia'))
	('Bay Side Bungalows' 'Hotel' '19 Hotel Alley' ('Bali' 'Indonesia'))
	('Ever Hotels' 'Hotel' '40 Far Away' ('Bali' 'Indonesia'))
	('The General' 'Hotel' '10 Okay Place' ('Bali' 'Indonesia'))
	('Hotel Turquoise' 'Hotel' '80 Far Away' ('Bali' 'Indonesia'))
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

{ #category : 'class initialization' }
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

{ #category : 'class initialization' }
CraneData class >> createData [
	"
	self createData
	"

	self createCraneCities.
	self createCraneLodgings.
	self createCraneRestaurants.
	self createCraneAirports.
	self createCraneAirlineFlights.
	self createCraneAirTrips
]

{ #category : 'class initialization' }
CraneData class >> findAirlineFlight: aFlightId [

	^ CraneAirlineFlight instanceList
		detect: [ :eachAirlineFlight | eachAirlineFlight id = aFlightId ]
		ifNone: [ nil ]
]

{ #category : 'class initialization' }
CraneData class >> findAirport: anAirportCode [

	^ CraneAirport instanceList
		detect: [ :eachAirport | eachAirport airportIATA = anAirportCode ]
		ifNone: [ nil ]
]

{ #category : 'class initialization' }
CraneData class >> findCity: aCityName country: aCountryName [

	^ CraneCity instanceList
		detect: [ :eachCity | eachCity cityName = aCityName and: [ eachCity countryName = aCountryName ] ]
		ifNone: [ nil ]
]

{ #category : 'class initialization' }
CraneData class >> initialize [

	self createData
]
