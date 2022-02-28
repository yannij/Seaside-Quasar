Class {
	#name : #QuasarDemoScaffoldApp,
	#superclass : #QuasarApplication,
	#category : #'Quasar-Demo-Basic'
}

{ #category : #initialization }
QuasarDemoScaffoldApp class >> applicationPath [

	^ 'quasar/scaffold'
]

{ #category : #initialization }
QuasarDemoScaffoldApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : #accessing }
QuasarDemoScaffoldApp >> applicationTitle [

	^ 'Scaffold'
]

{ #category : #'rendering - quasar' }
QuasarDemoScaffoldApp >> quasarOnLoad1On: aJSStream with: html [

	aJSStream nextPutAll: '
const { useQuasar } = Quasar;
const app = Vue.createApp({
  setup() {
    const $q = useQuasar();
    const rows = [
      {
        id: "user1",
        username: "User1",
        clients: [
          { id: 11, name: "Client-11" },
          { id: 12, name: "Client-12" },
          { id: 13, name: "Client-13" }
        ]
      },
      {
        id: "user2",
        username: "User2",
        clients: [
          { id: 21, name: "Client-21" }
        ]
      },
      {
        id: "user3",
        username: "User3",
        clients: []
      }
    ];
    const columns = [
      {
        name: "username",
        label: "Username",
        align: "left",
        field: (row) => row.username,
        format: (val) => `${val}`,
        sortable: true
      },
      {
        name: "clients",
        label: "Clients",
        align: "left",
        field: (row) => row.clients,
        sortable: false
      }
    ];

    return { rows, columns, navTo(clientId) {console.log(clientId)} };
  }
});
app.use(Quasar, { config: {} });
app.mount("#q-app");'
]

{ #category : #'rendering - quasar' }
QuasarDemoScaffoldApp >> quasarOnLoadOn: aJSStream with: html [

	aJSStream nextPutAll: '
const { useQuasar } = Quasar;
const app = Vue.createApp({
  setup() {
    const $q = useQuasar();
    const rows = [
      {
        id: "user1",
        username: "User1",
        clients: [
          { id: 11, name: "Client-11" },
          { id: 12, name: "Client-12" },
          { id: 13, name: "Client-13" }
        ]
      },
      {
        id: "user2",
        username: "User2",
        clients: [
          { id: 21, name: "Client-21" }
        ]
      },
      {
        id: "user3",
        username: "User3",
        clients: []
      }
    ];
    const columns = [
      {
        name: "username",
        label: "Username",
        align: "left",
        field: function(row){return row.username}
      },
      {
        name: "clients",
        label: "Clients",
        align: "left",
        field: row => row.clients
      }
    ];

    return { rows, columns, navTo(clientId) {console.log(clientId)} };
  }
});
app.use(Quasar, { config: {} });
app.mount("#q-app");'
]

{ #category : #rendering }
QuasarDemoScaffoldApp >> renderApp1On: html [

	html html: '<div id="q-app">
  <div class="q-ma-md">
    <q-table title="Users" :rows="rows" :columns="columns">
      <template v-slot:body-cell-clients="props">
        <q-td :props="props" class="q-gutter-sm">
          <q-btn v-for="client in props.value" :key="client.id" size="sm" :label="client.name" @click="navTo(client.id)"></q-btn>
        </q-td>
      </template>
    </q-table>
  </div>
</div>'
]

{ #category : #rendering }
QuasarDemoScaffoldApp >> renderAppOn: html [

	html html: '<div id="q-app">
  <div class="q-ma-md">
    <q-table title="Users" :rows="rows" :columns="columns">
      <template v-slot:body-cell-clients="props">
        <q-td :props="props" class="q-gutter-sm">
          <q-btn v-for="client in props.value" :key="client.id" size="sm" :label="client.name" @click="navTo(client.id)"></q-btn>
        </q-td>
      </template>
    </q-table>
  </div>
</div>'
]

{ #category : #rendering }
QuasarDemoScaffoldApp >> renderLayoutOn: html [

	html qApp id: self appId; with: [
		self renderAppOn: html ]
]

{ #category : #rendering }
QuasarDemoScaffoldApp >> xrenderAppOn: html [

	html qLayout view: 'hHh lpR fFf'; with: [
		html qHeader elevated; heightHint: 98; class: 'bg-primary text-white'; with: [
			html qToolbar with: [
				html qToolbarTitle with: [
					html text: 'Scaffold' ] ] ].
		html qPageContainer with: [
			html span with: 'A place to try adhoc code' ] ]
]
