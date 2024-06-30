"
I am a demo application for how to use Vue Router with Standalone/UMD Quasar.
"
Class {
	#name : 'QuasarDemoVueRouterApp',
	#superclass : 'QuasarApplication',
	#category : 'Quasar-Demo-Basic',
	#package : 'Quasar-Demo',
	#tag : 'Basic'
}

{ #category : 'initialization' }
QuasarDemoVueRouterApp class >> applicationPath [

	^ 'quasar/vue-router-demo'
]

{ #category : 'accessing' }
QuasarDemoVueRouterApp class >> categoryName [

	^ #misc
]

{ #category : 'initialization' }
QuasarDemoVueRouterApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : 'rendering' }
QuasarDemoVueRouterApp >> appId [

	^ 'q-app'
]

{ #category : 'accessing' }
QuasarDemoVueRouterApp >> applicationTitle [

	^ 'Vue Route Example'
]

{ #category : 'rendering' }
QuasarDemoVueRouterApp >> exampleJs [

	^ '
const app = Vue.createApp({});

app.use(router);
app.use(Quasar, { config: {} });
app.mount(''#q-app'');'
]

{ #category : 'rendering' }
QuasarDemoVueRouterApp >> page1Js [

	^ 'const Page1 = {
  template: ''#page1'' };
'
]

{ #category : 'rendering' }
QuasarDemoVueRouterApp >> page2Js [

	^ 'const Page2 = {
  template: ''#page2'' };
'
]

{ #category : 'rendering' }
QuasarDemoVueRouterApp >> pageHomeJs [

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
'
]

{ #category : 'rendering' }
QuasarDemoVueRouterApp >> pageRouterJs [

	^ 'const routes = [
{ path: '''', component: Home },
{ path: ''/page-1'', component: Page1 },
{ path: ''/page-2'', component: Page2 }];

const { createRouter, createWebHistory, createWebHashHistory } = VueRouter;
const router = createRouter({
  history: createWebHashHistory(),
  routes });
'
]

{ #category : 'rendering' }
QuasarDemoVueRouterApp >> renderContentOn: html [
	| jsStream |

	self renderLayoutOn: html.

	html script "async;" url: self vueJsUrl.
	html script "async;" url: self quasarJsUrl.
	html script url: 'https://unpkg.com/vue-router@4'.
	html script with: self pageHomeJs, self page1Js, self page2Js, self pageRouterJs.
	html script with: self exampleJs.

	"jsStream := JSStream new.
	self quasarOnLoadOn: jsStream with: html.
	html document addLoadScript: jsStream."
]

{ #category : 'rendering' }
QuasarDemoVueRouterApp >> renderExampleOn: html [

	html qLayout view: 'hHh lpR fFf'; vCloak; with: [
		html qHeader elevated; heightHint: 98; "class: 'bg-primary text-white';" with: [
			html qToolbar with: [
				html qBtn dense; flat; round; icon: 'menu'; vOnClick: 'this.$refs.leftDrawer.toggle($event)'.
				html qToolbarTitle with: [
					html text: self applicationTitle ].
				"html qBtn dense; flat; round; icon: 'view_sidebar'; vOnClick: 'this.$refs.rightDrawer.toggle($event)'" ] ].
		self renderLeftDrawerOn: html.
		"html qDrawer ref: 'rightDrawer'; showIfAbove; side: 'right'; bordered; with: 'right drawer content'."
		html qPageContainer with: [
			html heading level3 with: 'Common Page Header'.
			html qRouterView ] ]
]

{ #category : 'rendering' }
QuasarDemoVueRouterApp >> renderLayoutOn: html [

	self renderRouterViewOn: html.

	html qApp id: self appId; with: [
		self renderExampleOn: html ]
]

{ #category : 'rendering' }
QuasarDemoVueRouterApp >> renderLeftDrawerOn: html [

	html qDrawer ref: 'leftDrawer'; showIfAbove; side: 'left'; "behavior: 'desktop';" with: [
		html qList with: [
			html qItem to: '/'; with: 'Home'.
			html qItem to: '/page-1'; with: 'Page-1'.
			html qItem to: '/page-2'; with: 'Page-2' ] ]
]

{ #category : 'rendering' }
QuasarDemoVueRouterApp >> renderRouterViewOn: html [

	html qRouterTemplate id: 'home'; vRouterTemplateType; with: [
		html div with: [
			html heading level4 with: 'Home'.
			html text: 'Quasar {{version}}'.
			html div with: [
				html qBtn label: 'Notify'; color: 'primary'; vOnClick: 'notify'.
				html qBtn to: '/page-1'; label: 'Page 1'; glossy; color: 'purple'.
				html qBtn to: '/page-2'; label: 'Page 2'; glossy; color: 'purple' ] ] ].

	html qRouterTemplate id: 'page1'; vRouterTemplateType; with: [
		html div with: [
			html heading level4 with: 'Page 1'.
			html qBtn to: '/'; with: 'Home from P1' ] ].

	html qRouterTemplate id: 'page2'; vRouterTemplateType; with: [
		html div with: [
			html heading level4 with: 'Page 2'.
			html qBtn to: '/'; label: 'Home from P2'; outline; color: 'purple' ] ]
]
