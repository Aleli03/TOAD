Class {
	#name : #LeliSourceCodeBrowser,
	#superclass : #BaseLeliBrowser,
	#instVars : [
		'previewSourceCodeOrBefore',
		'previewMethodOrAfter'
	],
	#category : #'LeliAssistant-UI'
}

{ #category : #specs }
LeliSourceCodeBrowser class >> defaultSpec [
	^ SpecLayout composed
		newRow: [ :row | 
			row
				add: #previewSourceCodeOrBefore;
				add: #previewMethodOrAfter ]
			origin: 0 @ 0
			corner: 1 @ 0.85;
		newRow: [ :row | 
			row
				add: #comboBoxLabel;
				add: #optionsComboBox ]
			origin: 0 @ 0.85
			corner: 1 @ 0.9;
		newRow: [ :row | row add: #okButton ] origin: 0 @ 0.9 corner: 1 @ 0.95;
		newRow: [ :row | row add: #cancelButton ] origin: 0 @ 0.95 corner: 1 @ 1;
		yourself
]

{ #category : #'instance creation' }
LeliSourceCodeBrowser class >> on: suggestions [
	| inst |
	inst := suggestions first browserForRefactor new.
	inst suggestions: suggestions.
	^ inst
]

{ #category : #'as yet unclassified' }
LeliSourceCodeBrowser >> getPreviewTex: item [
	^ item previewText
]

{ #category : #initialization }
LeliSourceCodeBrowser >> initializePresenter [
	super initializePresenter.
	optionsComboBox whenSelectedItemChanged: [ self textUpdate ].
	
]

{ #category : #initialization }
LeliSourceCodeBrowser >> initializeWidgets [
	super initializeWidgets.
	previewSourceCodeOrBefore := self instantiate: TextPresenter.
	previewMethodOrAfter := self instantiate: TextPresenter.
	superiorLabel label: 'New method name: '.
	
]

{ #category : #'as yet unclassified' }
LeliSourceCodeBrowser >> previewMethodOrAfter [
	^ previewMethodOrAfter
]

{ #category : #'as yet unclassified' }
LeliSourceCodeBrowser >> previewSourceCodeOrBefore [
	^ previewSourceCodeOrBefore
]

{ #category : #accessing }
LeliSourceCodeBrowser >> suggestions: aOrderedCollection [
	
]

{ #category : #'as yet unclassified' }
LeliSourceCodeBrowser >> textUpdate [
	| previewSourceCode previewMethod selectedItem both |
	selectedItem := [ optionsComboBox selectedItem ]
		on: Error
		do: [ optionsComboBox listItems first ].
	both := self getPreviewTex: selectedItem.
	previewSourceCode := both first.
	previewMethod := both second.
	previewSourceCodeOrBefore text: previewSourceCode.
	previewMethodOrAfter text: previewMethod
]
