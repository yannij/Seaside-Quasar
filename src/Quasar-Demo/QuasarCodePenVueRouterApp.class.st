"
I am a demo application for CodePen example of Vue Router with Standalone/UMD Quasar.
"
Class {
	#name : 'QuasarCodePenVueRouterApp',
	#superclass : 'QuasarApplication',
	#category : 'Quasar-Demo-Basic',
	#package : 'Quasar-Demo',
	#tag : 'Basic'
}

{ #category : 'initialization' }
QuasarCodePenVueRouterApp class >> applicationPath [

	^ 'quasar/vue-router-codepen'
]

{ #category : 'accessing' }
QuasarCodePenVueRouterApp class >> categoryName [

	^ #misc
]

{ #category : 'initialization' }
QuasarCodePenVueRouterApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : 'accessing' }
QuasarCodePenVueRouterApp >> applicationTitle [

	^ 'Vue Route CodePen'
]

{ #category : 'rendering' }
QuasarCodePenVueRouterApp >> penJs [
	"From: https://codepen.io/metalsadman/pen/MWrRgqQ"

	^ 'const Home = {
  template: ''#home'',
  data: function () {
    return {
      version: Quasar.version };

  },
  methods: {
    linkClick(e, go) {
      e.navigate = false; // we choose when we navigate

      console.log(''triggering navigation in 2s'');
      setTimeout(() => {
        console.log(''navigating as promised 2s ago'');
        go();
      }, 2000);
    },
    notify() {
      Quasar.Notify.create({
        message: ''Running on Quasar v'' + Quasar.version,
        timeout: 1000,
        color: ''primary'' });

    } } };




const Component1 = {
  template: ''#component1'' };


const Component2 = {
  template: ''#component2'' };


const routes = [
{ path: '''', component: Home },
{ path: ''/start/pick-quasar-flavour1'', component: Component1 },
{ path: ''/start/pick-quasar-flavour2'', component: Component2 }];

const { createRouter, createWebHistory, createWebHashHistory } = VueRouter;
const router = createRouter({
  history: createWebHashHistory(),
  routes });


const app = Vue.createApp({});

app.use(router);
app.use(Quasar, { config: {} });
app.mount(''#q-app'');'
]

{ #category : 'rendering' }
QuasarCodePenVueRouterApp >> renderContentOn: html [
	| jsStream |

	self renderLayoutOn: html.

	html script "async;" url: self vueJsUrl.
	html script "async;" url: self quasarJsUrl.
	html script url: 'https://unpkg.com/vue-router@4'.
	html script with: self penJs.

	"jsStream := JSStream new.
	self quasarOnLoadOn: jsStream with: html.
	html document addLoadScript: jsStream."
]

{ #category : 'rendering' }
QuasarCodePenVueRouterApp >> renderLayoutOn: html [

	self renderRouterViewOn: html.

	"html qApp id: self appId; with: [
		self renderExampleOn: html ]"
]

{ #category : 'rendering' }
QuasarCodePenVueRouterApp >> renderRouterViewOn: html [

	html html: '<script type="text/x-template" id="home">
    <div>
        <h2>Home</h2>
        
                Quasar {{version}}
        <div>
            <q-btn label="Notify" color="primary" @click="notify"></q-btn>
            <q-btn to="/start/pick-quasar-flavour1" label="To Docs index" glossy color="purple" ></q-btn>
            
            <q-btn to="/start/pick-quasar-flavour2" label="To Docs index" glossy color="purple" ></q-btn>
            
        </div>        
    </div>
</script>

<script type="text/x-template" id="component1">
    <div>
        <h2>Component 1</h2>
        <ul>
            <q-btn to="/">Home</q-btn>
        </ul>
    </div>
</script>

<script type="text/x-template" id="component2">
    <div>
        <q-btn to="/" label="To Docs index" outline color="purple" ></q-btn>
    </div>
</script>

<div id="q-app">
    <h1>Basic Vue-Router</h1>
    <router-view></router-view>
</div>'
]
