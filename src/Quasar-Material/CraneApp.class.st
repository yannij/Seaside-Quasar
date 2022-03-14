"
I am a demo application inspired by the Crane Material Design Study (https://material.io/design/material-studies/crane.html)
"
Class {
	#name : #CraneApp,
	#superclass : #QuasarApplication,
	#instVars : [
		'tab',
		'filterShow',
		'flyFilter',
		'sleepFilter',
		'eatFilter'
	],
	#category : #'Quasar-Material-Crane'
}

{ #category : #initialization }
CraneApp class >> applicationPath [

	^ 'quasar/material-study-crane'
]

{ #category : #initialization }
CraneApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : #accessing }
CraneApp >> applicationTitle [

	^ 'Crane'
]

{ #category : #accessing }
CraneApp >> eatFilter [

	^ eatFilter
]

{ #category : #accessing }
CraneApp >> eatFilter: anObject [

	eatFilter := anObject
]

{ #category : #accessing }
CraneApp >> filterShow [

	^ filterShow
]

{ #category : #accessing }
CraneApp >> filterShow: anObject [

	filterShow := anObject
]

{ #category : #accessing }
CraneApp >> flyFilter [

	^ flyFilter
]

{ #category : #accessing }
CraneApp >> flyFilter: anObject [

	flyFilter := anObject
]

{ #category : #initialization }
CraneApp >> initialize [

	super initialize.

	self tab: ((QuasarReactiveObject name: 'tab' value: 'fly') transformBlock: [ :value | value ]; emitRefSetOn; yourself).
	self reactiveObjectsAdd: self tab.

	self filterShow: ((QuasarReactiveObject name: 'filterShow' value: false) transformBlock: [ :value | value not ]; yourself).
	self reactiveObjectsAdd: self filterShow.

	self initializeFlyFilter.
	self initializeSleepFilter.
	self initializeEatFilter
]

{ #category : #'tab - eat' }
CraneApp >> initializeEatFilter [
	| newReactive |

	self eatFilter: CraneEatSearch new.

	newReactive := (QuasarReactiveObject name: 'dinerCount' value: 2) transformBlock: [ :value | value ]; yourself.
	self eatFilter dinerCount: newReactive.
	self reactiveObjectsAdd: newReactive.

	newReactive := (QuasarReactiveObject name: 'diningDate' value: Date today) "transformBlock: [ :value | value ];" yourself.
	self eatFilter diningDate: newReactive.
	self reactiveObjectsAdd: newReactive.

	newReactive := (QuasarReactiveObject name: 'diningTime' value: Time now) "transformBlock: [ :value | value ];" yourself.
	self eatFilter diningTime: newReactive.
	self reactiveObjectsAdd: newReactive.

	newReactive := (QuasarReactiveObject name: 'cuisine' value: nil) transformBlock: [ :value | value ]; yourself.
	self eatFilter cuisine: newReactive.
	self reactiveObjectsAdd: newReactive.

	newReactive := (QuasarReactiveObject name: 'city' value: nil) "transformBlock: [ :value | value ];" yourself.
	self eatFilter city: newReactive.
	self reactiveObjectsAdd: newReactive.
]

{ #category : #'tab - fly' }
CraneApp >> initializeFlyFilter [
	| newReactive |

	self reactiveObjectsAdd: ((QuasarReactiveObject name: 'flyOriginDialog' value: false) "transformBlock: [ :value | value not ];" emitRefSyncOff; emitRefSetOff; yourself).
	self reactiveObjectsAdd: ((QuasarReactiveObject name: 'flyDestinationDialog' value: false) "transformBlock: [ :value | value not ];" emitRefSyncOff; emitRefSetOff; yourself).
	"self vueRefsAdd: 'flyOriginDialog' -> false.
	self vueRefsAdd: 'flyDestinationDialog' -> false."
	"self quasarDataAdd: 'flyOriginDialog'.
	self quasarDataAdd: 'flyDestinationDialog'."

	self flyFilter: CraneFlySearch new.

	newReactive := (QuasarReactiveObject name: 'adultCount' value: 2) transformBlock: [ :value | value ]; yourself.
	self flyFilter adultCount: newReactive.
	self reactiveObjectsAdd: newReactive.

	newReactive := (QuasarReactiveObject name: 'childrenCount' value: 3) transformBlock: [ :value | value ]; yourself.
	self flyFilter childrenCount: newReactive.
	self reactiveObjectsAdd: newReactive.

	newReactive := (QuasarReactiveObject name: 'cabin' value: 'Economy') transformBlock: [ :value | value ]; yourself.
	self flyFilter cabinType: newReactive.
	self reactiveObjectsAdd: newReactive.
	newReactive := (QuasarReactiveObject name: 'cabinOptions' value: #('Economy' 'Business' 'First Class')) yourself.
	self reactiveObjectsAdd: newReactive.

	newReactive := (QuasarReactiveObject name: 'origin' value: nil) "transformBlock: [ :value | value ];" emitRefSetOn; yourself.
	self flyFilter origin: newReactive.
	self reactiveObjectsAdd: newReactive.

	newReactive := (QuasarReactiveObject name: 'destination' value: nil) "transformBlock: [ :value | value ];" emitRefSetOn; yourself.
	self flyFilter destination: newReactive.
	self reactiveObjectsAdd: newReactive.

	newReactive := (QuasarReactiveObject name: 'startDate' value: Date today) "transformBlock: [ :value | value ];" yourself.
	self flyFilter startDate: newReactive refValue.
	self reactiveObjectsAdd: newReactive.
]

{ #category : #'tab - sleep' }
CraneApp >> initializeSleepFilter [
	| newReactive |

	self sleepFilter: CraneSleepSearch new.

	newReactive := (QuasarReactiveObject name: 'adultCount' value: 2) transformBlock: [ :value | value ]; yourself.
	self sleepFilter adultCount: newReactive.
	self reactiveObjectsAdd: newReactive.

	newReactive := (QuasarReactiveObject name: 'childrenCount' value: 3) transformBlock: [ :value | value ]; yourself.
	self sleepFilter childrenCount: newReactive.
	self reactiveObjectsAdd: newReactive.

	"newReactive := (QuasarReactiveObject name: 'startDate' value: Date today) ""transformBlock: [ :value | value ];"" yourself.
	self sleepFilter startDate: newReactive refValue.
	self reactiveObjectsAdd: newReactive."
]

{ #category : #rendering }
CraneApp >> quasarConfigContentOn: aJSStream with: html [

	aJSStream nextPutAll: '
brand: {
	primary: ''#5d1049'',
	secondary: ''#e30425'',
	accent: ''#9C27B0'',
	dark: ''#1d1d1d'',
	positive: ''#21BA45'',
	negative: ''#C10015'',
	info: ''#31CCEC'',
	warning: ''#F2C037''
}'
]

{ #category : #rendering }
CraneApp >> quasarOnLoadOn: aJSStream with: html [

	aJSStream
		nextPutAll: 'const { useQuasar } = Quasar;';
		nextPutAll: 'const { ref } = Vue;';
		"nextPutAll: 'const flyOriginDialog = ref(false);';
		nextPutAll: 'const flyDestinationDialog = ref(false);';"
		nextPutAll: 'const app = Vue.createApp({'.
	self quasarSetupOn: aJSStream with: html.
	aJSStream nextPutAll: '});'.
	aJSStream nextPutAll: 'app.use(Quasar, {'.
	self quasarConfigOn: aJSStream with: html.
	aJSStream nextPutAll: '});'.
	aJSStream nextPutAll: 'app.mount("#', self appId, '")'
]

{ #category : #'tab - fly' }
CraneApp >> renderAirportListOn: html header: headerString ref: aRefObject [

	html qList style: 'background: white'; with: [
		html qItemLabel header; with: headerString.
		CraneAirport instanceList do: [ :eachObject |
			html qItem clickable; vClosePopUp; vOnClick: aRefObject emitRefSetFunctionName, '("', eachObject airportIATA, '")'; with: [
				html qItemSection top; avatar; with: [
					html qAvatar color: 'primary'; textColor: 'white'; icon: 'connecting_airports' ].
				html qItemSection with: [
					html qItemLabel with: eachObject airportIATA, ' - ', eachObject airportName.
					html qItemLabel caption; "lines: 2;"
						with: eachObject city cityName, ', ', eachObject city countryName ] ] ] ]
]

{ #category : #rendering }
CraneApp >> renderBottomSheetContentOn: html [

	html qCard flat;
		"style: 'background: var(--q-secondary)';"
		style: 'max-width: 400px';
		with: [
			html qCardSection class: 'q-pa-sm'; with: [
				"html render: self shoppingCart" ].
			html qCardActions vertical; class: 'q-pa-sm'; with: [
				html qBtn icon: 'close'; vClosePopUp; "style: 'background: var(--q-primary)';" with: 'Close' ] ]
]

{ #category : #rendering }
CraneApp >> renderBottomSheetOn: html [

	html qDialog
		ref: 'bottomSheet'; persistent; maximized; transitionShow: 'slide-up'; transitionHide: 'slide-down';
		with: [
			self renderBottomSheetContentOn: html ].

	html qPageSticky position: 'bottom-right'; offset: '[0, 0]'; with: [
		html qBtn fab; unelevated; icon: 'shopping_cart';
			"color: 'secondary'; textColor: 'black';"
			vOnClick: 'this.$refs.bottomSheet.show($event)' ]
]

{ #category : #'tab - eat' }
CraneApp >> renderEatListOn: html [

	html qList style: 'background: white'; with: [
		CraneRestaurant instanceList do: [ :eachObject |
			html qItem with: [
				html qItemSection top; avatar; with: [
					html qAvatar color: 'primary'; textColor: 'white'; icon: 'restaurant' ].
				html qItemSection with: [
					html qItemLabel with: eachObject restaurantName.
					html qItemLabel caption; "lines: 2;"
						with: eachObject cuisine asString, ' - ', eachObject address ].
				"html qItemSection with: [
					html qItemLabel style: 'color: red'; with: eachObject price ]" ] ] ]
]

{ #category : #'tab - eat' }
CraneApp >> renderEatSearchOn: html [

	html div class: 'xs'; with: [
		self renderEatSearchOn: html colCount: 'col-12' ].

	html div class: 'sm'; with: [
		self renderEatSearchOn: html colCount: 'col-6' ].

	html div class: 'md'; with: [
		self renderEatSearchOn: html colCount: 'col-6' ].

	html div class: 'gt-md'; with: [
		self renderEatSearchOn: html colCount: 'col-3' ]
]

{ #category : #'tab - eat' }
CraneApp >> renderEatSearchOn: html colCount: colCount [

	html div class: 'q-px-xs q-py-sm row q-col-gutter-xs'; class: 'backdrop-bg'; with: [
		html div class: colCount; with: [
			html qBtn flat; unelevated; noCaps; icon: 'person'; class: 'full-width';
				class: 'backdrop-btn';
				label: self eatFilter dinersDisplay ].
		html div class: colCount; with: [
			html qBtn flat; unelevated; noCaps; icon: 'event'; class: 'full-width';
				class: 'backdrop-btn';
				label: self eatFilter diningDate refValue greaseString ].
		html div class: colCount; with: [
			html qBtn flat; unelevated; noCaps; icon: 'watch_later'; class: 'full-width';
				class: 'backdrop-btn';
				label: self eatFilter diningTime refValue printMinutes ].
		html div class: colCount; with: [
			html qBtn flat; unelevated; noCaps; icon: 'place'; class: 'full-width';
				class: 'backdrop-btn';
				label: self eatFilter location ] ]
]

{ #category : #'tab - eat' }
CraneApp >> renderEatTabPanelOn: html [

	html qTabPanel name: 'eat'; class: 'q-pa-none'; with: [
		self renderEatSearchOn: html.
		self renderEatListOn: html ]
]

{ #category : #'tab - fly' }
CraneApp >> renderFlyCard: eachObject on: html [

	html qCard class: 'q-px-xs'; flat; with: [ | flight |
		flight := eachObject departFlight.
		html qCardSection class: 'q-px-none'; with: [
			html div class: 'row no-wrap items-center'; with: [
				html div class: 'col';
					with: 'DEPART'.
				html div class: 'col-auto row no-wrap items-center';
					with: flight departureDateTimeUTC asDate greaseString ].
			html div class: 'row no-wrap items-center'; with: [
				html div class: 'col text-red text-h3 row no-wrap items-left';
					with: flight origin airportIATA.
				html div class: 'col-auto text-red text-h3 row no-wrap items-right';
					with: flight destination airportIATA ].
			html div class: 'row no-wrap items-center'; with: [
				html div class: 'col row no-wrap items-left';
					with: flight origin airportName.
				html div class: 'col-auto row no-wrap items-right';
					with: flight destination airportName ].
			html div class: 'row no-wrap items-center'; with: [
				html div class: 'col';
					with: eachObject departFlight airline.
				html div class: 'col-auto text-red row no-wrap items-center';
					with: '$', flight price greaseString ].
			html div class: 'row no-wrap items-center'; with: [
				html div class: 'col'; with: flight departureDateTimeUTC asTime printMinutes.
				html div class: 'col'; with: '---->'.
				html div class: 'col'; with: flight arrivalDateTimeUTC asTime printMinutes.
				html div class: 'col-auto'; with: flight flightDuration asHours printString, 'h' "]" ] ].
		flight := eachObject returnFlight.
		html qCardSection class: 'q-px-none'; with: [
			html div class: 'row no-wrap items-center'; with: [
				html div class: 'col';
					with: 'RETURN'.
				html div class: 'col-auto row no-wrap items-center';
					with: flight departureDateTimeUTC asDate greaseString ].
			html div class: 'row no-wrap items-center'; with: [
				html div class: 'col text-red text-h3 row no-wrap items-left';
					with: flight origin airportIATA.
				html div class: 'col-auto text-red text-h3 row no-wrap items-right';
					with: flight destination airportIATA ].
			html div class: 'row no-wrap items-center'; with: [
				html div class: 'col row no-wrap items-left';
					with: flight origin airportName.
				html div class: 'col-auto row no-wrap items-right';
					with: flight destination airportName ].
			html div class: 'row no-wrap items-center'; with: [
				html div class: 'col';
					with: eachObject departFlight airline.
				html div class: 'col-auto text-red row no-wrap items-center';
					with: '$', flight price greaseString ].
			html div class: 'row no-wrap items-center'; with: [
				html div class: 'col'; with: flight departureDateTimeUTC asTime printMinutes.
				html div class: 'col'; with: '---->'.
				html div class: 'col'; with: flight arrivalDateTimeUTC asTime printMinutes ] ] ]
]

{ #category : #'tab - fly' }
CraneApp >> renderFlyCardDense: eachObject on: html [

	html qCard class: 'q-px-xs'; "style: 'width: 350px';" flat; with: [ | flight |
		html qCardSection class: 'q-pa-none'; with: [
			html div class: 'row no-wrap items-center'; with: [
				html div class: 'col text-h6 ellipsis';
					with: eachObject departFlight airline.
				html div class: 'col-auto text-red text-h6 row no-wrap items-center';
					with: '$', eachObject price greaseString ] ].
		"html qCardSection with: [ | flight |"
			flight := eachObject departFlight.
			html div class: 'row no-wrap items-center'; with: [
				html div class: 'col'; with: flight departureDateTimeUTC asTime printMinutes.
				html div class: 'col'; with: flight origin airportIATA.
				html div class: 'col'; with: '---->'.
				html div class: 'col'; with: flight arrivalDateTimeUTC asTime printMinutes.
				html div class: 'col'; with: flight destination airportIATA.
				html div class: 'col-auto'; with: flight flightDuration asHours printString, 'h' "]" ].
		"html qCardSection with: [ | flight |"
			flight := eachObject returnFlight.
			html div class: 'row no-wrap items-center'; with: [
				html div class: 'col'; with: flight departureDateTimeUTC asTime printMinutes.
				html div class: 'col'; with: flight origin airportIATA.
				html div class: 'col'; with: '<----'.
				html div class: 'col'; with: flight arrivalDateTimeUTC asTime printMinutes.
				html div class: 'col'; with: flight destination airportIATA.
				html div class: 'col-auto'; with: flight flightDuration asHours printString, 'h' "]" ] ]
]

{ #category : #'tab - fly' }
CraneApp >> renderFlyDialogDestinationOn: html [

	html div class: 'q-pa-md'; with: [
		html qDialog vModel: 'flyDestinationDialog'; "persistent;" with: [
			html qCard with: [
				self renderAirportListOn: html header: 'Choose destination' ref: self flyFilter destination.
				html qCardActions align: 'right'; with: [
					html qBtn flat; label: 'Cancel'; color: 'primary'; vClosePopUp ] ] ] ]
]

{ #category : #'tab - fly' }
CraneApp >> renderFlyDialogOriginOn: html [

	html div class: 'q-pa-md'; with: [
		html qDialog vModel: 'flyOriginDialog'; "persistent;" with: [
			html qCard with: [
				self renderAirportListOn: html header: 'Choose origin' ref: self flyFilter origin.
				html qCardActions align: 'right'; with: [
					html qBtn flat; label: 'Cancel'; color: 'primary'; vClosePopUp ] ] ] ]
]

{ #category : #'tab - fly' }
CraneApp >> renderFlyResultsOn: html [

	html div
		class: 'q-pa-xs row q-col-gutter-xs';
		class: 'front-layer-bg'; "style: 'background: lightGray';"
		with: [
			CraneAirTrip instanceList
				do: [ :eachObject |
					html div class: 'col-12'; with: [
						self renderFlyCard: eachObject on: html ] ]
				separatedBy: [ "html qSpace" ] ]
]

{ #category : #'tab - fly' }
CraneApp >> renderFlySearchOn: html [

	html div class: 'xs'; with: [
		self renderFlySearchOn: html colWidth: 'col-12' ].

	html div class: 'sm'; with: [
		self renderFlySearchOn: html colWidth: 'col-6' ].

	html div class: 'md'; with: [
		self renderFlySearchOn: html colWidth: 'col-6' ].

	html div class: 'gt-md'; with: [
		self renderFlySearchOn: html colWidth: 'col-3' ].

	self renderFlyDialogOriginOn: html.
	self renderFlyDialogDestinationOn: html
]

{ #category : #'tab - fly' }
CraneApp >> renderFlySearchOn: html colWidth: colWidth [

	html div class: 'q-px-xs q-py-sm row q-col-gutter-xs'; class: 'backdrop-bg'; with: [
		html div class: colWidth; with: [
			html qBtn flat; unelevated; noCaps; icon: 'person'; class: 'full-width';
				class: 'backdrop-btn';
				type: 'a'; href: (html urlForAction: [  ]);
				label: self flyFilter travellerSummary ].
		html div class: colWidth; with: [
			html qBtn flat; unelevated; noCaps; icon: 'place'; class: 'full-width';
				class: 'backdrop-btn';
				vOnClick: 'flyOriginDialog = true';
				"vOnClick: 'flyOriginDialogOnClick($event)';"
				"label: (self flyFilter origin refValue ifNil: [ 'Choose origin' ] ifNotNil: [ :value | value displayString ]) ]."
				vBind: 'label' with: self flyFilter origin refName ].
		html div class: colWidth; with: [
			html qBtn flat; unelevated; noCaps; icon: 'flight'; class: 'full-width';
				class: 'backdrop-btn';
				vOnClick: 'flyDestinationDialog = true';
				"vOnClick: 'flyDestinationDialogOnClick($event)';"
				"label: (self flyFilter destination refValue ifNil: [ 'Choose destination' ] ifNotNil: [ :value | value displayString ]) ]."
				vBind: 'label' with: self flyFilter destination refName ].
		html div class: colWidth; with: [
			html qBtn flat; unelevated; noCaps; icon: 'event'; class: 'full-width';
				class: 'backdrop-btn';
				label: 'Select Dates' ] ]
]

{ #category : #'tab - fly' }
CraneApp >> renderFlyTabPanelOn: html [

	html qTabPanel name: 'fly'; class: 'q-pa-none'; with: [
		self renderFlySearchOn: html.
		self renderFlyResultsOn: html ]
]

{ #category : #rendering }
CraneApp >> renderLayoutCraneOn: html [

	html qApp id: self appId; with: [
		html qLayout view: 'hHh lpR fFf'; with: [
		html qHeader heightHint: 98; class: 'bg-primary'; with: [
			html qToolbar with: [
				"html qBtn dense; flat; round; icon: 'menu'; vOnClick: 'this.$refs.leftDrawer.toggle($event)'."
				html qImg src: (CraneLibrary urlOf: #cranelogoPng); style: 'height: 56px; width: 56px'.
				"html span class: 'q-pr-md'; with: 'Crane'."
				self renderTabsOn: html.
				html qSpace.
				html qBtn dense; flat; round; icon: 'filter_list'; vOnClick: 'filterShowOnClick($event)' ] ].
			self renderSideSheetOn: html.
			self renderLayoutPageOn: html.
			"self renderBottomSheetOn: html."
			"self renderSettingsFabOn: html" ] ]
]

{ #category : #rendering }
CraneApp >> renderLayoutOn: html [

	self renderLayoutCraneOn: html
]

{ #category : #rendering }
CraneApp >> renderLayoutPageOn: html [

	html qPageContainer with: [
		html qPage with: [
			self renderTabPanelsOn: html
			"self renderSettingsFabOn: html.
			html div class: 'q-pr-xl'; with: [
				html render: self productComponent ]" ] ]
]

{ #category : #rendering }
CraneApp >> renderSettingsFabOn: html [
	| logoutUrl |

	logoutUrl := (html urlForAction: [ self logout ]).

	html qPageSticky position: 'bottom-left'; offset: '[0, 16]'; with: [
		html qFab "externalLabel; labelPosition: 'top'; label: 'Settings';" icon: 'keyboard_arrow_right';
			push; color: 'blue'; direction: 'right'; with: [
				html qFabAction label: 'Side Sheet'; icon: 'view_sidebar';
					push; color: 'primary'; textColor: 'black';
					vOnClick: 'this.$refs.sideSheet.toggle($event)'.
				html qFabAction "externalLabel; labelPosition: 'top';" label: 'Logout'; icon: 'logout';
					push; color: 'primary'; textColor: 'black';
					"vOnClick: '$emit(''click'');'"
					onClick: 'Quasar.openURL(''', logoutUrl greaseString, ''')' ] ]
]

{ #category : #rendering }
CraneApp >> renderSideSheetOn: html [

	html qDrawer
		"ref: 'filterSheet';" showIfAbove; side: 'right';
		vIf: 'filterShow';
		bordered; "class: 'bg-secondary';"
		with: [ "self renderShoppingCartOn: html" ].

	"html qPageSticky position: 'top-right'; offset: '[0, 76]'; with: [
		html qBtn fab; unelevated; icon: 'view_sidebar';
			color: 'secondary'; textColor: 'black';
			vOnClick: 'this.$refs.sideSheet.toggle($event)' ]"
]

{ #category : #'tab - sleep' }
CraneApp >> renderSleepListOn: html [

	html qList style: 'background: white'; with: [
		CraneLodging instanceList do: [ :eachObject |
			html qItem with: [
				html qItemSection top; avatar; with: [
					html qAvatar color: 'primary'; textColor: 'white'; icon: 'hotel' ].
				html qItemSection with: [
					html qItemLabel with: eachObject lodgingName.
					html qItemLabel caption; "lines: 2;"
						with: eachObject lodgingType asString, ' - ', eachObject distance ].
				html qItemSection with: [
					html qItemLabel style: 'color: red'; with: eachObject price ] ] ] ]
]

{ #category : #'tab - sleep' }
CraneApp >> renderSleepSearchOn: html [

	html div class: 'xs'; with: [
		self renderSleepSearchOn: html colCount: 'col-12' ].

	html div class: 'sm'; with: [
		self renderSleepSearchOn: html colCount: 'col-6' ].

	html div class: 'md'; with: [
		self renderSleepSearchOn: html colCount: 'col-6' ].

	html div class: 'gt-md'; with: [
		self renderSleepSearchOn: html colCount: 'col-3' ]
]

{ #category : #'tab - sleep' }
CraneApp >> renderSleepSearchOn: html colCount: colCount [

	html div class: 'q-px-xs q-py-sm row q-col-gutter-xs'; class: 'backdrop-bg'; with: [
		html div class: colCount; with: [
			html qBtn flat; unelevated; noCaps; icon: 'person'; class: 'full-width';
				class: 'backdrop-btn';
				label: self sleepFilter guestsDisplay ].
		html div class: colCount; with: [
			html qBtn flat; unelevated; noCaps; icon: 'event'; class: 'full-width';
				class: 'backdrop-btn';
				label: 'Select Dates' ].
		html div class: colCount; with: [
			html qBtn flat; unelevated; noCaps; icon: 'hotel'; class: 'full-width';
				class: 'backdrop-btn';
				label: 'Select Location' ] ]
]

{ #category : #'tab - sleep' }
CraneApp >> renderSleepTabPanelOn: html [

	html qTabPanel name: 'sleep'; class: 'q-pa-none'; with: [
		self renderSleepSearchOn: html.
		self renderSleepListOn: html ]
]

{ #category : #rendering }
CraneApp >> renderTabPanelsOn: html [

	html qTabPanels vModel: 'tab'; animated; with: [
		self renderFlyTabPanelOn: html.
		self renderSleepTabPanelOn: html.
		self renderEatTabPanelOn: html ]
]

{ #category : #rendering }
CraneApp >> renderTabsOn: html [

	html qTabs
		vModel: self tab refName;
		align: 'left';
		with: [
			html qTab name: 'fly'; label: 'Fly'; vOn: 'click' with: self tab emitRefSetFunctionName, '("fly")'.
			html qTab name: 'sleep'; label: 'Sleep'; vOn: 'click' with: self tab emitRefSetFunctionName, '("sleep")'.
			html qTab name: 'eat'; label: 'Eat'; vOn: 'click' with: self tab emitRefSetFunctionName, '("eat")' ]
]

{ #category : #accessing }
CraneApp >> sleepFilter [

	^ sleepFilter
]

{ #category : #accessing }
CraneApp >> sleepFilter: anObject [

	sleepFilter := anObject
]

{ #category : #accessing }
CraneApp >> tab [

	^ tab
]

{ #category : #accessing }
CraneApp >> tab: anObject [

	tab := anObject
]

{ #category : #updating }
CraneApp >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.

	anHtmlRoot stylesheet url: (CraneLibrary urlOf: #craneCss).
	anHtmlRoot javascript url: 'https://js.stripe.com/v3/'

]

{ #category : #'tab - fly' }
CraneApp >> xrenderEatSearchOn: html [
	| filterComponent filterDescription attrComponent attrDescription |

	filterComponent := self eatFilter asComponent.
	filterDescription := filterComponent magritteDescription.

	attrDescription := filterDescription
		detect: [ :eachDescription | eachDescription label = '# Diners' ]
		ifNone: [ nil ].
	attrComponent := filterComponent childAt: attrDescription.
	html render: attrComponent.

	attrDescription := filterDescription
		detect: [ :eachDescription | eachDescription label = 'Cuisine' ]
		ifNone: [ nil ].
	attrComponent := filterComponent childAt: attrDescription.
	html render: attrComponent.

	attrDescription := filterDescription
		detect: [ :eachDescription | eachDescription label = 'Dining Time' ]
		ifNone: [ nil ].
	attrComponent := filterComponent childAt: attrDescription.
	html render: attrComponent.

	attrDescription := filterDescription
		detect: [ :eachDescription | eachDescription label = 'Location' ]
		ifNone: [ nil ].
	attrComponent := filterComponent childAt: attrDescription.
	html render: attrComponent.
]
