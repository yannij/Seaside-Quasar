Class {
	#name : #MDQFormDecoration,
	#superclass : #MAFormDecoration,
	#category : #'Quasar-Magritte'
}

{ #category : #rendering }
MDQFormDecoration >> renderButtonsOn: html [
	| showDisabled denseFlag |

	denseFlag := self decoratedComponent mdqApplicationGet viewStyleDense.
	showDisabled := "self decoratedComponent hasPendingChanges" false.

	html div class: 'row'; class: 'justify-between'; with: [
		html span class: 'text-h6'; class: 'col-8'; with: self decoratedComponent model mdPrimaryString.
		self decoratedComponent isReadonly ifFalse: [
			html span class: 'text-right'; class: 'col-4'; with: [
				html qBtn
					denseIf: denseFlag;
					flat; round; type: 'submit';
				"onClick: (html jQuery post serializeForm);
				onClick: ((html jQuery ajax)
					callback: [ self execute: #save ];
					onComplete: html javascript refresh);"
					icon: 'done'.
				html qBtn
					denseIf: denseFlag;
					flat; round; type: 'reset';
				"onClick: ((html jQuery ajax)
					callback: [ self execute: #cancel ];
					onComplete: html javascript refresh);"
					icon: 'cancel' ] ] ]
]

{ #category : #rendering }
MDQFormDecoration >> renderContentOn: html [

	html qForm
		vOnSubmit: '$event.target.submit()';
		method: 'post';
		action: (html urlForAction: [ self execute: #save ]);
		"attributeAt: 'autocomplete' put: 'off';
		multipart: self requiresMultipartForm;
		defaultAction: [ self execute: self default ];"
		with: [
			self renderButtonsOn: html.
			self renderNextOn: html ]
]
