/* eslint-disable no-constant-condition */
const base = {
	root: true,
	parser: '@babel/eslint-parser',
	plugins: [ '@typescript-eslint', 'react', 'import' ],
	settings: { react: { version: 'detect' }},
	parserOptions: {
		ecmaFeatures: { jsx: true },
		ecmaVersion: 12,
		requireConfigFile: true
	},
	env: {
		node: true,
		browser: true,
		es2021: true
	}
};

module.exports = (process.env.NODE_ENV) ? base : {
	...base,

	extends: [
		'eslint:recommended',
		'plugin:@typescript-eslint/eslint-recommended',
		'plugin:@typescript-eslint/recommended',
		'plugin:react/recommended',
		'google'
	],

	rules: {
		'no-tabs': [ 'error', { allowIndentationTabs: true }],
		'indent': [ 'error', 'tab' ],
		'quotes': [ 'error', 'single', { avoidEscape: true }],
		'semi': [ 'error', 'always' ],
		'max-len': [ 'warn', { code: 160, tabWidth: 4, ignoreUrls: true }],

		'prefer-const': 'off',
		'react/no-unescaped-entities': 'off',
		'react/prop-types': 'off',
		'react/display-name': 'off',
		'one-var': 'off',
		'no-unused-vars': 'warn',
		'require-jsdoc': 'off',
		'no-invalid-this': 'off',
		'comma-dangle': [ 'error', 'never' ],
		'no-multiple-empty-lines': [ 'error', { max: 1, maxEOF: 0, maxBOF: 0 }],
		'brace-style': [ 'error', '1tbs', { allowSingleLine: true }],

		'array-bracket-spacing': [ 'error', 'always', { objectsInArrays: false, arraysInArrays: false, singleValue: false }],
		'object-curly-spacing': [ 'error', 'always', { objectsInObjects: false, arraysInObjects: false }],

		'object-curly-newline': [
			'error',
			{
				ObjectExpression: { minProperties: 9999, consistent: false, multiline: true },
				ObjectPattern: { minProperties: 9999, consistent: false, multiline: true },
				ImportDeclaration: { minProperties: 9999, consistent: false, multiline: false },
				ExportDeclaration: { minProperties: 9999, consistent: false, multiline: true }
			}
		],
		'import/order': [ 'error', { 'newlines-between': 'always-and-inside-groups' }],
		'@typescript-eslint/no-explicit-any': 'off'
	},

	overrides: [
		{
			files: [ '*.js', '*.jsx' ],
			rules: {
				'@typescript-eslint/explicit-module-boundary-types': 'off',
				'@typescript-eslint/no-unused-vars': 'off',
				'@typescript-eslint/no-var-requires': 'off'
			}
		}
	]
};
