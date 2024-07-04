Class {
	#name : 'MDQMarkdownComponent',
	#superclass : 'MDQTextInputComponent',
	#category : 'Quasar-Magritte',
	#package : 'Quasar-Magritte'
}

{ #category : 'rendering' }
MDQMarkdownComponent >> exampleHtml [

	^ '
<div class="q-py-sm fit">
      <q-splitter v-model="markdown1Splitter">
        <template #separator>
          <q-avatar color="primary" text-color="white" size="28px" icon="adjust"></q-avatar>
        </template>

        <template #before>
          <div class="q-pr-md">
            <textarea v-model="markdown1" :rows="20" class="fit q-pa-sm"></textarea>
          </div>
        </template>

        <template #after>
          <div class="q-pl-md" style="max-height: 467px;">
            <q-markdown v-model:src="markdown1" class="fit bordered q-pr-xs">
            </q-markdown>
          </div>
        </template>
      </q-splitter>
</div>
'
]

{ #category : 'rendering' }
MDQMarkdownComponent >> renderFieldOn: html readonly: aReadonlyFlag [
	| inputTag inputValue app flag modelName splitterName |

	app := self mdqApplicationGet.
	modelName := self magritteDescription mdqLabelAsSafeIdentifier.
	inputValue := self perform: self inputAspect.
	app vueRefsSet: modelName -> inputValue.

	flag := aReadonlyFlag or: [ self isReadOnlyForced ].
	flag ifTrue: [
		^ self renderMarkdown: modelName on: html ].

	splitterName := modelName, 'Splitter'.
	app vueRefsSet: splitterName -> 50.

	inputTag := html qInput.
	self setFieldStyleOf: inputTag.
	inputTag type: 'textarea'.
	inputTag label: self magritteDescription label.
	inputTag
		inputStyle: 'display: none';
		vModel: modelName;
		on: self inputAspect of: self;
		with: [
			html qTemplate vSlot: 'default'; with: [
				"self renderMarkdown: modelName on: html"
				self renderMarkdown: modelName splitter: splitterName readonly: flag on: html ] ]
]

{ #category : 'rendering' }
MDQMarkdownComponent >> renderMarkdown: modelName on: html [

	html div class: 'q-py-sm fit'; with: [
		html div class: 'q-pl-md'; "style: 'max-height: 467px;';" with: [
			html qMarkdown
				noHeadingAnchorLinks;
				vModel: modelName colon: 'src';
				class: 'fit bordered q-pr-xs' ] ]
]

{ #category : 'rendering' }
MDQMarkdownComponent >> renderMarkdown: modelName splitter: splitterName readonly: flag on: html [

	html div class: 'q-py-sm fit'; with: [
		html qSplitter vModel: splitterName; with: [
			html qTemplate vSlot: 'separator'; with: [
				html qAvatar color: 'primary'; textColor: 'white'; size: '28px'; icon: 'adjust' ].
			html qTemplate vSlot: 'before'; with: [
				html div class: 'q-pr-md'; with: [ | textareaTag |
					textareaTag := html textArea.
					textareaTag attributes removeKey: 'rows' ifAbsent: [  ].
					textareaTag attributes removeKey: 'coloumns' ifAbsent: [  ].
					textareaTag
						readonly: flag;
						vModel: modelName;
						vBind: 'rows' with: 20;
						class: 'fit q-pa-sm' ] ].
			html qTemplate vSlot: 'after'; with: [
				html div class: 'q-pl-md'; style: 'max-height: 467px;'; with: [
					html qMarkdown
						noHeadingAnchorLinks;
						vModel: modelName colon: 'src';
						class: 'fit bordered q-pr-xs' ] ] ] ]
]
