Class {
	#name : #LMenuBuilder,
	#superclass : #Object,
	#category : #'LeliAssistant-Menu'
}

{ #category : #builder }
LMenuBuilder class >> buildContextMenuOn: aBuilder [
	| context items |
	context := SugsAbstractContext contextFor: aBuilder model.
	"ugly but I have to do it fast"
	context class = ClySugsMethodContext
		ifFalse: [ ^ false ].
	items := self buildSuggestionsFor: context.
	items
		associationsDo: [ :item | 
			aBuilder
				item: item name;
				target: item;
				selector: #execute;
				icon: nil ]
]

{ #category : #builder }
LMenuBuilder class >> buildSuggestionsFor: aClySugsMethodContext [
	| items |
	items := OrderedCollection new.
	{LExtractMethodSuggestion}
		do: [ :cls | 
			| sugs |
			items
				add:
					(LMenuItem new
						name: cls label;
						context: aClySugsMethodContext;
						classBind: cls;
						suggestions: {};
						yourself) ].
	"{LExtractMethodSuggestion.
	LCreateCascadeSuggestion.
	LInlineMethodSuggestion}"
	"{LExtractToTemporarySuggestion}"
	"{LExtractMethodSuggestion}"
	^ items
]
