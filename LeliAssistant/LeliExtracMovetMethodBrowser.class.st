Class {
	#name : #LeliExtracMovetMethodBrowser,
	#superclass : #BaseLeliBrowser,
	#instVars : [
		'classSelectorBox',
		'movements',
		'actualHierarchy',
		'previewHierarchy'
	],
	#category : #'LeliAssistant-UI'
}

{ #category : #specs }
LeliExtracMovetMethodBrowser class >> defaultSpec [
	^ SpecLayout composed
		newRow: [ :row | 
			row
				add: #superiorLabel;
				add: #classSelectorBox ]
			origin: 0 @ 0
			corner: 1 @ 0.25;
		newRow: [ :row | 
			row
				add: #actualHierarchy;
				add: #previewHierarchy ]
			origin: 0 @ 0.25
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

{ #category : #execution }
LeliExtracMovetMethodBrowser class >> on: method [
	| aux |
	aux := self new.
	aux movements: method.
	^ aux
]

{ #category : #accessing }
LeliExtracMovetMethodBrowser >> actualHierarchy [
	^ actualHierarchy
]

{ #category : #'as yet unclassified' }
LeliExtracMovetMethodBrowser >> actualTextUpdate [
	| superClass childrenClasses |
	superClass := movements actualHierarchyCache first.
	actualHierarchy roots: {superClass}.
	childrenClasses := OrderedCollection new.
	childrenClasses add: movements selectedMethod.
	movements actualHierarchyCache second do: [ :each | childrenClasses add: each ].
	actualHierarchy
		childrenBlock: [ :it | 
			it = superClass
				ifTrue: [ childrenClasses ]
				ifFalse: [ {} ] ].
	actualHierarchy expandAll 
]

{ #category : #'as yet unclassified' }
LeliExtracMovetMethodBrowser >> addingMethodToSelectedClassInView: it [
	| toReturn |
	toReturn := {}.
	it = classSelectorBox selectedItem
		ifTrue: [ toReturn := {movements selectedMethod} ].
	^ toReturn
]

{ #category : #'as yet unclassified' }
LeliExtracMovetMethodBrowser >> addingMethodToSelectedClassesInView: it [
	| toReturn |
	toReturn := {}.
	classSelectorBox selectedItems do: [ :each |
		it = each ifTrue: [ toReturn := {movements selectedMethod} ]].
		
	^ toReturn
]

{ #category : #accessing }
LeliExtracMovetMethodBrowser >> classSelectorBox [
	^ classSelectorBox
]

{ #category : #initialization }
LeliExtracMovetMethodBrowser >> initializePresenter [
	super initializePresenter.
	classSelectorBox
		whenSelectionChanged: [ self actualTextUpdate.
			self textUpdate ]
]

{ #category : #initialization }
LeliExtracMovetMethodBrowser >> initializeWidgets [
	super initializeWidgets.
	classSelectorBox := self instantiate: ListPresenter.
	classSelectorBox beMultipleSelection.
	actualHierarchy := TreePresenter new.
	previewHierarchy := TreePresenter new.
	superiorLabel label: 'Move to: '
]

{ #category : #accessing }
LeliExtracMovetMethodBrowser >> movements: anObject [
	movements := anObject.
	classSelectorBox items: movements possibleClassesCache.
]

{ #category : #accessing }
LeliExtracMovetMethodBrowser >> previewHierarchy [
	^ previewHierarchy
]

{ #category : #'as yet unclassified' }
LeliExtracMovetMethodBrowser >> textUpdate [
	| superClass childrenClasses |
	superClass := movements actualHierarchyCache first.
	previewHierarchy roots: {superClass}.
	childrenClasses := OrderedCollection new.
	movements actualHierarchyCache second do: [ :each | childrenClasses add: each ].
	previewHierarchy
		childrenBlock: [ :it | 
			it = superClass
				ifTrue: [ childrenClasses ]
				ifFalse: [ 1 < classSelectorBox selectedItems size
						ifFalse: [ self addingMethodToSelectedClassInView: it ]
						ifTrue: [ self addingMethodToSelectedClassesInView: it ] ] ].
	previewHierarchy expandAll
]
