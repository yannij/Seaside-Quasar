"
I am a demo application showing how to use the various Quasar Framework components from Seaside.
"
Class {
	#name : 'QuasarDemoComponentApp',
	#superclass : 'QuasarApplication',
	#instVars : [
		'demoName',
		'demoObjectA',
		'experiment4',
		'reactive1'
	],
	#category : 'Quasar-Demo-Basic',
	#package : 'Quasar-Demo',
	#tag : 'Basic'
}

{ #category : 'initialization' }
QuasarDemoComponentApp class >> applicationPath [

	^ 'quasar/component-demo'
]

{ #category : 'accessing' }
QuasarDemoComponentApp class >> categoryName [

	^ #quasar
]

{ #category : 'initialization' }
QuasarDemoComponentApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : 'accessing' }
QuasarDemoComponentApp >> applicationTitle [

	^ 'Components'
]

{ #category : 'accessing' }
QuasarDemoComponentApp >> demoName [

	^ demoName
]

{ #category : 'accessing' }
QuasarDemoComponentApp >> demoName: anObject [

	demoName := anObject
]

{ #category : 'accessing' }
QuasarDemoComponentApp >> demoNames [

	^ #(
	Breadcrumbs
	Btn
	BtnToggle
	Card
	ColorPicker
	DateTime
	Dialog
	Drawer
	Form
	Pagination
	Radio
	Select
	TabPanels
	Table
	Tree
	)
]

{ #category : 'demo - tree' }
QuasarDemoComponentApp >> exampleBasicGraph [

	^ NeoJSONReader fromString: '[
        {
          "label": "Satisfied customers (with avatar)",
          "avatar": "https://cdn.quasar.dev/img/boy-avatar.png",
          "children": [
            {
              "label": "Good food (with icon)",
              "icon": "restaurant_menu",
              "children": [
                { "label": "Quality ingredients" },
                { "label": "Good recipe" }
              ]
            },
            {
              "label": "Good service (disabled node with icon)",
              "icon": "room_service",
              "disabled": true,
              "children": [
                { "label": "Prompt attention" },
                { "label": "Professional waiter" }
              ]
            },
            {
              "label": "Pleasant surroundings (with icon)",
              "icon": "photo",
              "children": [
                {
                  "label": "Happy atmosphere (with image)",
                  "img": "https://cdn.quasar.dev/img/logo_calendar_128px.png"
                },
                { "label": "Good table presentation" },
                { "label": "Pleasing decor" }
              ]
            }
          ]
        }
      ]'
]

{ #category : 'demo - tree' }
QuasarDemoComponentApp >> exampleBasicName [

	^ 'treeBasic'
]

{ #category : 'demo - tree' }
QuasarDemoComponentApp >> exampleSelectionVsEtcGraph [

	^ NeoJSONReader fromString: '[
        {
          "label": "Satisfied customers",
          "children": [
            {
              "label": "Good food",
              "children": [
                { "label": "Quality ingredients" },
                { "label": "Good recipe" }
              ]
            },
            {
              "label": "Good service (disabled node)",
              "disabled": true,
              "children": [
                { "label": "Prompt attention" },
                { "label": "Professional waiter" }
              ]
            },
            {
              "label": "Pleasant surroundings",
              "children": [
                { "label": "Happy atmosphere" },
                { "label": "Good table presentation" },
                { "label": "Pleasing decor" }
              ]
            }
          ]
        }
      ]'
]

{ #category : 'demo - tree' }
QuasarDemoComponentApp >> exampleSelectionVsEtcName [

	^ 'treeSelectionVsEtcName'
]

{ #category : 'demo - form' }
QuasarDemoComponentApp >> formBasicOnResetJs [

	^ 'function formBasicOnReset () {
  formBasicName.value = null
  formBasicAge.value = null
  formBasicAccept.value = false
}'
]

{ #category : 'demo - form' }
QuasarDemoComponentApp >> formBasicOnSubmitJs [

	^ 'function formBasicOnSubmit () {
        if (formBasicAccept.value !== true) {
          $q.notify({
            color: ''red-5'',
            textColor: ''white'',
            icon: ''warning'',
            message: ''You need to accept the license and terms first''
          })
        }
        else {
          $q.notify({
            color: ''green-4'',
            textColor: ''white'',
            icon: ''cloud_done'',
            message: ''Submitted''
          })
        }
      }'
]

{ #category : 'rendering' }
QuasarDemoComponentApp >> quasarSetupContentOn: aJSStream with: html [

	self vueSetupDemoDrawerOn: aJSStream.
	self vueSetupDemoTableOn: aJSStream.
	self vueSetupDemoSelectOn: aJSStream
]

{ #category : 'rendering - quasar hooks' }
QuasarDemoComponentApp >> quasarSetupReturnCustomList: aList with: anAjaxFactory [

	self vueSetupReturnDemoSelectOn: aList.
	self vueSetupReturnDemoTableOn: aList.
	self vueSetupReturnDemoDrawerOn: aList.
	
	aList add: '
currentPagination: ref(3),
dialog: ref(false),
cancelEnabled: ref(false),
date: ref("2019-02-01 12:44"),
color: ref("#FF00FF"),
tab: ref(''mails''),
shape: ref(''line'')'
]

{ #category : 'demo - breadcrumbs' }
QuasarDemoComponentApp >> renderDemoBreadcrumbsOn: html [

	html qQuasarBreadcrumbs with: [ 
		html qQuasarBreadcrumbsEl label: 'Home'.
		html qQuasarBreadcrumbsEl label: 'Components'.
		html qQuasarBreadcrumbsEl label: 'Breadcrumbs' ].

	html qQuasarBreadcrumbs with: [ 
		html qQuasarBreadcrumbsEl label: 'Home'; icon: 'home'.
		html qQuasarBreadcrumbsEl label: 'Components'; icon: 'widgets'.
		html qQuasarBreadcrumbsEl label: 'Breadcrumbs' ].

	html qQuasarBreadcrumbs with: [ 
		html qQuasarBreadcrumbsEl icon: 'home'.
		html qQuasarBreadcrumbsEl icon: 'widgets'.
		html qQuasarBreadcrumbsEl icon: 'navigation' ].
]

{ #category : 'demo - btn' }
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

{ #category : 'demo - btn toggle' }
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

{ #category : 'demo - card' }
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

{ #category : 'demo - color picker' }
QuasarDemoComponentApp >> renderDemoColorPickerOn: html [

	html div class: 'q-pa-md'; class: 'q-gutter-sm'; with: [
		html qInput filled; vModel: 'color'; with: [
			html qTemplate vSlot: 'append'; with: [
				html qIcon name: 'colorize'; class: 'cursor-pointer'; with: [
					html qPopupProxy cover; transitionShow: 'scale'; transitionHide: 'scale'; with: [
						html qColor vModel: 'color' ] ] ] ] ]
]

{ #category : 'demo - date time' }
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

{ #category : 'demo - dialog' }
QuasarDemoComponentApp >> renderDemoDialogOn: html [

	html div class: 'q-pa-md'; with: [
		html qBtn label: 'Open Dialog'; color: 'primary'; vOnClick: 'dialog = true'.
		html qDialog vModel: 'dialog'; persistent; with: [
			html qCard with: [
				html qCardSection class: 'row items-center'; with: [
					html qAvatar icon: 'signal_wifi_off'; color: 'primary'; textColor: 'white'.
					html span class: 'q-ml-sm'; with: 'You are currently not connected to any network.' ].
				html qCardSection class: 'row items-center'; with: [
					html qToggle vModel: 'cancelEnabled'; label: 'Cancel button enabled' ].
				html qCardActions align: 'right'; with: [
					html qBtn flat; label: 'Cancel'; color: 'primary'; vClosePopUp: 'cancelEnabled'; vBind: 'disable' with: '!cancelEnabled'.
					html qBtn flat; label: 'Turn on Wifi'; color: 'primary'; vClosePopUp ] ] ] ]
]

{ #category : 'demo - drawer' }
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

{ #category : 'demo - form' }
QuasarDemoComponentApp >> renderDemoFormBasicOn: html [

	self vueRefsSet: 'formBasicName' -> nil.
	self vueRefsSet: 'formBasicAge' -> nil.
	self vueRefsSet: 'formBasicAccept' -> nil.
	self reactiveObjectsAddIfAbsent: (
		(QuasarSetupFunction name: 'formBasicOnSubmit')
			codeBlock: [ :stream :ajaxFactory | stream nextPutAll: self formBasicOnSubmitJs ];
			yourself).
	self reactiveObjectsAddIfAbsent: (
		(QuasarSetupFunction name: 'formBasicOnReset')
			codeBlock: [ :stream :ajaxFactory | stream nextPutAll: self formBasicOnResetJs ];
			yourself).

	html div
		vIf: 'formChooser == ''basic''';
		class: 'q-pa-md';
		style: 'max-width: 400px';
		with: [
			html qForm vOnSubmit: 'formBasicOnSubmit'; vOnReset: 'formBasicOnReset'; class: 'q-gutter-md'; with: [
				html qInput
					filled;
					vModel: 'formBasicName';
					label: 'Your name *';
					hint: 'Name and surname';
					vBind: 'rules' with: '[ val => val && val.length > 0 || ''Please type something'']';
					lazyRules.
				html qInput
					filled;
					type: 'number';
					vModel: 'formBasicAge';
					label: 'Your age *';
					vBind: 'rules' with: '[
  val => val !== null && val !== '''' || ''Please type your age'',
  val => val > 0 && val < 100 || ''Please type a real age''
]';
					lazyRules.
				html qToggle
					vModel: 'formBasicAccept';
					label: 'I accept the license and terms'.
				html div with: [
					html qBtn label: 'Submit'; type: 'submit'; color: 'primary'.
					html qBtn label: 'Reset'; type: 'reset'; color: 'primary'; flat; class: 'q-ml-sm' ] ] ]
]

{ #category : 'demo - form' }
QuasarDemoComponentApp >> renderDemoFormChooserOn: html [

	html qBtnDropdown color: 'primary'; label: 'Usage Example'; with: [
		html qList with: [
			html qItem clickable; vClosePopUp; vOnClick: 'formChooser=''basic'''; with: [
				html qItemSection with: [
					html qItemLabel with: 'Basic' ] ].
			html qItem clickable; vClosePopUp; vOnClick: 'formChooser=''nativeSubmit'''; with: [
				html qItemSection with: [
					html qItemLabel with: 'Native submit' ] ] ] ]
]

{ #category : 'demo - form' }
QuasarDemoComponentApp >> renderDemoFormNativeSubmitOn: html [

	html div
		vIf: 'formChooser == ''nativeSubmit''';
		class: 'q-pa-md';
		style: 'max-width: 400px';
		with: [
			html text: 'TODO: Native submit example' ]
]

{ #category : 'demo - form' }
QuasarDemoComponentApp >> renderDemoFormOn: html [

	self vueRefsSet: 'formChooser' -> 'basic'.
	self renderDemoFormChooserOn: html.

	self renderDemoFormBasicOn: html.
	self renderDemoFormNativeSubmitOn: html
]

{ #category : 'demo - pagination' }
QuasarDemoComponentApp >> renderDemoPaginationOn: html [

	html div class: 'q-pa-md flex flex-center'; with: [
		html qPagination vModel: 'currentPagination'; vBind: 'max' with: 5 ].

	html div class: 'q-pa-md flex flex-center'; with: [
		html qPagination vModel: 'currentPagination'; vBind: 'max' with: 5; input ].

	html div class: 'q-pa-md flex flex-center'; with: [
		html qPagination
			vModel: 'currentPagination';
			color: 'black';
			vBind: 'max' with: 10;
			vBind: 'max-pages' with: 6;
			boundaryNumbers: false ].

	html div class: 'q-pa-md flex flex-center'; with: [
		html qPagination vModel: 'currentPagination'; vBind: 'max' with: 5; boundaryLinks ].

	html div class: 'q-pa-md flex flex-center'; with: [
		html qPagination vModel: 'currentPagination'; vBind: 'max' with: 5; directionLinks ].

	html div class: 'q-pa-md flex flex-center'; with: [
		html qPagination vModel: 'currentPagination'; vBind: 'max' with: 5; directionLinks; boundaryLinks ].
]

{ #category : 'demo - radio' }
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

{ #category : 'demo - select' }
QuasarDemoComponentApp >> renderDemoSelectOn: html [

	html qForm vOnSubmit: 'onSubmit'; class: 'q-gutter-md'; with: [
		html qSelect
			emitValue; mapOptions;
			name: 'preferred_genre'; label: 'Preferred genre';
			vModel: 'preferred'; options: 'options';
			color: 'primary'; filled; clearable.
		html qSelect
			emitValue; mapOptions;
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

{ #category : 'demo - tab panels' }
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

{ #category : 'demo - table' }
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

{ #category : 'demo - tree' }
QuasarDemoComponentApp >> renderDemoTreeBasicOn: html [

	self vueRefsSet: self exampleBasicName -> self exampleBasicGraph.

	html qTree
		vIf: 'treeChooser == ''basic''';
		defaultExpandAll;
		vBind: 'nodes' with: self exampleBasicName;
		nodeKey: 'label'
]

{ #category : 'demo - tree' }
QuasarDemoComponentApp >> renderDemoTreeChooserOn: html [

	html qBtnDropdown color: 'primary'; label: 'Usage Example'; with: [
		html qList with: [
			html qItem clickable; vClosePopUp; vOnClick: 'treeChooser=''basic'''; with: [
				html qItemSection with: [
					html qItemLabel with: 'Basic' ] ].
			html qItem clickable; vClosePopUp; vOnClick: 'treeChooser=''selectionVsEtc'''; with: [
				html qItemSection with: [
					html qItemLabel with: 'Selection vs ticking, expansion' ] ] ] ]
]

{ #category : 'demo - tree' }
QuasarDemoComponentApp >> renderDemoTreeOn: html [

	self vueRefsSet: 'treeChooser' -> 'basic'.
	self renderDemoTreeChooserOn: html.

	self renderDemoTreeBasicOn: html.
	self renderDemoTreeSelectionVsEtcOn: html
]

{ #category : 'demo - tree' }
QuasarDemoComponentApp >> renderDemoTreeSelectionVsEtcOn: html [

	self vueRefsSet: self exampleSelectionVsEtcName -> self exampleSelectionVsEtcGraph.
	self vueRefsSet: 'treeSelected' -> 'Good Food'.
	self vueRefsSet: 'treeTicked' -> (Array with: 'Quality ingredients' with: 'Good table presentation').
	self vueRefsSet: 'treeExpanded' ->
		(Array with: 'Satisfied customers' with: 'Good service (disabled node)' with: 'Pleasant surroundings').

	html div class: 'q-pa-md row q-col-gutter-sm'; vIf: 'treeChooser == ''selectionVsEtc'''; with: [
		html qTree
			class: 'col-12 col-sm-6';
			"defaultExpandAll;"
			vIf: 'treeChooser == ''selectionVsEtc''';
			tickStrategy: 'leaf';
			vModel: 'treeSelected' colon: 'selected';
			vModel: 'treeTicked' colon: 'ticked';
			vModel: 'treeExpanded' colon: 'expanded';
			vBind: 'nodes' with: self exampleSelectionVsEtcName;
			nodeKey: 'label'.
		html div class: 'col-12 col-sm-6 q-gutter-sm'; with: [
			html div class: 'text-h6'; with: 'Selected'.
			html div with: '{{ treeSelected }}'.
			html qSeparator.
			html div class: 'text-h6'; with: 'Ticked'.
			html div with: [
				html div
					vFor: 'tick in treeTicked';
					vBind: 'key' with: '`ticked-${tick}`';
					with: '{{ tick }}' ].
			html qSeparator.
			html div class: 'text-h6'; with: 'Expanded'.
			html div with: [
				html div
					vFor: 'expand in treeExpanded';
					vBind: 'key' with: '`expanded-${expand}`';
					with: '{{ expand }}' ] ] ]
]

{ #category : 'rendering' }
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

{ #category : 'rendering' }
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

{ #category : 'rendering' }
QuasarDemoComponentApp >> renderLeftDrawerOn: html [

	html qDrawer ref: 'leftDrawer'; showIfAbove; persistent; side: 'left';
		class: 'bg-primary'; style: 'color: white';
		with: [
			html qScrollArea class: 'fit'; with: [
				"self renderNavBrandingOn: html."
				self renderNavOn: html ] ]
]

{ #category : 'rendering' }
QuasarDemoComponentApp >> renderNavOn: html [

	html qList with: [
		self demoNames do: [ :eachItem |
			html qItem
				qTag: 'a'; href: (html urlForAction: [ self demoName: eachItem ]);
				with: [
					html qItemSection with: eachItem ] ] ]
]

{ #category : 'demo - drawer' }
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

{ #category : 'demo - select' }
QuasarDemoComponentApp >> vueSetupDemoSelectOn: aJSStream [

	aJSStream
		nextPutAll: 'const submitEmpty = ref(false);';
		nextPutAll: 'const submitResult = ref([]);'
]

{ #category : 'demo - table' }
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

{ #category : 'demo - drawer' }
QuasarDemoComponentApp >> vueSetupReturnDemoDrawerOn: aList [

	aList add: 'drawer: ref(false), menuList'
]

{ #category : 'demo - select' }
QuasarDemoComponentApp >> vueSetupReturnDemoSelectOn:  aList [

	aList add: '
      preferred: ref(1),
      accepted: ref([1,2]),

      options: [
        {
          label: "Rock",
          value: 1
        },
        {
          label: "Funk",
          value: 2
        },
        {
          label: "Pop",
          value: 3
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

{ #category : 'demo - table' }
QuasarDemoComponentApp >> vueSetupReturnDemoTableOn:  aList [

	aList add: 'columns'; add: 'rows'
]
