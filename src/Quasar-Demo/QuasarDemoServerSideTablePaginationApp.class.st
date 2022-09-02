Class {
	#name : #QuasarDemoServerSideTablePaginationApp,
	#superclass : #QuasarApplication,
	#instVars : [
		'originalRows',
		'rowCountRef',
		'rowsRef',
		'onRequest',
		'onMountedCode'
	],
	#category : #'Quasar-Demo-Basic'
}

{ #category : #initialization }
QuasarDemoServerSideTablePaginationApp class >> applicationPath [

	^ 'quasar/sstable-pagination'
]

{ #category : #initialization }
QuasarDemoServerSideTablePaginationApp class >> initialize [
	"Register path with Seaside.
	self initialize.
	WAAdmin unregister: self applicationPath.
	"

	^ self mdqRegisterDeployment: self applicationPath
]

{ #category : #accessing }
QuasarDemoServerSideTablePaginationApp >> applicationTitle [

	^ 'Server-side table pagination'
]

{ #category : #'js-setup' }
QuasarDemoServerSideTablePaginationApp >> constColumnsJs [

	^ '
const columns = [
  { name: "id", label: "ID", field: "id", sortable: true },
  {
    name: "desc",
    required: true,
    label: "Dessert (100g serving)",
    align: "left",
    field: (row) => row.name,
    format: (val) => `${val}`,
    sortable: true
  },
  {
    name: "calories",
    align: "center",
    label: "Calories",
    field: "calories",
    sortable: true
  },
  { name: "fat", label: "Fat (g)", field: "fat", sortable: true },
  { name: "carbs", label: "Carbs (g)", field: "carbs", sortable: true },
  { name: "protein", label: "Protein (g)", field: "protein", sortable: true },
  { name: "sodium", label: "Sodium (mg)", field: "sodium", sortable: true },
  {
    name: "calcium",
    label: "Calcium (%)",
    field: "calcium",
    sortable: true,
    sort: (a, b) => parseInt(a, 10) - parseInt(b, 10)
  },
  {
    name: "iron",
    label: "Iron (%)",
    field: "iron",
    sortable: true,
    sort: (a, b) => parseInt(a, 10) - parseInt(b, 10)
  }
];
'
]

{ #category : #'js-not-used' }
QuasarDemoServerSideTablePaginationApp >> constOriginalRowsJs [

	^ '
const originalRows = ', "self jsOriginalRowsArray" self originalRows asJson, ';
'
]

{ #category : #'js-setup' }
QuasarDemoServerSideTablePaginationApp >> constSetupJs [

	^ '
    const rows = ref([]);
    const filter = ref("");
    const loading = ref(false);
    const pagination = ref({
      sortBy: "desc",
      descending: false,
      page: 1,
      rowsPerPage: 3,
      rowsNumber: 10
    });
'
]

{ #category : #'js-not-used' }
QuasarDemoServerSideTablePaginationApp >> fetchFromServerJs [

	^ '
    // emulate ajax call
    // SELECT * FROM ... WHERE...LIMIT...
    function fetchFromServer(startRow, count, filter, sortBy, descending) {
      const data = filter
        ? originalRows.filter((row) => row.name.includes(filter))
        : originalRows.slice();

      // handle sortBy
      if (sortBy) {
        const sortFn =
          sortBy === "desc"
            ? descending
              ? (a, b) => (a.name > b.name ? -1 : a.name < b.name ? 1 : 0)
              : (a, b) => (a.name > b.name ? 1 : a.name < b.name ? -1 : 0)
            : descending
            ? (a, b) => parseFloat(b[sortBy]) - parseFloat(a[sortBy])
            : (a, b) => parseFloat(a[sortBy]) - parseFloat(b[sortBy]);
        data.sort(sortFn);
      }

      return data.slice(startRow, startRow + count);
    }
'
]

{ #category : #'js-not-used' }
QuasarDemoServerSideTablePaginationApp >> getRowsNumberCountJs [

	^ '
    // emulate ''SELECT count(*) FROM ...WHERE...''
    function getRowsNumberCount(filter) {
      if (!filter) {
        return originalRows.length;
      }
      let count = 0;
      originalRows.forEach((treat) => {
        if (treat.name.includes(filter)) {
          ++count;
        }
      });
      return count;
    }
'
]

{ #category : #initialization }
QuasarDemoServerSideTablePaginationApp >> initialize [

	super initialize.

	self originalRows: (WAJsonParser parse: self originalRowsJson).

	self onRequest: ((QuasarCallback name: 'onRequest')
			codeBlock: self onRequestCodeBlock;
			yourself).
	self reactiveObjectsAdd: self onRequest.

	self onMountedCode: ((QuasarOnMounted name: 'onMountedCode')
			codeBlock: self onMountedCodeBlock;
			yourself).
	self onMountedObjectsAdd: self onMountedCode.

	self rowsRef: ((QuasarRefSyncServerToClient name: 'rowsRemote' value: Array new)
			"traceOn;"
			"onSuccessScript: 'console.log(rowsRemote.value)';"
			callbackBlock: [ :ajaxArg | self rowsRefUpdate: ajaxArg ];
			yourself).
	self reactiveObjectsAdd: self rowsRef.

	self rowCountRef: ((QuasarRefSyncServerToClient name: 'rowCount' value: 10)
			"traceOn;"
			"onSuccessScript: 'console.log(rowCount.value)';"
			callbackBlock: [ :ajaxArg | self rowCountRefUpdate: ajaxArg ];
			yourself).
	self reactiveObjectsAdd: self rowCountRef
]

{ #category : #accessing }
QuasarDemoServerSideTablePaginationApp >> onMountedCode [

	^ onMountedCode
]

{ #category : #accessing }
QuasarDemoServerSideTablePaginationApp >> onMountedCode: anObject [

	onMountedCode := anObject
]

{ #category : #'js-setup' }
QuasarDemoServerSideTablePaginationApp >> onMountedCodeBlock [

	^ [ :stream :ajaxFactory | stream nextPutAll: self onMountedJs ]
]

{ #category : #'js-setup' }
QuasarDemoServerSideTablePaginationApp >> onMountedJs [

	^ '
// get initial data from server (1st page)
onRequest({
	pagination: pagination.value,
	filter: null
});
'
]

{ #category : #'js-setup' }
QuasarDemoServerSideTablePaginationApp >> onMountedJsOriginal [

	^ '
    onMounted(() => {
      // get initial data from server (1st page)
      onRequest({
        pagination: pagination.value,
        filter: undefined
      });
    });
'
]

{ #category : #accessing }
QuasarDemoServerSideTablePaginationApp >> onRequest [

	^ onRequest
]

{ #category : #accessing }
QuasarDemoServerSideTablePaginationApp >> onRequest: anObject [

	onRequest := anObject
]

{ #category : #'js-setup' }
QuasarDemoServerSideTablePaginationApp >> onRequestCodeBlock [

	^ [ :stream :ajaxFactory | stream nextPutAll: self onRequestJs ]
]

{ #category : #'js-setup' }
QuasarDemoServerSideTablePaginationApp >> onRequestJs [

	^ '
async function onRequest(props) {
	const { page, rowsPerPage, sortBy, descending } = props.pagination;
	const filter = props.filter;

	loading.value = true;

	//setTimeout(() => {
	// update rowsCount with appropriate value
	//pagination.value.rowsNumber = await getRowsNumberCount(filter);
	await rowCountRefGet(filter);
	pagination.value.rowsNumber = rowCount.value;
//console.log(pagination.value);

	// get all rows if "All" (0) is selected
	const fetchCount = rowsPerPage === 0 ? pagination.value.rowsNumber : rowsPerPage;

	// calculate starting row of data
	const startRow = (page - 1) * rowsPerPage;

	// fetch data from "server"
	//const returnedData = await fetchFromServer(startRow, fetchCount, filter, sortBy, descending);
	const returnedData = await rowsRemoteRefGet({
"startRow": startRow,
"fetchCount": fetchCount,
"filter": filter,
"sortBy": sortBy,
"descending": descending
});
//console.log(returnedData);

	// clear out existing data and add new
	//rows.value.splice(0, rows.value.length, ...returnedData);

	// don''t forget to update local pagination object
	pagination.value.page = page;
	pagination.value.rowsPerPage = rowsPerPage;
	pagination.value.sortBy = sortBy;
	pagination.value.descending = descending;

	// ...and turn off loading indicator
	loading.value = false;
	//}, 500);
}
'
]

{ #category : #accessing }
QuasarDemoServerSideTablePaginationApp >> originalRows [

	^ originalRows
]

{ #category : #accessing }
QuasarDemoServerSideTablePaginationApp >> originalRows: anObject [

	originalRows := anObject
]

{ #category : #accessing }
QuasarDemoServerSideTablePaginationApp >> originalRowsFiltered: filter [
	| result |

	filter ifNil: [ ^ self originalRows ].
	filter ifEmpty: [ ^ self originalRows ].

	result := self originalRows select: [ :eachRow |
		((eachRow at: 'name' ifAbsent: [ '' ]) findString: filter) > 0 ].

	 ^ result
]

{ #category : #'js-setup' }
QuasarDemoServerSideTablePaginationApp >> originalRowsJson [

	^ '[
{ "id": 1, "name": "Frozen Yogurt", "calories": 159, "fat": 6.0, "carbs": 24, "protein": 4.0, "sodium": 87, "calcium": "14%", "iron": "1%" },
{ "id": 2, "name": "Ice cream sandwich", "calories": 237, "fat": 9.0, "carbs": 37, "protein": 4.3, "sodium": 129, "calcium": "8%", "iron": "1%" },
{ "id": 3, "name": "Eclair", "calories": 262, "fat": 16.0, "carbs": 23, "protein": 6.0, "sodium": 337, "calcium": "6%", "iron": "7%" },
{ "id": 4, "name": "Cupcake", "calories": 305, "fat": 3.7, "carbs": 67, "protein": 4.3, "sodium": 413, "calcium": "3%", "iron": "8%" },
{ "id": 5, "name": "Gingerbread", "calories": 356, "fat": 16.0, "carbs": 49, "protein": 3.9, "sodium": 327, "calcium": "7%", "iron": "16%" },
{ "id": 6, "name": "Jelly bean", "calories": 375, "fat": 0.0, "carbs": 94, "protein": 0.0, "sodium": 50, "calcium": "0%", "iron": "0%" },
{ "id": 7, "name": "Lollipop", "calories": 392, "fat": 0.2, "carbs": 98, "protein": 0, "sodium": 38, "calcium": "0%", "iron": "2%" },
{ "id": 8, "name": "Honeycomb", "calories": 408, "fat": 3.2, "carbs": 87, "protein": 6.5, "sodium": 562, "calcium": "0%", "iron": "45%" },
{ "id": 9, "name": "Donut", "calories": 452, "fat": 25.0, "carbs": 51, "protein": 4.9, "sodium": 326, "calcium": "2%", "iron": "22%" },
{ "id": 10, "name": "KitKat", "calories": 518, "fat": 26.0, "carbs": 65, "protein": 7, "sodium": 54, "calcium": "12%", "iron": "6%" },
{ "id": 11, "name": "Frozen Yogurt-1", "calories": 159, "fat": 6.0, "carbs": 24, "protein": 4.0, "sodium": 87, "calcium": "14%", "iron": "1%" },
{ "id": 12, "name": "Ice cream sandwich-1", "calories": 237, "fat": 9.0, "carbs": 37, "protein": 4.3, "sodium": 129, "calcium": "8%", "iron": "1%" },
{ "id": 13, "name": "Eclair-1", "calories": 262, "fat": 16.0, "carbs": 23, "protein": 6.0, "sodium": 337, "calcium": "6%", "iron": "7%" },
{ "id": 14, "name": "Cupcake-1", "calories": 305, "fat": 3.7, "carbs": 67, "protein": 4.3, "sodium": 413, "calcium": "3%", "iron": "8%" },
{ "id": 15, "name": "Gingerbread-1", "calories": 356, "fat": 16.0, "carbs": 49, "protein": 3.9, "sodium": 327, "calcium": "7%", "iron": "16%" },
{ "id": 16, "name": "Jelly bean-1", "calories": 375, "fat": 0.0, "carbs": 94, "protein": 0.0, "sodium": 50, "calcium": "0%", "iron": "0%" },
{ "id": 17, "name": "Lollipop-1", "calories": 392, "fat": 0.2, "carbs": 98, "protein": 0, "sodium": 38, "calcium": "0%", "iron": "2%" },
{ "id": 18, "name": "Honeycomb-1", "calories": 408, "fat": 3.2, "carbs": 87, "protein": 6.5, "sodium": 562, "calcium": "0%", "iron": "45%" },
{ "id": 19, "name": "Donut-1", "calories": 452, "fat": 25.0, "carbs": 51, "protein": 4.9, "sodium": 326, "calcium": "2%", "iron": "22%" },
{ "id": 20, "name": "KitKat-1", "calories": 518, "fat": 26.0, "carbs": 65, "protein": 7, "sodium": 54, "calcium": "12%", "iron": "6%" },
{ "id": 21, "name": "Frozen Yogurt-2", "calories": 159, "fat": 6.0, "carbs": 24, "protein": 4.0, "sodium": 87, "calcium": "14%", "iron": "1%" },
{ "id": 22, "name": "Ice cream sandwich-2", "calories": 237, "fat": 9.0, "carbs": 37, "protein": 4.3, "sodium": 129, "calcium": "8%", "iron": "1%" },
{ "id": 23, "name": "Eclair-2", "calories": 262, "fat": 16.0, "carbs": 23, "protein": 6.0, "sodium": 337, "calcium": "6%", "iron": "7%" },
{ "id": 24, "name": "Cupcake-2", "calories": 305, "fat": 3.7, "carbs": 67, "protein": 4.3, "sodium": 413, "calcium": "3%", "iron": "8%" },
{ "id": 25, "name": "Gingerbread-2", "calories": 356, "fat": 16.0, "carbs": 49, "protein": 3.9, "sodium": 327, "calcium": "7%", "iron": "16%" },
{ "id": 26, "name": "Jelly bean-2", "calories": 375, "fat": 0.0, "carbs": 94, "protein": 0.0, "sodium": 50, "calcium": "0%", "iron": "0%" },
{ "id": 27, "name": "Lollipop-2", "calories": 392, "fat": 0.2, "carbs": 98, "protein": 0, "sodium": 38, "calcium": "0%", "iron": "2%" },
{ "id": 28, "name": "Honeycomb-2", "calories": 408, "fat": 3.2, "carbs": 87, "protein": 6.5, "sodium": 562, "calcium": "0%", "iron": "45%" },
{ "id": 29, "name": "Donut-2", "calories": 452, "fat": 25.0, "carbs": 51, "protein": 4.9, "sodium": 326, "calcium": "2%", "iron": "22%" },
{ "id": 30, "name": "KitKat-2", "calories": 518, "fat": 26.0, "carbs": 65, "protein": 7, "sodium": 54, "calcium": "12%", "iron": "6%" },
{ "id": 31, "name": "Frozen Yogurt-3", "calories": 159, "fat": 6.0, "carbs": 24, "protein": 4.0, "sodium": 87, "calcium": "14%", "iron": "1%" },
{ "id": 32, "name": "Ice cream sandwich-3", "calories": 237, "fat": 9.0, "carbs": 37, "protein": 4.3, "sodium": 129, "calcium": "8%", "iron": "1%" },
{ "id": 33, "name": "Eclair-3", "calories": 262, "fat": 16.0, "carbs": 23, "protein": 6.0, "sodium": 337, "calcium": "6%", "iron": "7%" },
{ "id": 34, "name": "Cupcake-3", "calories": 305, "fat": 3.7, "carbs": 67, "protein": 4.3, "sodium": 413, "calcium": "3%", "iron": "8%" },
{ "id": 35, "name": "Gingerbread-3", "calories": 356, "fat": 16.0, "carbs": 49, "protein": 3.9, "sodium": 327, "calcium": "7%", "iron": "16%" },
{ "id": 36, "name": "Jelly bean-3", "calories": 375, "fat": 0.0, "carbs": 94, "protein": 0.0, "sodium": 50, "calcium": "0%", "iron": "0%" },
{ "id": 37, "name": "Lollipop-3", "calories": 392, "fat": 0.2, "carbs": 98, "protein": 0, "sodium": 38, "calcium": "0%", "iron": "2%" },
{ "id": 38, "name": "Honeycomb-3", "calories": 408, "fat": 3.2, "carbs": 87, "protein": 6.5, "sodium": 562, "calcium": "0%", "iron": "45%" },
{ "id": 39, "name": "Donut-3", "calories": 452, "fat": 25.0, "carbs": 51, "protein": 4.9, "sodium": 326, "calcium": "2%", "iron": "22%" },
{ "id": 40, "name": "KitKat-3", "calories": 518, "fat": 26.0, "carbs": 65, "protein": 7, "sodium": 54, "calcium": "12%", "iron": "6%" }
]'
]

{ #category : #'rendering - quasar hooks' }
QuasarDemoServerSideTablePaginationApp >> quasarOnLoadOn: aJSStream with: anAjaxFactory [

	aJSStream nextPutAll: self constColumnsJs.
	"aJSStream nextPutAll: self constOriginalRowsJs."

	super quasarOnLoadOn: aJSStream with: anAjaxFactory
]

{ #category : #'rendering - quasar hooks' }
QuasarDemoServerSideTablePaginationApp >> quasarSetupContentOn: aJSStream with: html [

	aJSStream nextPutAll: self constSetupJs.
	"aJSStream nextPutAll: self fetchFromServerJs.
	aJSStream nextPutAll: self getRowsNumberCountAjaxJs.
	aJSStream nextPutAll: self onRequestJs."
	"aJSStream nextPutAll: self onMountedJsOriginal."
]

{ #category : #'rendering - quasar hooks' }
QuasarDemoServerSideTablePaginationApp >> quasarSetupReturnContentOn: aJSStream with: anAjaxFactory [

	aJSStream nextPutAll: '
      filter,
      loading,
      pagination,
      columns,
      rows
'
]

{ #category : #rendering }
QuasarDemoServerSideTablePaginationApp >> renderAppOn: html [

	html qLayout view: 'hHh lpR fFf'; with: [
		html qHeader elevated; heightHint: 98; class: 'bg-primary text-white'; with: [
			html qToolbar with: [
				html qToolbarTitle with: [
					html text: 'Server-side table pagination' ] ] ].
		html qPageContainer with: [
			self renderTableExampleOn: html ] ]
]

{ #category : #rendering }
QuasarDemoServerSideTablePaginationApp >> renderLayoutOn: html [

	html qApp id: self appId; with: [
		self renderAppOn: html ]
]

{ #category : #rendering }
QuasarDemoServerSideTablePaginationApp >> renderTableExampleOn: html [
	"From: https://quasar.dev/vue-components/table#example--synchronizing-with-server"

	"html qBtn label: 'Row Count'; vOnClick: self rowCountRef functionName, '(1)'.
	html qBtn label: 'Rows'; vOnClick: self rowsRef functionName, '({sortBy: ""desc"", rowsNumber: 3, descending: false, rowsPerPage: 0, page: 1})'."

	html div class: 'q-pa-md'; with: [
		html qTable
			title: 'Treats';
			vBind: 'rows' with: 'rowsRemote';
			vBind: 'columns' with: 'columns';
			rowKey: 'id';
			vModel: 'pagination' colon: 'pagination';
			vBind: 'loading' with: 'loading';
			vBind: 'filter' with: 'filter';
			vOn: 'request' with: 'onRequest';
			binaryStateSort;
			with: [
				html qTemplate vSlot: 'top-right'; with: [
					html qInput
						borderless; dense; debounce: '300'; vModel: 'filter'; placeholder: 'Search';
						with: [
							html qTemplate vSlot: 'append'; with: [
								html qIcon name: 'search' ] ] ] ] ]
]

{ #category : #accessing }
QuasarDemoServerSideTablePaginationApp >> rowCountRef [

	^ rowCountRef
]

{ #category : #accessing }
QuasarDemoServerSideTablePaginationApp >> rowCountRef: anObject [

	rowCountRef := anObject
]

{ #category : #accessing }
QuasarDemoServerSideTablePaginationApp >> rowCountRefUpdate: filter [
	| filteredRows |

	filteredRows := self originalRowsFiltered: filter.
	self rowCountRef refValue: filteredRows size
]

{ #category : #accessing }
QuasarDemoServerSideTablePaginationApp >> rowsRef [

	^ rowsRef
]

{ #category : #accessing }
QuasarDemoServerSideTablePaginationApp >> rowsRef: anObject [

	rowsRef := anObject
]

{ #category : #accessing }
QuasarDemoServerSideTablePaginationApp >> rowsRefUpdate: props [
	| startRow fetchCount filter sortBy descending filteredRows slice sortedRows sortBlock fieldBlock |

"Transcript crShow: props printString."
	startRow := [ (props at: 'startRow' ifAbsent: [ '0' ]) asInteger ] onErrorDo: [ 0 ].
	fetchCount := [ (props at: 'fetchCount' ifAbsent: [ '3' ]) asInteger ] onErrorDo: [ 3 ].
	filter := props at: 'filter' ifAbsent: [ nil ].
	sortBy := props at: 'sortBy' ifAbsent: [ 'desc' ].
	descending := props at: 'descending' ifAbsent: [ false ].

	filteredRows := self originalRowsFiltered: filter.

	sortBy = 'desc' ifTrue: [ sortBy := 'name' ].
	fieldBlock := [ :object :fieldName | object at: fieldName ifAbsent: [ '' ] ].
	sortBlock := descending
		ifTrue: [ [ :a :b | (fieldBlock value: a value: sortBy) < (fieldBlock value: b value: sortBy) ] ]
		ifFalse: [ [ :a :b | (fieldBlock value: a value: sortBy) > (fieldBlock value: b value: sortBy) ] ].
	sortedRows := (SortedCollection sortBlock: sortBlock) addAll: filteredRows; yourself.

	"Adjust from 0-based to 1-based indexing"
	startRow := startRow + 1.
	slice := sortedRows copyFrom: startRow to: ((startRow + fetchCount - 1) min: filteredRows size).
"Transcript crShow: 'slice size: ', slice size printString."
"Transcript crShow: 'slice ', slice printString."

	self rowsRef refValue: slice
]
