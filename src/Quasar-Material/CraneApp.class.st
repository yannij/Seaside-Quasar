"
I am a demo application inspired by the Crane Material Design Study (https://material.io/design/material-studies/crane.html)
"
Class {
	#name : #CraneApp,
	#superclass : #QuasarApplication,
	#instVars : [
		'tab',
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
CraneApp class >> shrineSvg: aCssClass [

	^ '<svg class="', aCssClass, '" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Layer_1" x="0px" y="0px" width="48px" height="48px" viewBox="0 0 24 24" enable-background="new 0 0 24 24" xml:space="preserve" fill="#000000">
      <g id="XMLID_2_">
        <g id="XMLID_4_">
          <path id="XMLID_5_" d="M17,2H7L2,6.62L12,22L22,6.62L17,2z M16.5,3.58l3.16,2.92H16.5V3.58z M7.59,3.5H15v3H4.34L7.59,3.5z     M11.25,18.1L7.94,13h3.31V18.1z M11.25,11.5H6.96L4.69,8h6.56V11.5z M16.5,12.32 M12.75,18.09V8h6.56L12.75,18.09z"/>
        </g>
        <rect id="XMLID_1_" fill="none" width="24" height="24"/>
      </g>
    </svg>
'
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

	self tab: ((QuasarReactiveObject name: 'tab' value: 'fly') transformBlock: [ :value | value ]; yourself).
	self reactiveObjectsAdd: self tab.

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

	newReactive := (QuasarReactiveObject name: 'origin' value: nil) "transformBlock: [ :value | value ];" yourself.
	self flyFilter origin: newReactive.
	self reactiveObjectsAdd: newReactive.

	newReactive := (QuasarReactiveObject name: 'destination' value: nil) "transformBlock: [ :value | value ];" yourself.
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

	html div class: 'row'; "class: 'q-gutter-sm';" style: 'background: #5d1049'; with: [
		html qBtn class: 'col-3'; flat; unelevated; noCaps; icon: 'person';
			style: 'background: #720d5d; color: white';
			label: self eatFilter dinersDisplay.
		html qBtn class: 'col-3'; flat; unelevated; noCaps; icon: 'event';
			style: 'background: #720d5d; color: white';
			label: self eatFilter diningDate refValue greaseString.
		html qBtn class: 'col-3'; flat; unelevated; noCaps; icon: 'watch_later';
			style: 'background: #720d5d; color: white';
			label: self eatFilter diningTime refValue printMinutes.
		html qBtn class: 'col-3'; flat; unelevated; noCaps; icon: 'place';
			style: 'background: #720d5d; color: white';
			label: self eatFilter location ]
]

{ #category : #'tab - fly' }
CraneApp >> renderFlyListOn: html [

	html qList style: 'background: white'; with: [
		"CraneAirTrip" CraneAirport instanceList do: [ :eachObject |
			html qItem with: [
				html qItemSection top; avatar; with: [
					html qAvatar color: 'primary'; textColor: 'white'; icon: 'star' ].
				html qItemSection with: [
					html qItemLabel with: eachObject airportName.
					html qItemLabel caption;
						with: eachObject airportIATA ].
				"html qItemSection with: [
					html qItemLabel style: 'color: red'; with: eachObject price ]" ] ] ]
]

{ #category : #'tab - fly' }
CraneApp >> renderFlySearchOn: html [

	html div class: 'row'; "class: 'q-gutter-sm';" style: 'background: #5d1049'; with: [
		html qBtn class: 'col-3'; flat; unelevated; noCaps; icon: 'person';
			style: 'background: #720d5d; color: white';
			label: self flyFilter travellerSummary.
		html qBtn class: 'col-3'; flat; unelevated; noCaps; icon: 'place';
			style: 'background: #720d5d; color: white';
			label: self flyFilter origin refValue greaseString.
		html qBtn class: 'col-3'; flat; unelevated; noCaps; icon: 'flight';
			style: 'background: #720d5d; color: white';
			label: self flyFilter destination refValue greaseString.
		html qBtn class: 'col-3'; flat; unelevated; noCaps; icon: 'event';
			style: 'background: #720d5d; color: white';
			label: 'Select Dates' ]
]

{ #category : #rendering }
CraneApp >> renderLayoutCraneOn: html [

	html qApp id: self appId; with: [
		html qLayout view: 'hHh lpR fFf'; with: [
		html qHeader heightHint: 98; class: 'bg-primary'; with: [
			html qToolbar with: [
				"html qBtn dense; flat; round; icon: 'menu'; vOnClick: 'this.$refs.leftDrawer.toggle($event)'."
				"html qToolbarTitle with: [ html text: 'Crane' ]."
				html span class: 'q-pr-md'; with: 'Crane'.
				self renderTabsOn: html.
				html qSpace.
				html qBtn dense; flat; round; icon: 'filter_list'; vOnClick: 'this.$refs.sideSheet.toggle($event)' ] ].
			self renderLayoutPageOn: html.
			self renderSideSheetOn: html.
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

	html qDrawer ref: 'sideSheet'; showIfAbove; side: 'right'; bordered; "class: 'bg-secondary';"
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
					html qAvatar color: 'primary'; textColor: 'white'; icon: 'star' ].
				html qItemSection with: [
					html qItemLabel with: eachObject lodgingName.
					html qItemLabel caption; "lines: 2;"
						with: eachObject lodgingType asString, ' - ', eachObject distance ].
				html qItemSection with: [
					html qItemLabel style: 'color: red'; with: eachObject price ] ] ] ]
]

{ #category : #'tab - sleep' }
CraneApp >> renderSleepSearchOn: html [

	html div class: 'row'; "class: 'q-gutter-sm';" style: 'background: #5d1049'; with: [
		html qBtn class: 'col-3'; flat; unelevated; noCaps; icon: 'person';
			style: 'background: #720d5d; color: white';
			label: self sleepFilter guestsDisplay .
		html qBtn class: 'col-3'; flat; unelevated; noCaps; icon: 'event';
			style: 'background: #720d5d; color: white';
			label: 'Select Dates'.
		html qBtn class: 'col-3'; flat; unelevated; noCaps; icon: 'hotel';
			style: 'background: #720d5d; color: white';
			label: 'Select Location' ]
]

{ #category : #rendering }
CraneApp >> renderTabPanelsOn: html [

	html qTabPanels vModel: 'tab'; animated; with: [
		html qTabPanel name: 'fly'; class: 'q-pa-none'; style: 'background: #5d1049'; with: [
			self renderFlySearchOn: html.
			self renderFlyListOn: html ].
		html qTabPanel name: 'sleep'; class: 'q-pa-none'; style: 'background: #5d1049'; with: [
			self renderSleepSearchOn: html.
			self renderSleepListOn: html ].
		html qTabPanel name: 'eat'; class: 'q-pa-none'; style: 'background: #5d1049'; with: [
			self renderEatSearchOn: html.
			self renderEatListOn: html ] ]
]

{ #category : #rendering }
CraneApp >> renderTabsOn: html [

	html qTabs vModel: 'tab'; align: 'left'; "dense; class: 'text-grey'; activeColor: 'primary'; indicatorColor: 'primary'; narrowIndicator;" with: [
		html qTab name: 'fly'; label: 'Fly'.
		html qTab name: 'sleep'; label: 'Sleep'.
		html qTab name: 'eat'; label: 'Eat' ]
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

	anHtmlRoot javascript url: 'https://js.stripe.com/v3/'

]

{ #category : #'tab - eat' }
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

{ #category : #'tab - fly' }
CraneApp >> xrenderFlySearchOn: html [
	| filterComponent filterDescription attrComponent attrDescription |

	filterComponent := self flyFilter asComponent.
	filterDescription := filterComponent magritteDescription.

	attrDescription := filterDescription
		detect: [ :eachDescription | eachDescription label = 'Cabin' ]
		ifNone: [ nil ].
	attrComponent := filterComponent childAt: attrDescription.
	html render: attrComponent.

	attrDescription := filterDescription
		detect: [ :eachDescription | eachDescription label = 'Start Date' ]
		ifNone: [ nil ].
	attrComponent := filterComponent childAt: attrDescription.
	html render: attrComponent.

	"html qDate
		vModel: 'startDate';
		range"
]
