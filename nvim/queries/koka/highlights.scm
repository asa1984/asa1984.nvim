; Ported from mtoohey31/tree-sitter-koka (queries/highlights.scm at
; 6dce132911ac375ac1a3591c868c47a2a84b30aa), MIT License, Copyright (c)
; Matthew Toohey.
;
; Upstream's queries are written for Helix. This port renames the captures to
; Neovim's standard ones (e.g. `@keyword.control.import` -> `@keyword.import`,
; `@namespace` -> `@module`), and moves the indexing pattern below the call
; patterns: Neovim lets the last matching pattern win, so upstream's order
; would highlight `xs` in `xs[i]` as a function call.

; Comment

[
  (linecomment)
  (blockcomment)
] @comment @spell

; Literals

[
  (string)
  (char)
] @string

(escape) @string.escape

(float) @number.float
(int) @number

; Delimiters

(matchrule "|" @punctuation.delimiter)

[
  ","
  "->"
  "."
  ":"
  "::"
  "<-"
  ";"
] @punctuation.delimiter

[
  "<"
  ">"
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

; Keywords

[
  "as"
  "behind"
  (externtarget)
  "forall"
  "handle"
  "handler"
  "in"
  "infix"
  "infixl"
  "infixr"
  "inject"
  "mask"
  "other"
  "pub"
  "public"
  "some"
  "with"
] @keyword

[
  "con"
  "control"
  "ctl"
  "fn"
  "fun"
  "rawctl"
  "rcontrol"
] @keyword.function

[
  "elif"
  "else"
  "if"
  "match"
  "then"
] @keyword.conditional

[
  "import"
  "include"
  "module"
] @keyword.import

[
  "alias"
  "effect"
  "struct"
  "type"
  "val"
  "var"
] @keyword.type

[
  "abstract"
  "co"
  "extend"
  "extern"
  "fbip"
  "final"
  "fip"
  "inline"
  "linear"
  "named"
  "noinline"
  "open"
  "override"
  "raw"
  "rec"
  "ref"
  "reference"
  "scoped"
  "tail"
  "value"
] @keyword.modifier

"return" @keyword.return

; Operators

[
  "!"
  "~"
  "="
  ":="
  (idop)
  (op)
  (qidop)
] @operator

; Identifiers

(conid) @constructor

(varid) @variable

(qidop) @module

(qconid) @module

(modulepath (varid) @module)

(qvarid
  (qid) @module)

(typecon
  (varid) @type)

(tbinder
  (varid) @type)

(typeid
  (varid) @type)

(typedecl
  "effect"
  (varid) @type)

(paramid
  (identifier
    (varid) @variable.parameter))

(pparameter
  (pattern
    (identifier
      (varid) @variable.parameter)))

(puredecl
  (binder
    (identifier
      [(varid) (idop)] @constant)))

; Function definitions

(operation
  (identifier
    [(varid) (idop)] @function))

(fundecl
  (funid
    (identifier
      [(varid) (idop)] @function)))

(puredecl
  (funid
    (identifier
      [(varid) (idop)] @function)))

; Function calls

[
  "initially"
  "finally"
] @function.builtin

(appexpr
  field: (atom
    (qidentifier
      [
        (qvarid) @function.call
        (qidop) @function.call
        (identifier
          [(varid) (idop)] @function.call)
      ])))

(appexpr
  function: (appexpr
    (atom
      (qidentifier
        [
          (qvarid) @function.call
          (qidop) @function.call
          (identifier
            [(varid) (idop)] @function.call)
        ])))
  ["(" (block) (fnexpr)])

; Indexing (`xs[i]`) is not a call.

(appexpr
  (appexpr
    field: (atom
      (qidentifier
        [
          (qvarid) @variable
          (qidop) @variable
          (identifier
            [(varid) (idop)] @variable)
        ])))
  "[")
