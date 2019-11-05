/*
used packages:
	eslint eslint-config-airbnb eslint-plugin-import eslint-plugin-json eslint-plugin-jsx-a11y eslint-plugin-optimize-regex \
	eslint-plugin-react eslint-plugin-typescript typescript-eslint-parser

global:
	# add ~/.config/yarn/global/node_modules/.bin to your $PATH or use sudo to install it to /usr/local/bin
	yarn global add {packages}

local:
	yarn add --dev {packages}
*/

const plugins = ['typescript', 'react', 'optimize-regex', 'json'];

module.exports = {
	extends: ['eslint:recommended'],
	plugins,
	"parser": "babel-eslint",
	"parserOptions": {
		"ecmaVersion": 6,
		"sourceType": "module",
		"ecmaFeatures": {
			"jsx": true,
			"modules": true,
		}
	},

	env: {
		browser: true,
		node: true,
		es6: true,
	},

	rules: {
		'no-undef': 0,
		'no-unused-vars': 0,
		'no-console': 0,
		'react/no-unescaped-entities': 0,
		'react/display-name': 0,
		'no-case-declarations': 0,
		'curly': ['error', 'multi-line'],
		'array-bracket-spacing': ['error', 'never'],
		// quotes: ["error", "single"],
		'jsx-quotes': ['error', 'prefer-double'],
		// 'prettier/prettier': ['error', prettierConfig],

		// shit for airbnb
		'radix': ['error', 'as-needed'],
		'no-tabs': 0,
		'no-multi-str': 0,
		'no-restricted-globals': 0,
		'max-len': ['warn', { 'code': 160, 'tabWidth': 4, 'ignoreUrls': true }],
		'prefer-template': 0,
		'arrow-parens': ['error', 'always'],
		'no-restricted-syntax': 0,
		'one-var': 0,
		'prefer-const': ['error', { destructuring: 'all' }],
		'quote-props': ['error', 'consistent'],
		'class-methods-use-this': 0,
		'no-continue': 0,
		'no-script-url': 0,
		'default-case': 0,
		'no-multiple-empty-lines': ['error', { max: 1, maxEOF: 0, maxBOF: 0 }],
		'indent': ['error', 'tab', { SwitchCase: 1, VariableDeclarator: 1 }],
		'object-curly-newline': ['error', { multiline: true }],
		'no-plusplus': 0,

		'react/sort-comp': 0,
		'react/jsx-indent': ['error', 'tab'],
		'react/jsx-indent-props': ['error', 'tab'],
		'react/jsx-filename-extension': [1, { extensions: ['.ts', '.tsx'] }],
		'react/no-did-mount-set-state': 0,
		'react/no-array-index-key': 0,
		'react/no-multi-comp': 0,
		'react/jsx-max-props-per-line': [1, { maximum: 10, when: 'multiline' }],
		'jsx-a11y/anchor-is-valid': 0,
		'jsx-a11y/click-events-have-key-events': 0,
		'jsx-a11y/no-static-element-interactions': 0,

		'import/no-unresolved': 0,
		'import/extensions': ['.ts', '.tsx'],
		'import/prefer-default-export': 0,
		'import/no-extraneous-dependencies': 0,
	},

	overrides: [
		{
			files: ['*.tsx'],
			parser: 'typescript-eslint-parser',
			parserOptions: { ecmaFeatures: { jsx: true } },
		},
		{
			files: ['*.ts'],
			parser: 'typescript-eslint-parser',
			parserOptions: { ecmaFeatures: { jsx: false } },
		},
		{
			files: ['*.css', '*.less', '*.scss'],
			rules: {
				'prettier/prettier': [
					'error',
					{ singleQuote: false },
				],
			},
		},
	],
};
