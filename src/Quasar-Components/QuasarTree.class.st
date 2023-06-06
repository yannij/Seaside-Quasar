Class {
	#name : #QuasarTree,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarTree >> accordion [
	
	self attributes at: 'no-transition' put: true
]

{ #category : #attributes }
QuasarTree >> childrenKey: anObject [
	
	self attributes at: 'children-key' put: anObject
]

{ #category : #attributes }
QuasarTree >> color: anObject [
	
	self attributes at: 'color' put: anObject
]

{ #category : #attributes }
QuasarTree >> controlColor: anObject [
	
	self attributes at: 'control-color' put: anObject
]

{ #category : #attributes }
QuasarTree >> dark [
	
	self attributes at: 'dark' put: true
]

{ #category : #attributes }
QuasarTree >> defaultExpandAll [
	
	self attributes at: 'default-expand-all' put: true
]

{ #category : #attributes }
QuasarTree >> dense [
	
	self attributes at: 'dense' put: true
]

{ #category : #attributes }
QuasarTree >> duration: anObject [
	
	self attributes at: 'duration' put: anObject
]

{ #category : #attributes }
QuasarTree >> expanded: anObject [
	
	self attributes at: 'expanded' put: anObject
]

{ #category : #attributes }
QuasarTree >> filter: anObject [
	
	self attributes at: 'filter' put: anObject
]

{ #category : #attributes }
QuasarTree >> icon: anObject [
	
	self attributes at: 'icon' put: anObject
]

{ #category : #attributes }
QuasarTree >> labelKey: anObject [
	
	self attributes at: 'label-key' put: anObject
]

{ #category : #attributes }
QuasarTree >> noConnectors: anObject [
	
	self attributes at: 'no-connectors' put: anObject
]

{ #category : #attributes }
QuasarTree >> noNodesLabel: anObject [
	
	self attributes at: 'no-nodes-label' put: anObject
]

{ #category : #attributes }
QuasarTree >> noResultsLabel: anObject [
	
	self attributes at: 'no-results-label' put: anObject
]

{ #category : #attributes }
QuasarTree >> noSelectionUnset [
	
	self attributes at: 'no-selection-unset' put: true
]

{ #category : #attributes }
QuasarTree >> noTransition [
	
	self attributes at: 'no-transition' put: true
]

{ #category : #attributes }
QuasarTree >> nodeKey: anObject [
	
	self attributes at: 'node-key' put: anObject
]

{ #category : #attributes }
QuasarTree >> nodes: anObject [
	
	self attributes at: 'nodes' put: anObject
]

{ #category : #attributes }
QuasarTree >> selected: anObject [
	
	self attributes at: 'selected' put: anObject
]

{ #category : #attributes }
QuasarTree >> selectedColor: anObject [
	
	self attributes at: 'selected-color' put: anObject
]

{ #category : #accessing }
QuasarTree >> tag [

	^ 'q-tree'
]

{ #category : #attributes }
QuasarTree >> textColor: anObject [
	
	self attributes at: 'text-color' put: anObject
]

{ #category : #attributes }
QuasarTree >> tickStrategy: anObject [
	
	self attributes at: 'tick-strategy' put: anObject
]

{ #category : #attributes }
QuasarTree >> ticked: anObject [
	
	self attributes at: 'ticked' put: anObject
]
