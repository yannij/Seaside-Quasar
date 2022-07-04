Class {
	#name : #QuasarTime,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarTime >> bordered [

	self attributes at: 'bordered' put: true
]

{ #category : #attributes }
QuasarTime >> calendar: anObject [

	self attributes at: 'calendar' put: anObject
]

{ #category : #attributes }
QuasarTime >> color: anObject [

	self attributes at: 'color' put: anObject
]

{ #category : #attributes }
QuasarTime >> dark [

	self attributes at: 'dark' put: true
]

{ #category : #attributes }
QuasarTime >> defaultDate: anObject [

	self attributes at: 'default-date' put: anObject
]

{ #category : #attributes }
QuasarTime >> disable [

	self attributes at: 'disable' put: true
]

{ #category : #attributes }
QuasarTime >> flat [

	self attributes at: 'flat' put: true
]

{ #category : #attributes }
QuasarTime >> format24h [

	self attributes at: 'format24h' put: true
]

{ #category : #attributes }
QuasarTime >> hourOptions: anObject [

	self attributes at: 'hour-options' put: anObject
]

{ #category : #attributes }
QuasarTime >> landscape [

	self attributes at: 'landscape' put: true
]

{ #category : #attributes }
QuasarTime >> locale: anObject [

	self attributes at: 'locale' put: anObject
]

{ #category : #attributes }
QuasarTime >> mask: anObject [

	self attributes at: 'mask' put: anObject
]

{ #category : #attributes }
QuasarTime >> minuteOptions: anObject [

	self attributes at: 'minute-options' put: anObject
]

{ #category : #attributes }
QuasarTime >> name: anObject [

	self attributes at: 'name' put: anObject
]

{ #category : #attributes }
QuasarTime >> nowBtn: anObject [

	self attributes at: 'now-btn' put: anObject
]

{ #category : #attributes }
QuasarTime >> options: anObject [

	self attributes at: 'options' put: anObject
]

{ #category : #attributes }
QuasarTime >> readonly [

	self attributes at: 'readonly' put: true
]

{ #category : #attributes }
QuasarTime >> secondOptions: anObject [

	self attributes at: 'second-options' put: anObject
]

{ #category : #attributes }
QuasarTime >> square [

	self attributes at: 'square' put: true
]

{ #category : #accessing }
QuasarTime >> tag [

	^ 'q-time'
]

{ #category : #attributes }
QuasarTime >> textColor: anObject [

	self attributes at: 'text-color' put: anObject
]

{ #category : #attributes }
QuasarTime >> withSeconds [

	self attributes at: 'with-seconds' put: true
]

{ #category : #attributes }
QuasarTime >> withSeconds: anObject [

	self attributes at: 'with-seconds' put: anObject
]
