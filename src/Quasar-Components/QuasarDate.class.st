Class {
	#name : #QuasarDate,
	#superclass : #QuasarTag,
	#category : #'Quasar-Components'
}

{ #category : #attributes }
QuasarDate >> bordered [

	self attributes at: 'bordered' put: true
]

{ #category : #attributes }
QuasarDate >> calendar: anObject [

	self attributes at: 'calendar' put: anObject
]

{ #category : #attributes }
QuasarDate >> color: anObject [

	self attributes at: 'color' put: anObject
]

{ #category : #attributes }
QuasarDate >> dark [

	self attributes at: 'dark' put: true
]

{ #category : #attributes }
QuasarDate >> defaultUYearMonth: anObject [

	self attributes at: 'default-year-month' put: anObject
]

{ #category : #attributes }
QuasarDate >> disable [

	self attributes at: 'disable' put: true
]

{ #category : #attributes }
QuasarDate >> emitImmediately [

	self attributes at: 'emit-immediately' put: true
]

{ #category : #attributes }
QuasarDate >> eventColor: anObject [

	self attributes at: 'event-color' put: anObject
]

{ #category : #attributes }
QuasarDate >> events: anObject [

	self attributes at: 'events' put: anObject
]

{ #category : #attributes }
QuasarDate >> firstDayOfWeek: anObject [

	self attributes at: 'first-day-of-week' put: anObject
]

{ #category : #attributes }
QuasarDate >> flat [

	self attributes at: 'flat' put: true
]

{ #category : #attributes }
QuasarDate >> landscape [

	self attributes at: 'landscape' put: true
]

{ #category : #attributes }
QuasarDate >> locale: anObject [

	self attributes at: 'locale' put: anObject
]

{ #category : #attributes }
QuasarDate >> mask: anObject [

	self attributes at: 'mask' put: anObject
]

{ #category : #attributes }
QuasarDate >> minimal [

	self attributes at: 'minimal' put: true
]

{ #category : #attributes }
QuasarDate >> modelValue: aBoolean [

	self vBind: 'model-value' with: aBoolean
]

{ #category : #attributes }
QuasarDate >> multiple [

	self attributes at: 'multiple' put: true
]

{ #category : #attributes }
QuasarDate >> name: anObject [

	self attributes at: 'name' put: anObject
]

{ #category : #attributes }
QuasarDate >> navigationMaxYearMonth [

	self attributes at: 'navigation-max-year-month' put: true
]

{ #category : #attributes }
QuasarDate >> navigationMinYearMonth [

	self attributes at: 'navigation-min-year-month' put: true
]

{ #category : #attributes }
QuasarDate >> noUnset [

	self attributes at: 'no-unset' put: true
]

{ #category : #attributes }
QuasarDate >> options: anObject [

	self attributes at: 'options' put: anObject
]

{ #category : #attributes }
QuasarDate >> range [

	self attributes at: 'range' put: true
]

{ #category : #attributes }
QuasarDate >> readonly [

	self attributes at: 'readonly' put: true
]

{ #category : #attributes }
QuasarDate >> square [

	self attributes at: 'square' put: true
]

{ #category : #attributes }
QuasarDate >> subtitle: anObject [

	self attributes at: 'subtitle' put: anObject
]

{ #category : #accessing }
QuasarDate >> tag [

	^ 'q-date'
]

{ #category : #attributes }
QuasarDate >> textColor: anObject [

	self attributes at: 'text-color' put: anObject
]

{ #category : #attributes }
QuasarDate >> title: anObject [

	self attributes at: 'title' put: anObject
]

{ #category : #attributes }
QuasarDate >> todayBtn [

	self attributes at: 'today-btn' put: true
]

{ #category : #attributes }
QuasarDate >> yearsInMonthView [

	self attributes at: 'years-in-month-view' put: true
]
