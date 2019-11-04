Class {
	#name : #LMoveMethodSuggestion,
	#superclass : #LMethodSuggestion,
	#instVars : [
		'selectedMethod',
		'actualHierarchyCache',
		'previewCache',
		'possibleClassesCache'
	],
	#category : #'LeliAssistant-Core'
}

{ #category : #accessing }
LMoveMethodSuggestion >> actualHierarchyCache [
	actualHierarchyCache ifNil: [  actualHierarchyCache := {selectedMethod first criticClass. self possibleClassesCache }].
	^ actualHierarchyCache
]

{ #category : #accessing }
LMoveMethodSuggestion >> possibleClassesCache [
possibleClassesCache ifNil:[
	possibleClassesCache := selectedMethod first criticClass subclasses.
	].
	^ possibleClassesCache
]

{ #category : #accessing }
LMoveMethodSuggestion >> previewCache [
	^ previewCache
]

{ #category : #accessing }
LMoveMethodSuggestion >> selectedMethod [
	^ selectedMethod
]

{ #category : #accessing }
LMoveMethodSuggestion >> selectedMethod: anObject [
	selectedMethod := anObject
]
