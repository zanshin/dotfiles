## Notes on Vim Script
> There are several name spaces for variables.  
> Which one is to be used is specified by what is prepended:

| scope             | prefix | definition                                  |
|:------------------|:-------|:--------------------------------------------|
| buffer-variable   | `b:`   | Local to the current buffer.                |
| window-variable   | `w:`   | Local to the current window.                |
| tabpage-variable  | `t:`   | Local to the current tab page.              |
| global-variable   | `g:`   | Global.                                     |
| local-variable    | `l:`   | Local to a function.                        |
| script-variable   | `s:`   | Local to a `:source`ed Vim script.          |
| function-argument | `a:`   | Function argument (only inside a function). |
| vim-variable      | `v:`   | Global, predefined by Vim.                  |

## NAMING CONVENTIONS  

> see `:h group-name`

- *Comment* any comment
- *Constant* any constant
  - *String*  a string constant: "this is a string"
  - *Character* a character constant: 'c', '\n'
  - *Number*  a number constant: 234, 0xff
  - *Boolean* a boolean constant: TRUE, false
  - *Float*  a floating point constant: 2.3e10
- *Identifier* any variable name
  - Function function name (also: methods for classes)
- *Statement* any statement
  - *Conditional* if, then, else, endif, switch, etc.
  - *Repeat*  for, do, while, etc.
  - *Label*  case, default, etc.
  - *Operator* "sizeof", "+", "*", etc.
  - *Keyword* any other keyword
  - *Exception* try, catch, throw
- *PreProc* generic Preprocessor
  - *Include* preprocessor #include
  - *Define*  preprocessor #define
  - *Macro*  same as Define
  - *PreCondit* preprocessor #if, #else, #endif, etc.
- *Type*  int, long, char, etc.
  - *StorageClass* static, register, volatile, etc.
  - *Structure* struct, union, enum, etc.
  - *Typedef* A typedef
- *Special* any special symbol
  - *SpecialChar* special character in a constant
  - *Tag*  you can use CTRL-] on this
  - *Delimiter* character that needs attention
  - *SpecialComment* special things inside a comment
  - *Debug*  debugging statements
- *Underlined* text that stands out, HTML links
- *Ignore*  left blank, hidden  |hl-Ignore|
- *Error*  any erroneous construct
- *Todo*  anything that needs extra attention; mostly the keywords TODO FIXME and XXX
