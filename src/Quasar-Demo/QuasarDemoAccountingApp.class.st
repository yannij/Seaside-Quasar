Class {
	#name : #QuasarDemoAccountingApp,
	#superclass : #QuasarDemoApp,
	#instVars : [
		'repository',
		'username',
		'login',
		'tab',
		'sideSheet',
		'sideSheetOpen',
		'model',
		'modelView'
	],
	#category : #'Quasar-Demo-Accounting'
}

{ #category : #'demo data' }
QuasarDemoAccountingApp class >> accountingRepository [

	^ self repositoryClass
		mapAt: self databasePath
		ifAbsent: [ (self repositoryClass onPath: self databasePath) open; yourself ]
]

{ #category : #'demo data' }
QuasarDemoAccountingApp class >> createData [
	"Run this code only in a concrete subclass. See #repositoryClass implementors"
	| repo |

	self repositoryClass mapReset.
	self repositoryClass mapCreateAt: self databasePath.

	repo := self accountingRepository.
	self createDemoUsersIn: repo.
	self createDemoCompaniesIn: repo.
	self createDemoAccountsIn: repo.
	self createDemoUserCompaniesIn: repo.
	self createDemoTransactionsIn: repo
]

{ #category : #'demo data' }
QuasarDemoAccountingApp class >> createDemoAccountsIn: aRepository [
	| modelClass |

	modelClass := QuasarDemoAccountingAccount.
	aRepository removeAll: modelClass.

	#(
	(1 1 'regular' 'Test Account-1-1' '22C-001' 'CDN' 1000.00 'TD Bank')
	(2 1 'regular' 'Test Account-1-2' '22C-002' 'CDN' 1100.00 'TD Bank')
	(3 1 'regular' 'Test Account-1-3' '22U-001' 'USD' 1200.00 'TD Bank')
	(4 1 'regular' 'CB-1' '7777-001' 'CDN' 1000.00 'CIBC')
	(5 1 'regular' 'CB-1' '7777-002' 'CDN' 1000.00 'CIBC')
	(6 1 'regular' 'CB-1' '7777-003' 'CDN' 1000.00 'CIBC')
	(7 1 'regular' 'CB-1' '7777-004' 'CDN' 1000.00 'CIBC')
	(8 1 'regular' 'CB-1' '7777-005' 'CDN' 1000.00 'CIBC')
	(9 1 'regular' 'CB-1' '7777-006' 'CDN' 1000.00 'CIBC')
	(10 1 'regular' 'CB-1' '7777-007' 'CDN' 1000.00 'CIBC')
	(11 2 'regular' 'Test Account-2' '5555-001' 'USD' 2000.00 'CIBC')
	(12 3 'non-profit' 'Test Account-3' 'RB-1234-001' 'CDN' 3000.00 'Royal Bank')
	) do: [ :data | | newObject |
		newObject := modelClass new
			id: (data at: 1);
			companyId: (data at: 2);
			type: (data at: 3);
			name: (data at: 4);
			number: (data at: 5);
			currencyCode: (data at: 6);
			openingBalance: (data at: 7);
			bankName: (data at: 8);
			yourself.
		aRepository save: newObject ]
]

{ #category : #'demo data' }
QuasarDemoAccountingApp class >> createDemoCompaniesIn: aRepository [
	| modelClass |

	modelClass := QuasarDemoAccountingCompany.
	aRepository removeAll: modelClass.

	#(
	(1 'Test Company-1' 'www.company1.biz' '' 'BIZ-0001' 'CA' 'CAD')
	(2 'Test Company-2' 'www.company2.biz' '' 'BIZ-0002' 'CA' 'USD')
	(3 'Test Company-3' 'www.company3.org' '' 'ORG-0001' 'CA' 'CAD')
	(4 'Test Company-4' 'www.company4.org' '' 'ORG-0002' 'CA' 'CAD')
	) do: [ :data | | newObject |
		newObject := modelClass new
			id: (data at: 1);
			name: (data at: 2);
			website: (data at: 3);
			email: (data at: 4);
			taxNumber: (data at: 5);
			country: (data at: 6);
			currency: (data at: 7);
			yourself.
		aRepository save: newObject ]
]

{ #category : #'demo data' }
QuasarDemoAccountingApp class >> createDemoTransactionsIn: aRepository [
	| modelClass all account |

	modelClass := QuasarDemoAccountingTransaction.
	aRepository removeAll: modelClass.

	all := aRepository selectMany: QuasarDemoAccountingAccount where: [ :each | each name = 'Test Account-1-1' ].
	account := all asOrderedCollection first.
	3 timesRepeat: [ | newObject |
		newObject := modelClass randomOnAccount: account in: aRepository.
		aRepository save: newObject ]
]

{ #category : #'demo data' }
QuasarDemoAccountingApp class >> createDemoUserCompaniesIn: aRepository [
	| modelClass |

	modelClass := QuasarDemoAccountingUserCompany.
	aRepository removeAll: modelClass.

	#(
	(1 1)
	(1 2)
	(1 3)
	(1 4)
	(2 2)
	) do: [ :data | | newObject |
		newObject := modelClass new
			id: (SystemVersion current major >= 12
					ifTrue: [ UUID new ]
					ifFalse: [ UUIDGenerator next ]);
			userId: (data at: 1);
			companyId: (data at: 2);
			yourself.
		aRepository save: newObject ]
]

{ #category : #'demo data' }
QuasarDemoAccountingApp class >> createDemoUsersIn: aRepository [
	| modelClass |

	modelClass := QuasarDemoAccountingUser.
	aRepository removeAll: modelClass.

	#(
	(1 'Test User1' 'tu1@test.co' 'en_ca')
	(2 'Test User2' 'tu2@test.co' 'en_ca')
	(3 'Test User3' 'tu3@test.co' 'en_ca')
	(4 'Test User4' 'tu4@test.co' 'en_ca')
	(5 'Test User5' 'tu5@test.co' 'en_ca')
	(6 'Test User6' 'tu6@test.co' 'en_ca')
	(7 'Test User7' 'tu7@test.co' 'en_ca')
	(8 'Test User8' 'tu8@test.co' 'en_ca')
	) do: [ :data | | newObject |
		newObject := modelClass new
			"id name email locale"
			id: data first;
			name: data second;
			email: data third;
			locale: data fourth;
			yourself.
		aRepository save: newObject ]
]

{ #category : #'demo data' }
QuasarDemoAccountingApp class >> databasePath [

	^ 'demo-acct'
]

{ #category : #'demo data' }
QuasarDemoAccountingApp class >> repositoryClass [

	self subclassResponsibility
]

{ #category : #'rendering - table' }
QuasarDemoAccountingApp >> addCols: aList modelClass: aClass [
	| refName data |

	refName := aClass modelName, 'Cols'.
	data := OrderedCollection new.
	data add: (Dictionary new
				at: 'name' put: 'actions';
				at: 'label' put: 'Actions';
				at: 'field' put: (JSStream on: 'row => row.actions');
				at: 'align' put: 'left';
				yourself).

	aClass attributeData do: [ :each | | columnData |
		columnData := Dictionary new
				at: 'name' put: each;
				at: 'label' put: each capitalized;
				at: 'field' put: each;
				"at: 'sortable' put: true;"
				at: 'align' put: 'left';
				yourself.
		data add: columnData ].

	self qdemoApp vueRefsSet: refName -> data.
	^ refName
]

{ #category : #'rendering - table' }
QuasarDemoAccountingApp >> addRows: aList modelClass: aClass on: html [
	| refName data |

	refName := aClass modelName, 'Rows'.
	data := OrderedCollection new.
	aList do: [ :eachItem | | map actions |
		map := eachItem asMap.

		actions := OrderedCollection new.
		actions add: ({'id' -> 'nav'. 'icon' -> 'arrow_forward'. 'href' -> (html urlForAction: [ self modelSet: eachItem ]) } asDictionary).
		map at: 'actions' put: actions.

		data add: map ].

	self qdemoApp vueRefsSet: refName -> data.
	^ refName
]

{ #category : #accessing }
QuasarDemoAccountingApp >> applicationTitle [

	^ 'Accounting'
]

{ #category : #initialization }
QuasarDemoAccountingApp >> initialize [

	super initialize.

	self repositorySetup.
	self login: QuasarDemoLogin new.
	self sideSheetOpen: ((QuasarRefCallback name: 'sideSheetOpen' value: true) traceOn; yourself).
	self reactiveObjectsAddIfAbsent: self sideSheetOpen.
	self sideSheet: QuasarDemoSideSheet new.
	self tab: 'users'
]

{ #category : #accessing }
QuasarDemoAccountingApp >> login [

	^ login
]

{ #category : #accessing }
QuasarDemoAccountingApp >> login: anObject [

	login := anObject
]

{ #category : #accessing }
QuasarDemoAccountingApp >> model [

	^ model
]

{ #category : #accessing }
QuasarDemoAccountingApp >> model: anObject [

	model := anObject
]

{ #category : #accessing }
QuasarDemoAccountingApp >> modelSet: anObject [

	self model: anObject.
	anObject
		ifNil: [ self modelView: nil ]
		ifNotNil: [ self modelView: (anObject viewClass on: anObject) ]
]

{ #category : #accessing }
QuasarDemoAccountingApp >> modelView [

	^ modelView
]

{ #category : #accessing }
QuasarDemoAccountingApp >> modelView: anObject [

	modelView := anObject
]

{ #category : #'rendering - quasar hooks' }
QuasarDemoAccountingApp >> quasarConfigContentOn: aJSStream with: html [

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
QuasarDemoAccountingApp >> renderAccountsOn: html [

	self tab = 'accounts' ifFalse: [ ^ self ].

	self
		renderModelList: (self repository selectAll: QuasarDemoAccountingAccount)
		on: html
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderCompaniesOn: html [

	self tab = 'companies' ifFalse: [ ^ self ].

	self
		renderModelList: (self repository selectAll: QuasarDemoAccountingCompany)
		on: html
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderLayoutOn: html [

	self username ifNil: [
		html qApp id: self appId; with: [
			html render: self login ].
		^ self ].

	html qApp id: self appId; with: [
		html qLayout view: 'hHh lpR fFf'; vCloak; with: [
			html qHeader heightHint: 98; class: 'bg-primary'; with: [
				html qToolbar with: [
					"html qBtn dense; flat; round; icon: 'menu'; vOnClick: 'this.$refs.leftDrawer.toggle($event)'."
					html qImg src: (QuasarDemoAccountinglLibrary urlOf: #cranelogoPng); style: 'height: 56px; width: 56px'.
					self renderTabsOn: html.
					html qSpace.
					html qBtn flat; round; icon: 'view_sidebar'; vOnClick: 'this.$refs.sideSheet.toggle($event)' ] ].
			self renderLayoutPageOn: html.
			html render: self sideSheet ] ]
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderLayoutPageOn: html [

	html qPageContainer with: [
		html qPage with: [
			self renderModelOn: html ] ]
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderModelList: aList on: html [

	html qList style: 'background: white'; with: [
		aList do: [ :eachObject |
			html qItem qTag: 'a'; href: (html urlForAction: [ self modelSet: eachObject ]); with: [
				html qItemSection top; avatar; with: [
					html qAvatar color: 'primary'; textColor: 'white'; icon: 'star' ].
				html qItemSection with: [
					html qItemLabel with: eachObject name.
					html qItemLabel caption; "lines: 2;"
						with: eachObject summaryString ].
				"html qItemSection with: [
					html qItemLabel style: 'color: red'; with: eachObject price ]" ] ] ]
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderModelOn: html [

	self modelView isNil ifTrue: [
		^ html heading level2; with: 'No model selected' ].

	html render: self modelView
]

{ #category : #'rendering - table' }
QuasarDemoAccountingApp >> renderModelTable: aList modelClass: aClass title: aTitleString on: html [

	html qTable
		class: 'q-mt-sm';
		title: aTitleString;
		flat; bordered;
		columns: (self addCols: aList modelClass: aClass);
		rows: (self addRows: aList modelClass: aClass on: html);
		vBind: 'pagination' with: '{rowsPerPage: 10}';
		rowKey: 'name';
		with: [
			html qTemplate vSlot: 'body-cell-actions' with: 'props'; with: [
				html qTd vBind: 'props' with: 'props'; with: [
					html qBtn
						round; outline; color: 'primary';
						vFor: 'actions in props.value';
						vBind: 'key' with: 'actions.id';
						vBind: 'icon' with: 'actions.icon';
						vBind: 'href' with: 'actions.href' ] ] ]
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderTabPanelsOn: html [

	html qTabPanels "vModel: 'tab';" modelValue: self tab; animated; with: [
		html qTabPanel name: 'companies'; class: 'q-pa-none'; with: [ self renderCompaniesOn: html ].
		html qTabPanel name: 'accounts'; class: 'q-pa-none'; with: [ self renderAccountsOn: html ].
		html qTabPanel name: 'users'; class: 'q-pa-none'; with: [ self renderUsersOn: html ] ]
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderTabsOn: html [

	html qTabs
		vModel: self tab;
		with: [
			html qRouteTab label: 'Companies'; href: (html urlForAction: [ self tabSet: 'companies' ]).
			html qRouteTab label: 'Accounts'; href: (html urlForAction: [ self tabSet: 'accounts' ]).
			html qRouteTab label: 'Users'; href: (html urlForAction: [ self tabSet: 'users' ]) ]
]

{ #category : #rendering }
QuasarDemoAccountingApp >> renderUsersOn: html [

	self tab = 'users' ifFalse: [ ^ self ].

	self
		renderModelList: (self repository selectAll: QuasarDemoAccountingUser)
		on: html
]

{ #category : #accessing }
QuasarDemoAccountingApp >> repository [

	^ repository
]

{ #category : #accessing }
QuasarDemoAccountingApp >> repository: anObject [

	repository := anObject
]

{ #category : #initialization }
QuasarDemoAccountingApp >> repositorySetup [

	self repository: self class accountingRepository
]

{ #category : #accessing }
QuasarDemoAccountingApp >> sideSheet [

	^ sideSheet
]

{ #category : #accessing }
QuasarDemoAccountingApp >> sideSheet: anObject [

	sideSheet := anObject
]

{ #category : #accessing }
QuasarDemoAccountingApp >> sideSheetOpen [

	^ sideSheetOpen
]

{ #category : #accessing }
QuasarDemoAccountingApp >> sideSheetOpen: anObject [

	sideSheetOpen := anObject
]

{ #category : #accessing }
QuasarDemoAccountingApp >> tab [

	^ tab
]

{ #category : #accessing }
QuasarDemoAccountingApp >> tab: anObject [

	tab := anObject
]

{ #category : #accessing }
QuasarDemoAccountingApp >> tabSet: anObject [

	self tab: anObject.
	self modelSet: nil
]

{ #category : #updating }
QuasarDemoAccountingApp >> updateRoot: anHtmlRoot [

	super updateRoot: anHtmlRoot.

	anHtmlRoot stylesheet url: (QuasarDemoAccountinglLibrary urlOf: #craneCss)

]

{ #category : #accessing }
QuasarDemoAccountingApp >> userSet: aUser [

	self username: aUser name.
	self modelSet: aUser
]

{ #category : #accessing }
QuasarDemoAccountingApp >> username [

	^ username
]

{ #category : #accessing }
QuasarDemoAccountingApp >> username: anObject [

	username := anObject
]
