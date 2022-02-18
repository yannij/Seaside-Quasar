"
I am a demo application showing how to use the various Quasar Framework components from Seaside.
"
Class {
	#name : #QuasarDemoComponentApp,
	#superclass : #QuasarApplication,
	#instVars : [
		'demoName',
		'demoObjectA'
	],
	#category : #'Quasar-Demo-Basic'
}

{ #category : #initialization }
QuasarDemoComponentApp class >> applicationPath [

	^ 'quasar/component-demo'
]

{ #category : #initialization }
QuasarDemoComponentApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : #accessing }
QuasarDemoComponentApp >> applicationTitle [

	^ 'Components'
]

{ #category : #accessing }
QuasarDemoComponentApp >> demoName [

	^ demoName
]

{ #category : #accessing }
QuasarDemoComponentApp >> demoName: anObject [

	demoName := anObject
]

{ #category : #accessing }
QuasarDemoComponentApp >> demoNames [

	^ #(
	Experiment
	Btn
	BtnToggle
	Card
	ColorPicker
	DateTime
	Dialog
	Drawer
	Radio
	Select
	TabPanels
	Table
	)
]

{ #category : #accessing }
QuasarDemoComponentApp >> demoObjectA [

	^ demoObjectA ifNil: [ demoObjectA := QuasarDemoObjectA new ]
]

{ #category : #accessing }
QuasarDemoComponentApp >> demoObjectA: anObject [

	demoObjectA := anObject
]

{ #category : #'demo - experiment' }
QuasarDemoComponentApp >> json2: json html: html [

	json render: (OrderedCollection new
		add: {'key' -> 1. 'value' -> Date today printString} asDictionary;
		add: {'key' -> 2. 'value' -> Time now printString} asDictionary;
		yourself)
]

{ #category : #'demo - experiment' }
QuasarDemoComponentApp >> json3: json html: html [
	| objectDictionary |

	self demoObjectA string1: DateAndTime now printString.
	self demoObjectA integer1: Time now asSeconds.
	self demoObjectA boolean1: false.
	objectDictionary := Dictionary new
		at: 'string1' put: self demoObjectA string1;
		at: 'integer1' put: self demoObjectA integer1;
		at: 'boolean1' put: self demoObjectA boolean1;
		yourself.
	json render: objectDictionary
]

{ #category : #'demo - btn' }
QuasarDemoComponentApp >> renderDemoBtnOn: html [

	html div class: 'q-pa-md'; class: 'q-gutter-sm'; with: [
		html qBtn color: 'white'; textColor: 'black'; label: 'Standard'.
		html qBtn color: 'primary'; label: 'Primary'.
		html qBtn color: 'secondary'; label: 'Secondary'.
		html qBtn color: 'amber'; label: 'Amber'.
		html qBtn color: 'brown-5'; label: 'Brown 5'.
		html qBtn color: 'deep-orange'; label: 'Deep Orange'.
		html qBtn color: 'purple'; label: 'Purple'.
		html qBtn color: 'black'; label: 'Black' ]
]

{ #category : #'demo - btn toggle' }
QuasarDemoComponentApp >> renderDemoBtnToggleOn: html [

	html div class: 'q-pa-md'; class: 'q-gutter-sm'; with: [
		html html: '<q-btn-toggle
        v-model="model"
        push
        glossy
        toggle-color="primary"
        :options="[
          {label: ''One'', value: ''one''},
          {label: ''Two'', value: ''two''},
          {label: ''Three'', value: ''three''}
        ]"
      ></q-btn-toggle>' ]
]

{ #category : #'demo - card' }
QuasarDemoComponentApp >> renderDemoCardOn: html [

	html div class: 'q-pa-md row items-start q-gutter-md'; with: [
		html qCard class: 'my-card bg-secondary text-white'; with: [
			html qCardSection with: [
				html div class: 'text-h6'; with: 'Our Changing Planet'.
				html div class: 'text-subtitle2'; with: 'by John Doe' ].
			html qCardSection with: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'.
			html qSeparator dark.
			html qCardActions with: [
				html qBtn flat; with: 'Action 1'.
				html qBtn flat; with: 'Action 2' ] ].
		html qCard class: 'my-card'; with: [
			html qCardSection with: [
				html div class: 'text-h6'; with: 'Our Changing Planet'.
				html div class: 'text-subtitle2'; with: 'by John Doe' ].
			html qSeparator dark.
			html qCardActions vertical; with: [
				html qBtn flat; with: 'Action 1'.
				html qBtn flat; with: 'Action 2' ] ].
		html qCard class: 'my-card bg-purple text-white'; with: [
			html qCardSection with: [
				html div class: 'text-h6'; with: 'Our Changing Planet'.
				html div class: 'text-subtitle2'; with: 'by John Doe' ].
			html qSeparator dark.
			html qCardActions with: [
				html qBtn flat; with: 'Action 1'.
				html qBtn flat; with: 'Action 2' ] ].
		html qCard flat; bordered; class: 'my-card bg-grey-1'; with: [
			html qCardSection with: [
				html div class: 'row items-center no-wrap'; with: [
				html div class: 'col'; with: [
					html div class: 'text-h6'; with: 'Our Planet'.
					html div class: 'text-subtitle2'; with: 'by John Doe' ].
				html div class: 'col-auto'; with: [
					html qBtn color: 'grey-7'; round; flat; icon: 'more_vert'; with: [
						html qMenu cover; autoClose; with: [
							html qList with: [
								html qItem clickable; with: [
									html qItemSection with: 'Remove Card' ].
								html qItem clickable; with: [
									html qItemSection with: 'Send Feedback' ].
								html qItem clickable; with: [
									html qItemSection with: 'Share' ] ] ] ]
					 ] ] ].
			html qCardSection with: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'.
			html qSeparator dark.
			html qCardActions with: [
				html qBtn flat; with: 'Action 1'.
				html qBtn flat; with: 'Action 2' ] ] ]
]

{ #category : #'demo - color picker' }
QuasarDemoComponentApp >> renderDemoColorPickerOn: html [

	html div class: 'q-pa-md'; class: 'q-gutter-sm'; with: [
		html qInput filled; vModel: 'color'; with: [
			html qTemplate vSlot: 'append'; with: [
				html qIcon name: 'colorize'; class: 'cursor-pointer'; with: [
					html qPopupProxy cover; transitionShow: 'scale'; transitionHide: 'scale'; with: [
						html qColor vModel: 'color' ] ] ] ] ]
]

{ #category : #'demo - date time' }
QuasarDemoComponentApp >> renderDemoDateTimeOn: html [

	html div style: 'max-width: 300px'; with: [
		html qInput filled; vModel: 'date'; with: [
			html qTemplate vSlot: 'prepend'; with: [
				html qIcon name: 'event'; class: 'cursor-pointer'; with: [
					html qPopupProxy cover; transitionShow: 'scale'; transitionHide: 'scale'; with: [
						html qDate vModel: 'date'; mask: 'YYYY-MM-DD HH:mm'; with: [
							html div class: 'row items-center justify-end'; with: [
								html qBtn vClosePopUp; label: 'Close'; color: 'primary'; flat ] ] ] ] ].
			html qTemplate vSlot: 'append'; with: [
				html qIcon name: 'access_time'; class: 'cursor-pointer'; with: [
					html qPopupProxy cover; transitionShow: 'scale'; transitionHide: 'scale'; with: [
						html qTime vModel: 'date'; mask: 'YYYY-MM-DD HH:mm'; format24h; with: [
							html div class: 'row items-center justify-end'; with: [
								html qBtn vClosePopUp; label: 'Close'; color: 'primary'; flat ] ] ] ] ] ] ]
]

{ #category : #'demo - dialog' }
QuasarDemoComponentApp >> renderDemoDialogOn: html [

"
<script>
import { ref } from 'vue'

export default {
  setup () {
    return {
      dialog: ref(false),
      cancelEnabled: ref(false)
    }
  }
}
</script>
"

	html div class: 'q-pa-md'; with: [
		html html: '
    <q-btn label="Open Dialog" color="primary" @click="dialog = true" />

    <q-dialog v-model="dialog" persistent>
      <q-card>
        <q-card-section class="row items-center">
          <q-avatar icon="signal_wifi_off" color="primary" text-color="white" />
          <span class="q-ml-sm">You are currently not connected to any network.</span>
        </q-card-section>

        <q-card-section class="row items-center">
          <q-toggle v-model="cancelEnabled" label="Cancel button enabled" />
        </q-card-section>

        <!-- Notice v-close-popup -->
        <q-card-actions align="right">
          <q-btn flat label="Cancel" color="primary" v-close-popup="cancelEnabled" :disable="!cancelEnabled" />
          <q-btn flat label="Turn on Wifi" color="primary" v-close-popup />
        </q-card-actions>
      </q-card>
    </q-dialog>
' ]
]

{ #category : #'demo - drawer' }
QuasarDemoComponentApp >> renderDemoDrawerOn: html [

	html html: '<div id="q-app" style="min-height: 100vh;">
  <div class="q-pa-md">
    <q-layout view="hHh Lpr lff" container style="height: 300px" class="shadow-2 rounded-borders">
      <q-header elevated class="bg-black">
        <q-toolbar>
          <q-btn flat @click="drawer = !drawer" round dense icon="menu"></q-btn>
          <q-toolbar-title>Header</q-toolbar-title>
        </q-toolbar>
      </q-header>

      <q-drawer
        v-model="drawer"
        show-if-above
        :width="200"
        :breakpoint="500"
        bordered
        class="bg-grey-3"
      >
        <q-scroll-area class="fit">
          <q-list>

            <template v-for="(menuItem, index) in menuList" :key="index">
              <q-item clickable :active="menuItem.label === ''Outbox''" v-ripple>
                <q-item-section avatar>
                  <q-icon :name="menuItem.icon"></q-icon>
                </q-item-section>
                <q-item-section>
                  {{ menuItem.label }}
                </q-item-section>
              </q-item>
              <q-separator :key="''sep'' + index"  v-if="menuItem.separator"></q-separator>
            </template>

          </q-list>
        </q-scroll-area>
      </q-drawer>

      <q-page-container>
        <q-page padding>
          <p v-for="n in 15" :key="n">
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Fugit nihil praesentium molestias a adipisci, dolore vitae odit, quidem consequatur optio voluptates asperiores pariatur eos numquam rerum delectus commodi perferendis voluptate?
          </p>
        </q-page>
      </q-page-container>
    </q-layout>
  </div>
</div>'
]

{ #category : #'demo - experiment' }
QuasarDemoComponentApp >> renderDemoExperimentOn: html [

	html div with: [
		html qBtn
			label: 'experiment-1';
			vOnClick: 'onClickExperiment1($event)' ].

	html qSeparator spaced.
	html div class: 'q-pa-sm'; with: [
		html div with: 'experiment2: {{ experiment2 }}'.
		html qChip vFor: 'ex in experiment2'; vBind: 'key' with: 'ex.key'; with: '{{ ex.value }}' ].

	html div with: [
		html qBtn
			label: 'experiment-2';
			vOnClick: 'onClickExperiment2()' ].

	html qSeparator spaced.
	html div class: 'q-pa-sm'; with: [
		html div with: 'experiment3: {{ experiment3 }}'.
		"html qChip vFor: 'ex in experiment3'; vBind: 'key' with: 'ex.key'; with: '{{ ex.value }}'" ].
	html div with: [
		html qBtn
			label: 'experiment-3';
			vOnClick: 'onClickExperiment3()' ].
]

{ #category : #'demo - radio' }
QuasarDemoComponentApp >> renderDemoRadioOn: html [

	html div class: 'q-pa-md'; with: [
		html div class: 'q-gutter-sm'; with: [
			html qRadio vModel: 'shape'; val: 'line'; label: 'Line'.
			html qRadio vModel: 'shape'; val: 'rectangle'; label: 'Rectangle'.
			html qRadio vModel: 'shape'; val: 'ellipse'; label: 'Ellipse'.
			html qRadio vModel: 'shape'; val: 'polygon'; label: 'Polygon' ].
		html div class: 'q-px-sm'; with: [
			html html: 'Your selection is: <strong>{{ shape }}</strong>' ] ]
]

{ #category : #'demo - select' }
QuasarDemoComponentApp >> renderDemoSelectOn: html [

	html qForm vOnSubmit: 'onSubmit'; class: 'q-gutter-md'; with: [
		html qSelect
			name: 'preferred_genre'; label: 'Preferred genre';
			vModel: 'preferred'; options: 'options';
			color: 'primary'; filled; clearable.
		html qSelect
			name: 'accepted_genres'; label: 'Accepted genre';
			vModel: 'accepted'; options: 'options';
			color: 'primary'; multiple; filled; clearable.
		html div with: [
			html qBtn label: 'Submit'; type: 'submit'; color: 'primary' ] ].

	html html: '<q-card v-if="submitEmpty" flat bordered class="q-mt-md bg-grey-2">
      <q-card-section>
        Submitted form contains empty formData.
      </q-card-section>
    </q-card>
    <q-card v-else-if="submitResult.length > 0" flat bordered class="q-mt-md bg-grey-2">
      <q-card-section>Submitted form contains the following formData (key = value):</q-card-section>
      <q-separator></q-separator>
      <q-card-section class="row q-gutter-sm items-center">
        <div
          v-for="(item, index) in submitResult"
          :key="index"
          class="q-px-sm q-py-xs bg-grey-8 text-white rounded-borders text-center text-no-wrap"
        >{{ item.name }} = {{ item.value }}</div>
      </q-card-section>
    </q-card>'
]

{ #category : #'demo - tab panels' }
QuasarDemoComponentApp >> renderDemoTabPanelsOn: html [

	html div class: 'q-pa-md'; class: 'q-gutter-sm'; with: [
		html qCard with: [
			html qTabs vModel: 'tab'; dense; class: 'text-grey'; activeColor: 'primary'; indicatorColor: 'primary'; align: 'justify'; narrowIndicator; with: [
				html qTab name: 'mails'; label: 'Mails'.
				html qTab name: 'alarms'; label: 'Alarms'.
				html qTab name: 'movies'; label: 'Movies' ].
			html qSeparator.
			html qTabPanels vModel: 'tab'; animated; with: [
				html qTabPanel name: 'mails'; with: [
					html div class: 'text-h6'; with: 'Mails'.
					html text: 'Lorem ipsum dolor sit amet consectetur adipisicing elit.' ].
				html qTabPanel name: 'alarms'; with: [
					html div class: 'text-h6'; with: 'Alarms'.
					html text: 'Lorem ipsum dolor sit amet consectetur adipisicing elit.' ].
				html qTabPanel name: 'movies'; with: [
					html div class: 'text-h6'; with: 'Movies'.
					html text: 'Lorem ipsum dolor sit amet consectetur adipisicing elit.' ] ] ] ]
]

{ #category : #'demo - table' }
QuasarDemoComponentApp >> renderDemoTableOn: html [

	html div class: 'q-pa-md'; class: 'q-gutter-sm'; with: [
		html html: '<div class="q-pa-md">
    <q-table
      title="Treats"
      :rows="rows"
      :columns="columns"
      row-key="name"
    ></q-table>
  </div>' ]
]

{ #category : #rendering }
QuasarDemoComponentApp >> renderLayoutOn: html [

	html html: '<style>
.my-card {
	width: 100%;
	max-width: 250px;
}
</style>'.

	html qApp id: self appId; with: [
		html qLayout view: 'hHh lpR fFf'; with: [
			html qHeader with: [
				html qToolbar with: [
					html qBtn dense; flat; round; icon: 'menu'; vOnClick: 'this.$refs.leftDrawer.toggle($event)'.
					html qToolbarTitle with: [ html text: 'Quasar Component Demos' ] ] ].
			self renderLeftDrawerOn: html.
			self renderLayoutPageOn: html ] ]
]

{ #category : #rendering }
QuasarDemoComponentApp >> renderLayoutPageOn: html [
	| demoSelector |

	self demoName ifNil: [ ^ self ].

	demoSelector := ('renderDemo', self demoName asString, 'On:') asSymbol.
	html qPageContainer with: [
		html qPage with: [
			html div class: 'q-pa-md'; with: [
				(self respondsTo: demoSelector)
					ifTrue: [ self perform: demoSelector with: html ]
					ifFalse: [ html text: 'Missing demo: ', demoSelector asString ] ] ] ]
]

{ #category : #rendering }
QuasarDemoComponentApp >> renderLeftDrawerOn: html [

	html qDrawer ref: 'leftDrawer'; showIfAbove; persistent; side: 'left';
		class: 'bg-primary'; style: 'color: white';
		with: [
			html qScrollArea class: 'fit'; with: [
				"self renderNavBrandingOn: html."
				self renderNavOn: html ] ]
]

{ #category : #rendering }
QuasarDemoComponentApp >> renderNavOn: html [

	html qList with: [
		self demoNames do: [ :eachItem |
			html qItem
				qTag: 'a'; href: (html urlForAction: [ self demoName: eachItem ]);
				with: [
					html qItemSection with: eachItem ] ] ]
]

{ #category : #rendering }
QuasarDemoComponentApp >> vueSetupContentOn: aJSStream [

	self vueSetupDemoExperimentOn: aJSStream.
	self vueSetupDemoDrawerOn: aJSStream.
	self vueSetupDemoTableOn: aJSStream.
	self vueSetupDemoSelectOn: aJSStream
]

{ #category : #'demo - drawer' }
QuasarDemoComponentApp >> vueSetupDemoDrawerOn: aJSStream [

	aJSStream
		nextPutAll: 'const menuList = [
  {
    icon: "inbox",
    label: "Inbox",
    separator: true
  },
  {
    icon: "send",
    label: "Outbox",
    separator: false
  },
  {
    icon: "delete",
    label: "Trash",
    separator: false
  },
  {
    icon: "error",
    label: "Spam",
    separator: true
  },
  {
    icon: "settings",
    label: "Settings",
    separator: false
  },
  {
    icon: "feedback",
    label: "Send Feedback",
    separator: false
  },
  {
    icon: "help",
    iconColor: "primary",
    label: "Help",
    separator: false
  }
];'
]

{ #category : #'demo - experiment' }
QuasarDemoComponentApp >> vueSetupDemoExperimentOn: aJSStream [

	aJSStream
		nextPutAll: 'const experiment2 = ref([{key: 1, value: ''original value''}]);';
		nextPutAll: 'const experiment3 = ref(null);'
]

{ #category : #'demo - select' }
QuasarDemoComponentApp >> vueSetupDemoSelectOn: aJSStream [

	aJSStream
		nextPutAll: 'const submitEmpty = ref(false);';
		nextPutAll: 'const submitResult = ref([]);'
]

{ #category : #'demo - table' }
QuasarDemoComponentApp >> vueSetupDemoTableOn: aJSStream [

	^ aJSStream nextPutAll: '
const columns = [
  {
    name: ''name'',
    required: true,
    label: ''Dessert (100g serving)'',
    align: ''left'',
    field: row => row.name,
    format: val => `${val}`,
    sortable: true
  },
  { name: ''calories'', align: ''center'', label: ''Calories'', field: ''calories'', sortable: true },
  { name: ''fat'', label: ''Fat (g)'', field: ''fat'', sortable: true },
  { name: ''carbs'', label: ''Carbs (g)'', field: ''carbs'' },
  { name: ''protein'', label: ''Protein (g)'', field: ''protein'' },
  { name: ''sodium'', label: ''Sodium (mg)'', field: ''sodium'' },
  { name: ''calcium'', label: ''Calcium (%)'', field: ''calcium'', sortable: true, sort: (a, b) => parseInt(a, 10) - parseInt(b, 10) },
  { name: ''iron'', label: ''Iron (%)'', field: ''iron'', sortable: true, sort: (a, b) => parseInt(a, 10) - parseInt(b, 10) }
];

const rows = [
  {
    name: ''Frozen Yogurt'',
    calories: 159,
    fat: 6.0,
    carbs: 24,
    protein: 4.0,
    sodium: 87,
    calcium: ''14%'',
    iron: ''1%''
  },
  {
    name: ''Ice cream sandwich'',
    calories: 237,
    fat: 9.0,
    carbs: 37,
    protein: 4.3,
    sodium: 129,
    calcium: ''8%'',
    iron: ''1%''
  },
  {
    name: ''Eclair'',
    calories: 262,
    fat: 16.0,
    carbs: 23,
    protein: 6.0,
    sodium: 337,
    calcium: ''6%'',
    iron: ''7%''
  },
  {
    name: ''Cupcake'',
    calories: 305,
    fat: 3.7,
    carbs: 67,
    protein: 4.3,
    sodium: 413,
    calcium: ''3%'',
    iron: ''8%''
  },
  {
    name: ''Gingerbread'',
    calories: 356,
    fat: 16.0,
    carbs: 49,
    protein: 3.9,
    sodium: 327,
    calcium: ''7%'',
    iron: ''16%''
  },
  {
    name: ''Jelly bean'',
    calories: 375,
    fat: 0.0,
    carbs: 94,
    protein: 0.0,
    sodium: 50,
    calcium: ''0%'',
    iron: ''0%''
  },
  {
    name: ''Lollipop'',
    calories: 392,
    fat: 0.2,
    carbs: 98,
    protein: 0,
    sodium: 38,
    calcium: ''0%'',
    iron: ''2%''
  },
  {
    name: ''Honeycomb'',
    calories: 408,
    fat: 3.2,
    carbs: 87,
    protein: 6.5,
    sodium: 562,
    calcium: ''0%'',
    iron: ''45%''
  },
  {
    name: ''Donut'',
    calories: 452,
    fat: 25.0,
    carbs: 51,
    protein: 4.9,
    sodium: 326,
    calcium: ''2%'',
    iron: ''22%''
  },
  {
    name: ''KitKat'',
    calories: 518,
    fat: 26.0,
    carbs: 65,
    protein: 7,
    sodium: 54,
    calcium: ''12%'',
    iron: ''6%''
  }
];'
]

{ #category : #rendering }
QuasarDemoComponentApp >> vueSetupReturnContentOn: aJSStream html: html [

	self vueSetupReturnDemoExperimentOn: aJSStream html: html.
	aJSStream nextPut: $,.

	self vueSetupReturnDemoSelectOn: aJSStream.
	aJSStream nextPut: $,.
	self vueSetupReturnDemoTableOn: aJSStream.
	aJSStream nextPut: $,.
	self vueSetupReturnDemoDrawerOn: aJSStream.
	aJSStream nextPut: $,.
	
	aJSStream nextPutAll: '
date: ref("2019-02-01 12:44"),
color: ref("#FF00FF"),
tab: ref(''mails''),
shape: ref(''line'')'
]

{ #category : #'demo - drawer' }
QuasarDemoComponentApp >> vueSetupReturnDemoDrawerOn: aJSStream [

	aJSStream nextPutAll: 'drawer: ref(false), menuList'
]

{ #category : #'demo - experiment' }
QuasarDemoComponentApp >> vueSetupReturnDemoExperiment1On: aJSStream html: html [

	aJSStream
		nextPutAll: 'onClickExperiment1(evt) {alert("hello");}'
]

{ #category : #'demo - experiment' }
QuasarDemoComponentApp >> vueSetupReturnDemoExperiment2On: aJSStream html: html [
	| js |

	js := (html jQuery getJson
			json: [ :json | self json2: json html: html ];
			onSuccess: (html javascript << (JSStream new
				nextPutAll: 'experiment2.value = ';
				nextPutAll: 'arguments[0]';
				nextPutAll: '';
				yourself));
			yourself).
	aJSStream
		nextPutAll: 'experiment2';
		nextPutAll: ',onClickExperiment2() {'; nextPutAll: js asJavascript; nextPutAll: '}'.
]

{ #category : #'demo - experiment' }
QuasarDemoComponentApp >> vueSetupReturnDemoExperiment3On: aJSStream html: html [
	| js |

	js := (html jQuery getJson
			json: [ :json | self json3: json html: html ];
			onSuccess: (html javascript << (JSStream new
				nextPutAll: 'experiment3.value = ';
				nextPutAll: 'arguments[0]';
				nextPutAll: '';
				yourself));
			yourself).
	aJSStream
		nextPutAll: 'experiment3';
		nextPutAll: ',onClickExperiment3() {'; nextPutAll: js asJavascript; nextPutAll: '}'.
]

{ #category : #'demo - experiment' }
QuasarDemoComponentApp >> vueSetupReturnDemoExperimentOn: aJSStream html: html [

	self vueSetupReturnDemoExperiment1On: aJSStream html: html.
	aJSStream nextPut: $,.
	self vueSetupReturnDemoExperiment2On: aJSStream html: html.
	aJSStream nextPut: $,.
	self vueSetupReturnDemoExperiment3On: aJSStream html: html
]

{ #category : #'demo - select' }
QuasarDemoComponentApp >> vueSetupReturnDemoSelectOn: aJSStream [

	aJSStream nextPutAll: '
      preferred: ref("rock"),
      accepted: ref([]),

      options: [
        {
          label: "Rock",
          value: "rock"
        },
        {
          label: "Funk",
          value: "funk"
        },
        {
          label: "Pop",
          value: "pop"
        }
      ],

      submitEmpty,
      submitResult,

      onSubmit(evt) {
        const formData = new FormData(evt.target);
        const data = [];

        for (const [name, value] of formData.entries()) {
          data.push({
            name,
            value
          });
        }

        submitResult.value = data;
        submitEmpty.value = data.length === 0;
      }'
]

{ #category : #'demo - table' }
QuasarDemoComponentApp >> vueSetupReturnDemoTableOn: aJSStream [
	
	aJSStream nextPutAll: 'columns,rows'
]
