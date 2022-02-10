"
I am a demo application inspired by the Shrine Material Design Study (https://material.io/design/material-studies/shrine.html)
"
Class {
	#name : #QShrineApp,
	#superclass : #QuasarApplication,
	#instVars : [
		'loginComponent',
		'shoppingCart',
		'stripeInterface',
		'productComponent',
		'category'
	],
	#category : #'Quasar-Demo'
}

{ #category : #initialization }
QShrineApp class >> applicationPath [

	^ 'quasar/material-study-shrine'
]

{ #category : #initialization }
QShrineApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : #accessing }
QShrineApp class >> shrineSvg: aCssClass [

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
QShrineApp >> applicationTitle [

	^ 'Shrine'
]

{ #category : #initialization }
QShrineApp >> buildLoginComponent [

	^ MDQLogin new
		loginTitle: self applicationTitle;
		authenticationBlock: [ :username :password | #guest ];
		recoverBlock: [ :username :tokenTyped :tokenSent | #guest ];
		registerBlock: [ :username :password | #guest ];
		sendTokenBlock: [ :username | '' ];
		yourself
]

{ #category : #accessing }
QShrineApp >> category [

	^ category
]

{ #category : #accessing }
QShrineApp >> category: anObject [

	category := anObject
]

{ #category : #rendering }
QShrineApp >> categoryList [

	^ #(
'Featured'
'Apartment'
'Accessories'
'Shoes'
'Tops'
'Bottoms'
'Dresses'
'My Account'
	)
]

{ #category : #initialization }
QShrineApp >> initialize [

	super initialize.

	self stripeInterface: StripeInterfaceBasic new.
	"self shoppingCart: self stripeInterface shoppingCartNew."
	self shoppingCart: MDQStripeCheckout new.
	self shoppingCart cartVisible: true.
	self category: self categoryList first
]

{ #category : #accessing }
QShrineApp >> loginComponent [

	^ loginComponent
]

{ #category : #accessing }
QShrineApp >> loginComponent: anObject [

	loginComponent := anObject
]

{ #category : #accessing }
QShrineApp >> productComponent [

	^ productComponent ifNil: [ productComponent := self productComponentBuild ]
]

{ #category : #accessing }
QShrineApp >> productComponent: anObject [

	productComponent := anObject
]

{ #category : #accessing }
QShrineApp >> productComponentBuild [

	^ QShrineCanvas new
]

{ #category : #rendering }
QShrineApp >> renderBottomSheetOn: html [

	html qDialog
		ref: 'bottomSheet'; persistent; maximized; transitionShow: 'slide-up'; transitionHide: 'slide-down';
		with: [
			self renderShoppingCartOn: html ].

	html qPageSticky position: 'top-right'; offset: '[0, 12]'; with: [
		html qBtn fab; unelevated; icon: 'shopping_cart';
			color: 'secondary'; textColor: 'black';
			vOnClick: 'this.$refs.bottomSheet.show($event)' ]
]

{ #category : #rendering }
QShrineApp >> renderLayoutOn: html [

	html script: 'document.body.style.setProperty(''--q-primary'', ''#0273d4'')'.

	self isLoggedIn
		ifTrue: [ self renderLayoutShrineOn: html ]
		ifFalse: [
			self loginComponent
				ifNotNil: [ :value | html render: value  ]
				ifNil: [
					"self anonymousLoginAllowed" false
						ifTrue: [ self renderLayoutShrineOn: html ]
						ifFalse: [
							self loginComponent ifNil: [ self loginComponent: self buildLoginComponent ].
							html render: self loginComponent ] ] ]
]

{ #category : #rendering }
QShrineApp >> renderLayoutPageOn: html [

	html qPageContainer with: [
		html qPage with: [
			self renderSettingsFabOn: html.
			html div class: 'q-pr-xl'; with: [
				html render: self productComponent ] ] ]
]

{ #category : #rendering }
QShrineApp >> renderLayoutShrineOn: html [

	html qApp with: [
		html qLayout view: 'hHh lpR fFf'; with: [
		"html qHeader heightHint: 98; class: 'bg-primary'; style: 'color: #442C2E'; with: [
			html qToolbar with: [
				html qBtn dense; flat; round; icon: 'menu'; vOnClick: 'this.$refs.leftDrawer.toggle($event)'.
				html qToolbarTitle with: [ html text: 'Shrine' ].
				html qBtn dense; flat; round; icon: 'view_sidebar'; vOnClick: 'this.$refs.rightDrawer.toggle($event)' ] ]."
			self renderLeftDrawerOn: html.
			self renderLayoutPageOn: html.
			self renderSideSheetOn: html.
			self renderBottomSheetOn: html.
			"self renderSettingsFabOn: html" ] ]
]

{ #category : #rendering }
QShrineApp >> renderLeftDrawerOn: html [

	html qDrawer ref: 'leftDrawer'; showIfAbove; persistent; side: 'left'; with: [
		html qScrollArea class: 'fit'; with: [
			self renderNavBrandingOn: html.
			self renderNavOn: html ] ]
]

{ #category : #rendering }
QShrineApp >> renderNavBrandingOn: html [

	html div style: 'text-align: center; margin-bottom: 48px; padding-top: 40px'; with: [
		html html: (QShrineApp shrineSvg: 'shrine-logo-drawer').
		html break.
		html span "heading level6; class: 'text-h6';"
			class: 'text-center';
			class: 'text-uppercase';
			style: 'font-size: 1.25rem';
			with: 'Shrine' ]
]

{ #category : #rendering }
QShrineApp >> renderNavOn: html [

	html qList with: [
		self categoryList do: [ :eachCategory |
			html qItem
				qTag: 'a'; href: (html urlForAction: [ self category: eachCategory ]);
				with: [
					html qItemSection class: 'text-center'; with: eachCategory ] ] ]
]

{ #category : #rendering }
QShrineApp >> renderQuasarSetupOn: html [

	html document addLoadScript: (JSStream on: 'const app = Vue.createApp({
	setup () {
		return {}
	}
})
app.use(Quasar, {
  config: {
    brand: {
      primary: ''#FEDBD0'',
      secondary: ''#FEEAE6'',
      accent: ''#9C27B0'',
      dark: ''#1d1d1d'',
      positive: ''#21BA45'',
      negative: ''#C10015'',
      info: ''#31CCEC'',
      warning: ''#F2C037''
    }
  }
})
app.mount(''q-app'')')
]

{ #category : #rendering }
QShrineApp >> renderSettingsFabOn: html [
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
QShrineApp >> renderShoppingCartOn: html [

	html qCard flat;
		style: 'background: var(--q-secondary)';
		style: 'max-width: 400px';
		with: [
			html qCardSection class: 'q-pa-sm'; with: [
				html render: self shoppingCart ].
			html qCardActions vertical; class: 'q-pa-sm'; with: [
				html qBtn icon: 'close'; vClosePopUp; style: 'background: var(--q-primary)'; with: 'Close' ] ]
]

{ #category : #rendering }
QShrineApp >> renderSideSheetOn: html [

	html qDrawer ref: 'sideSheet'; showIfAbove; side: 'right'; bordered; class: 'bg-secondary';
		with: [ self renderShoppingCartOn: html ].

	"html qPageSticky position: 'top-right'; offset: '[0, 76]'; with: [
		html qBtn fab; unelevated; icon: 'view_sidebar';
			color: 'secondary'; textColor: 'black';
			vOnClick: 'this.$refs.sideSheet.toggle($event)' ]"
]

{ #category : #accessing }
QShrineApp >> shoppingCart [

	^ shoppingCart
]

{ #category : #accessing }
QShrineApp >> shoppingCart: anObject [

	shoppingCart := anObject
]

{ #category : #accessing }
QShrineApp >> stripeInterface [

	^ stripeInterface
]

{ #category : #accessing }
QShrineApp >> stripeInterface: anObject [

	stripeInterface := anObject
]

{ #category : #updating }
QShrineApp >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.

	anHtmlRoot javascript url: 'https://js.stripe.com/v3/'

]
