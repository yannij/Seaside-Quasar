Class {
	#name : 'MDQMarkupTable',
	#superclass : 'MAReport',
	#category : 'Quasar-Magritte',
	#package : 'Quasar-Magritte'
}

{ #category : 'rendering' }
MDQMarkupTable >> renderContentOn: html [

	html div class: 'q-pa-md'; with: [
		html qMarkupTable id: self ajaxId; with: [
			html qTemplate vSlot: 'default'; with: [
				self renderTableOn: html ] ] ]
]
