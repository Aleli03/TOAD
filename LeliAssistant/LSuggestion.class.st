Class {
	#name : #LSuggestion,
	#superclass : #Object,
	#instVars : [
		'optionNumber'
	],
	#category : #'LeliAssistant-Core'
}

{ #category : #accessing }
LSuggestion class >> label [
  self subclassResponsibility.
]

{ #category : #accessing }
LSuggestion >> optionNumber: aNumber [
	optionNumber := aNumber
]
