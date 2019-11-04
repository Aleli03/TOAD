Class {
	#name : #LSuggestionFactoryInsideSelection,
	#superclass : #LSuggestionFactory,
	#category : #'LeliAssistant-Menu'
}

{ #category : #accessing }
LSuggestionFactoryInsideSelection >> createIntervals [
	"protocol: accessing"

	| i j in c |
	i := 1.
	j := positions size.
	in := self closestInterval.
	(1 to: positions size)
		reverseDo: [ :index | 
			| val |
			val := positions at: index.
			val >= in first
				ifTrue: [ i := index ] ].
	(1 to: positions size)
		do: [ :index | 
			| val |
			val := positions at: index.
			val <= in last
				ifTrue: [ j := index ] ].
	(i to: j)
		do: [ :p1 | 
			(i + 1 to: j)
				do: [ :p2 | 
					| a b |
					a := positions at: p1.
					b := positions at: p2.
					intervals add: (a to: b) ] ].
	intervals := intervals
		asSortedCollection: [ :a :b | a size > b size ].
]
