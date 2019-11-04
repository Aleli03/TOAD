Extension { #name : #RBExtractToTemporaryRefactoring }

{ #category : #'*LeliAssistant' }
RBExtractToTemporaryRefactoring >> copyWithTemporary [
	| node statementNode nodeReferences children copy |
	copy := class parseTreeFor: selector.
	node := copy whichNodeIsContainedBy: sourceInterval.
	(node notNil and: [ node isValue ])
		ifFalse: [ self refactoringFailure: 'Cannot assign to non-value nodes' ].
	children := copy body allChildren.
	nodeReferences := children
		select: [ :each | each = node ]
		thenCollect: [ :each | each ].
	statementNode := node statementNode.
	nodeReferences
		do: [ :each | each replaceWith: (RBVariableNode named: newVariableName) ].
	statementNode parent
		addNode: (self constructAssignmentFrom: node)
			before:
			(node == statementNode
				ifTrue: [ RBVariableNode named: newVariableName ]
				ifFalse: [ statementNode ]);
		addTemporaryNamed: newVariableName.
	^ copy.
]

{ #category : #'*LeliAssistant' }
RBExtractToTemporaryRefactoring >> newVariableName: aString [
	newVariableName := aString
]

{ #category : #'*LeliAssistant' }
RBExtractToTemporaryRefactoring >> previewString [
	^ self copyWithTemporary formattedCode
]

{ #category : #'*LeliAssistant' }
RBExtractToTemporaryRefactoring >> previewString: aString [
	self newVariableName: aString.
	^ self previewString.
]
