Class {
	#name : #LMenuItem,
	#superclass : #Object,
	#instVars : [
		'name',
		'suggestions',
		'icon',
		'context',
		'classBind'
	],
	#category : #'LeliAssistant-Menu'
}

{ #category : #accessing }
LMenuItem >> classBind [
	^ classBind
]

{ #category : #accessing }
LMenuItem >> classBind: anObject [
	classBind := anObject
]

{ #category : #accessing }
LMenuItem >> context [
	^ context
]

{ #category : #accessing }
LMenuItem >> context: anObject [
	context := anObject
]

{ #category : #'as yet unclassified' }
LMenuItem >> execute [
	| upperSuggestions lowerSuggestions |
	upperSuggestions := (LSuggestionFactory on: context for: classBind)
		limit: 3;
		build;
		suggestions.
	[ upperSuggestions size < 3 ]
		whileTrue: [ upperSuggestions add: nil ].
	lowerSuggestions := (LSuggestionFactoryInsideSelection
		on: context
		for: classBind)
		limit: 3;
		build;
		suggestions.
	(upperSuggestions isEmpty and: [ lowerSuggestions isEmpty ])
		ifTrue: [ self error: 'We couldnt find refactoring alternatives' ].
	(lowerSuggestions isEmpty not and: [ upperSuggestions isEmpty not ])
		ifTrue: [ lowerSuggestions first = upperSuggestions first
				ifTrue: [ lowerSuggestions removeFirst ] ].
	lowerSuggestions size > 2
		ifTrue: [ lowerSuggestions removeLast ].
	[ lowerSuggestions size < 2 ]
		whileTrue: [ lowerSuggestions add: nil ].
	suggestions := lowerSuggestions reverse.
	suggestions addAll: upperSuggestions.
	(LeliSourceCodeWithFieldBrowser on: suggestions) openWithSpec
]

{ #category : #accessing }
LMenuItem >> icon [
	^ icon
]

{ #category : #accessing }
LMenuItem >> icon: anObject [
	icon := anObject
]

{ #category : #accessing }
LMenuItem >> name [
	^ name
]

{ #category : #accessing }
LMenuItem >> name: anObject [
	name := anObject
]

{ #category : #accessing }
LMenuItem >> suggestions [
	^ suggestions
]

{ #category : #accessing }
LMenuItem >> suggestions: anObject [
	suggestions := anObject
]
