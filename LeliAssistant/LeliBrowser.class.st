Class {
	#name : #LeliBrowser,
	#superclass : #ComposablePresenter,
	#instVars : [
		'suggestionList',
		'previewText',
		'okButton',
		'cancelButton',
		'previewSourceCodeText',
		'previewTextLabel',
		'previewSourceCodeTextLabel',
		'orderByCodeLinesAsc',
		'orderByCodeLinesDesc'
	],
	#category : #'LeliAssistant-UI'
}

{ #category : #specs }
LeliBrowser class >> defaultSpec [
	<spec>
	^ SpecColumnLayout composed
		newRow: [ :row | 
			row
				add: #orderByCodeLinesAsc;
				add: #orderByCodeLinesDesc ]
			origin: 0 @ 0
			corner: 1 @ 0.07;
		newRow: [ :row | row add: #suggestionList ] origin: 0 @ 0.07 corner: 1 @ 0.4;
		addSplitter;
		newRow: [ :row | 
			row
				add: #previewSourceCodeTextLabel;
				add: #previewTextLabel ]
			origin: 0 @ 0.4
			corner: 1 @ 0.45;
		addSplitter;
		newRow: [ :row | 
			row
				add: #previewSourceCodeText;
				addSplitter;
				add: #previewText ]
			origin: 0 @ 0.45
			corner: 1 @ 1;
		addSplitter;
		yourself
]

{ #category : #specs }
LeliBrowser class >> on: suggestions [
	| inst |
	inst := self new.
	inst suggestions: suggestions.
	^ inst.
]

{ #category : #specs }
LeliBrowser class >> title [
	^ 'TOAD: auto-refactorings alternatives'
]

{ #category : #api }
LeliBrowser >> extent [
	^ 1000 @ 800
]

{ #category : #accessing }
LeliBrowser >> initializePresenter [

	suggestionList whenSelectedItemChanged: [  ]
]

{ #category : #accessing }
LeliBrowser >> initializeWidgets [
	orderByCodeLinesAsc := self instantiate: ButtonPresenter.
	orderByCodeLinesDesc := self instantiate: ButtonPresenter.
	suggestionList := self instantiate: IconListPresenter.
	previewText := self instantiate: TextPresenter.
	previewSourceCodeText := self instantiate: TextPresenter.
	previewSourceCodeTextLabel := self newLabel.
	previewTextLabel := self newLabel.
	previewSourceCodeTextLabel label: 'Modified method'.
	previewTextLabel label: 'Extracted method'.
	suggestionList icons: [ :a | self iconNamed: #smallLanguage ].
	orderByCodeLinesAsc
		label: 'Order by code lines asc';
		icon: (self iconNamed: #glamorousUp).
	orderByCodeLinesDesc
		label: 'Order by code lines desc';
		icon: (self iconNamed: #glamorousDown).
]

{ #category : #accessing }
LeliBrowser >> orderByCodeLinesAsc [
	^ orderByCodeLinesAsc
]

{ #category : #accessing }
LeliBrowser >> orderByCodeLinesDesc [
	^ orderByCodeLinesDesc
]

{ #category : #accessing }
LeliBrowser >> previewSourceCodeText [
	^ previewSourceCodeText
]

{ #category : #accessing }
LeliBrowser >> previewSourceCodeText: anObject [
	previewSourceCodeText := anObject
]

{ #category : #accessing }
LeliBrowser >> previewSourceCodeTextLabel [
	^ previewSourceCodeTextLabel
]

{ #category : #accessing }
LeliBrowser >> previewText [
	^ previewText
]

{ #category : #accessing }
LeliBrowser >> previewText: anObject [
	previewText := anObject
]

{ #category : #accessing }
LeliBrowser >> previewTextLabel [
	^ previewTextLabel
]

{ #category : #accessing }
LeliBrowser >> suggestionList [
	^ suggestionList
]

{ #category : #accessing }
LeliBrowser >> suggestionList: anObject [
	suggestionList := anObject
]

{ #category : #accessing }
LeliBrowser >> suggestions: aOrderedCollection [
	"juampi just do it"
	self suggestionList items: aOrderedCollection.
	
]
