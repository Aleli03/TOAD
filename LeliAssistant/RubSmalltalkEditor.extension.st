Extension { #name : #RubSmalltalkEditor }

{ #category : #'*LeliAssistant' }
RubSmalltalkEditor class >> refactoringSuggestionsMenuOn: aBuilder [
	<RubSmalltalkCodeMenu>
	aBuilder
		item: 'Refactoring Suggestions...';
		selector: #value;
		target: [  ];
		keyText: 'r ';
		order: 0;
		iconName: #smallAuthoringTools;
		with: [ LMenuBuilder buildContextMenuOn: aBuilder ]
]
