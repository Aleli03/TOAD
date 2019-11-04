Class {
	#name : #LSuggestionFactory,
	#superclass : #Object,
	#instVars : [
		'context',
		'positions',
		'parseTree',
		'intervals',
		'suggestions',
		'suggestionClass',
		'k'
	],
	#category : #'LeliAssistant-Menu'
}

{ #category : #'instance creation' }
LSuggestionFactory class >> on: aContext for: aSuggestionClass [
	|ins|
	ins := self new.
	ins context: aContext.
	ins suggestionClass: aSuggestionClass.
	^ ins.
]

{ #category : #'actions lookup' }
LSuggestionFactory >> build [
	self extractPositions.
	self sortPositions.
	self createIntervals.
	self createSuggestions
]

{ #category : #initialization }
LSuggestionFactory >> buildSuggestions [
	intervals
		do: [ :interval | 
			| sug |
			sug := suggestionClass on: context.
			sug sourceCodeInterval: interval.
			suggestions
				detect: [ :each | each = sug ]
				ifNone: [ [ sug checkPreconditions.
						sug isValid ifTrue:[k:= k-1.].
					suggestions add: sug.
					k == 0
						ifTrue: [ ^ self ] ]
						on: Error
						do: [  ] ] ]
]

{ #category : #accessing }
LSuggestionFactory >> closestInterval [
	| a b |
	a := 1.
	b := self fullSourceCode size.
	positions
		reverseDo: [ :pos | 
			pos >= self selectedInterval first
				ifTrue: [ a := pos ] ].
	positions
		do: [ :pos | 
			pos <= self selectedInterval last
				ifTrue: [ b := pos ] ].
	^ a to: b
]

{ #category : #accessing }
LSuggestionFactory >> context [
	^ context
]

{ #category : #accessing }
LSuggestionFactory >> context: anObject [
	context := anObject
]

{ #category : #accessing }
LSuggestionFactory >> createIntervals [
	"protocol: accessing"

	| i j in c |
	i := 1.
	j := positions size.
	in := self closestInterval.
	(1 to: positions size)
		do: [ :index | 
			| val |
			val := positions at: index.
			val <= in first
				ifTrue: [ i := index ] ].
	(1 to: positions size)
		reverseDo: [ :index | 
			| val |
			val := positions at: index.
			val >= in last
				ifTrue: [ j := index ] ].
	(1 to: i)
		do: [ :p1 | 
			(j to: positions size)
				do: [ :p2 | 
					| a b |
					a := positions at: p1.
					b := positions at: p2.
					intervals add: (a to: b) ] ].
	intervals := intervals
		asSortedCollection: [ :a :b | a size < b size ].
]

{ #category : #accessing }
LSuggestionFactory >> createSuggestions [
	| index |
	index := 1.
	self buildSuggestions.
	suggestions := suggestions select: #isValid.
	suggestions
		do: [ :sug | 
			sug optionNumber: index.
			index := index + 1 ]
]

{ #category : #accessing }
LSuggestionFactory >> extractPositions [
	| tree |
	tree := self selectedMethod parseTree.
	tree allChildren
		do: [ :node | 
			positions add: node start.
			positions add: node stop ]
]

{ #category : #accessing }
LSuggestionFactory >> extractPositions: delta [
	positions := Set new.
	self parseTree allChildren copy
		do: [ :node | 
			| interval |
			interval := node sourceInterval.
			positions add: interval first.
			positions add: interval last ]
]

{ #category : #accessing }
LSuggestionFactory >> fullSourceCode [
	^ self selectedMethod sourceCode
]

{ #category : #initialization }
LSuggestionFactory >> initialize [
	super initialize.
	positions := Set new.
	intervals := OrderedCollection new.
	suggestions := OrderedCollection new.
	k := 3
]

{ #category : #accessing }
LSuggestionFactory >> limit: anInteger [
	k:= anInteger.
]

{ #category : #accessing }
LSuggestionFactory >> parseTree [
	parseTree ifNil:[ parseTree := context selectedMethod parseTree.].
	^  parseTree.
]

{ #category : #accessing }
LSuggestionFactory >> selectedClass [
	^ context selectedClass.
]

{ #category : #accessing }
LSuggestionFactory >> selectedInterval [
	^ context selectedInterval.
]

{ #category : #accessing }
LSuggestionFactory >> selectedMethod [
	^ context selectedMethod.
]

{ #category : #accessing }
LSuggestionFactory >> sortPositions [
	positions := positions asSortedCollection

	
]

{ #category : #accessing }
LSuggestionFactory >> suggestionClass: anObject [
	suggestionClass := anObject
]

{ #category : #accessing }
LSuggestionFactory >> suggestions [
	^ suggestions
]
