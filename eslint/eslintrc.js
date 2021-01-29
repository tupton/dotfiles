module.exports = {
    "parser": "@babel/eslint-parser",
    "parserOptions": {
        "sourceType": "module",
        "ecmaVersion": 8,
        "ecmaFeatures": {
            "arrowFunctions": true,
            "binaryLiterals": false,
            "blockBindings": true,
            "classes": false,
            "defaultParams": true,
            "destructuring": true,
            "forOf": true,
            "generators": true,
            "modules": false,
            "objectLiteralComputedProperties": true,
            "objectLiteralDuplicateProperties": false,
            "objectLiteralShorthandMethods": true,
            "objectLiteralShorthandProperties": true,
            "octalLiterals": false,
            "regexUFlag": false,
            "regexYFlag": false,
            "restParams": true,
            "spread": true,
            "superInFunctions": false,
            "templateStrings": true,
            "unicodeCodePointEscapes": false,
            "globalReturn": false,
            "jsx": false
        }
    },

    "env": {
        "browser": true,
        "node": true,
        "worker": false,
        "amd": true,
        "mocha": false,
        "jasmine": false,
        "phantomjs": true,
        "jquery": false,
        "prototypejs": false,
        "shelljs": false,
        "meteor": false,
        "es6": true
    },

    "globals": {
        "Orbited": false,
        "STOMPClient": false,
        "dojoConfig": true,
        "define": false,
        "require": false
    },

    "plugins": [
                                                                          
    ],

    "extends": [
        "eslint:recommended"
    ],

    "rules": {
        "brace-style": 0,
        "no-multiple-empty-lines": 2,
        "dot-location": [
        2,
        "property"
        ],
        "operator-linebreak": 0,
        "keyword-spacing": [
        2,
        {
          "overrides": {
            "else": {
              "before": true
            },
            "while": {
              "before": true
            },
            "catch": {
              "before": true
            }
          }
        }
        ],
        "key-spacing": 0,
        "space-unary-ops": 0,
        "space-before-function-paren": 0,
        "no-spaced-func": 0,
        "comma-style": 0,
        "eol-last": 0,
        "space-before-blocks": 0,
        "no-multi-spaces": 0,
        "indent": 0,
        "no-trailing-spaces": 0,
        "no-warning-comments": 0,
        "no-implicit-coercion": [
        2,
        {
          "boolean": false,
          "string": false,
          "number": false
        }
        ],
        "quote-props": [
        2,
        "as-needed"
        ],
        "dot-notation": 2,
        "wrap-iife": 2,
        "curly": 2,
        "no-mixed-spaces-and-tabs": 0,
        "semi": 0,
        "linebreak-style": 0,
        "quotes": 0,
        "valid-jsdoc": 0,
        "comma-dangle": 2,
        "no-cond-assign": 0,
        "no-console": 0,
        "no-constant-condition": 2,
        "no-control-regex": 1,
        "no-debugger": 2,
        "no-dupe-args": 2,
        "no-dupe-keys": 2,
        "no-duplicate-case": 2,
        "no-empty": 2,
        "no-ex-assign": 2,
        "no-extra-boolean-cast": 2,
        "no-extra-parens": 1,
        "no-extra-semi": 2,
        "no-func-assign": 2,
        "no-inner-declarations": [
        2,
        "functions"
        ],
        "no-invalid-regexp": 2,
        "no-irregular-whitespace": 2,
        "no-negated-in-lhs": 2,
        "no-obj-calls": 2,
        "no-regex-spaces": 2,
        "no-sparse-arrays": 2,
        "no-unreachable": 2,
        "use-isnan": 2,
        "valid-typeof": 2,
        "block-scoped-var": 2,
        "complexity": 0,
        "consistent-return": 1,
        "default-case": 1,
        "eqeqeq": 2,
        "guard-for-in": 0,
        "no-alert": 2,
        "no-caller": 2,
        "no-div-regex": 1,
        "no-else-return": 1,
        "no-labels": [
        2,
        {
          "allowSwitch": true
        }
        ],
        "no-eq-null": 2,
        "no-eval": 2,
        "no-extend-native": 2,
        "no-extra-bind": 2,
        "no-fallthrough": 2,
        "no-floating-decimal": 1,
        "no-implied-eval": 2,
        "no-iterator": 2,
        "no-lone-blocks": 2,
        "no-loop-func": 1,
        "no-multi-str": 2,
        "no-native-reassign": 2,
        "no-new": 1,
        "no-new-func": 2,
        "no-new-wrappers": 2,
        "no-octal": 2,
        "no-octal-escape": 2,
        "no-param-reassign": 0,
        "no-process-env": 0,
        "no-proto": 2,
        "no-redeclare": 2,
        "no-return-assign": 2,
        "no-script-url": 0,
        "no-self-compare": 2,
        "no-sequences": 2,
        "no-throw-literal": 2,
        "no-unused-expressions": 2,
        "no-void": 2,
        "no-with": 2,
        "radix": 2,
        "vars-on-top": 0,
        "yoda": 0,
        "strict": 0,
        "no-catch-shadow": 2,
        "no-delete-var": 2,
        "no-label-var": 2,
        "no-shadow": 2,
        "no-shadow-restricted-names": 2,
        "no-undef": 2,
        "no-undef-init": 2,
        "no-undefined": 0,
        "no-unused-vars": 2,
        "no-use-before-define": 2,
        "handle-callback-err": 1,
        "no-mixed-requires": 1,
        "no-new-require": 2,
        "no-path-concat": 2,
        "no-process-exit": 1,
        "no-restricted-modules": 0,
        "no-sync": 0,
        "new-parens": 2,
        "no-array-constructor": 2,
        "no-lonely-if": 1,
        "no-new-object": 2,
        "operator-assignment": [
        1,
        "always"
        ],
        "camelcase": 0,
        "comma-spacing": 0,
        "consistent-this": 0,
        "func-names": 0,
        "func-style": 0,
        "lines-around-comment": 0,
        "max-nested-callbacks": 0,
        "new-cap": 0,
        "newline-after-var": 0,
        "no-continue": 0,
        "no-inline-comments": 0,
        "no-nested-ternary": 0,
        "no-ternary": 0,
        "no-underscore-dangle": 0,
        "object-curly-spacing": 0,
        "one-var": 0,
        "padded-blocks": 0,
        "semi-spacing": 0,
        "sort-vars": 0,
        "space-after-keywords": 0,
        "space-in-brackets": 0,
        "space-in-parens": 0,
        "space-infix-ops": 0,
        "space-return-throw-case": 0,
        "spaced-line-comment": 0,
        "wrap-regex": 0,
        "generator-star-spacing": 0,
        "no-var": 0,
        "object-shorthand": 0,
        "max-depth": 0,
        "max-len": 0,
        "max-params": 0,
        "max-statements": 0,
        "no-bitwise": 1,
        "no-plusplus": 0
    }
}

