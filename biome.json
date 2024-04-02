{
	"$schema": "./node_modules/@biomejs/biome/configuration_schema.json",
	"organizeImports": {
		"enabled": true
	},
	"formatter": {
		"enabled": true,
		"formatWithErrors": true,
		"indentStyle": "tab",
		"indentWidth": 4,
		"lineWidth": 140
	},
	"javascript": {
		"formatter": {
			"quoteStyle": "single",
			"jsxQuoteStyle": "single"
		},
		"globals": ["__DEV__"]
	},
	"linter": {
		"enabled": true,
		"ignore": ["node_modules"],
		"rules": {
			"all": true,
			"complexity": {
				"noUselessFragments": "off",
				"noExcessiveCognitiveComplexity": "off"
			},
			"style": {
				"useSingleVarDeclarator": "off",
				"noParameterAssign": "off",
				"noNonNullAssertion": "off",
				"useNamingConvention": "off",
				"useFilenamingConvention": "off",
				"useBlockStatements": "off",
				"noDefaultExport": "off",
				"noImplicitBoolean": "off"
			},
			"suspicious": {
				"noExplicitAny": "off",
				"noArrayIndexKey": "off",
				"noEmptyBlockStatements": "off",
				"noConsoleLog": "off",
				"useAwait": "off"
			},
			"correctness": {
				"useExhaustiveDependencies": "off"
			},
			"performance": {
				"noAccumulatingSpread": "off"
			},
			"nursery": {
				"all": false
			}
		}
	}
}
