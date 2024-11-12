" Vim syntax file
" Language: Sui Move
" Maintainer: Antonio Yang <Antonio.Yang@sui.io>
" Latest Version: 0.1.0

if exists("b:current_syntax")
  finish
endif

syn keyword   moveConditional match if else
syn keyword   moveRepeat      loop while
syn keyword   moveStruct      struct nextgroup=moveIdentifier skipwhite skipempty
syn keyword   moveKeyword     as break continue fun has let public return abort
syn keyword   moveKeyword     module nextgroup=moveFuncName skipwhite skipempty
syn keyword   moveKeyword     public nextgroup=movePubScope skipwhite skipempty
syn keyword   moveKeyword     use nextgroup=moveModPath skipwhite skipempty
syn keyword   moveStorage     mut const
syn keyword   movePubScopePkg package contained
syn keyword   movePrimitive   u8 u16 u32 u64 u128 u256
syn keyword   moveAbility     copy drop key store
syn keyword   moveEnum        Option
syn keyword   moveCommonType  UID ID Balance String vector
syn keyword   moveSelf        self
syn keyword   moveBoolean     true false
syn keyword   moveTodo        contained TODO FIXME XXX NB NOTE SAFETY

syn match moveSection     "\(Imports\|Errors\|Constants\|Structs\|Method Aliases\|Public-Mutative Functions\|Public-View Functions\|Admin Functions\|Public-Package Functions\|Private Functions\|Test Functions\)"
syn match moveMacro       "macro fun"
syn match moveMacroVar    "$\w\+"
syn match movePubScopeDel /[()]/ contained
syn match movePubScope    /([^()]*)/ contained contains=movePubScopeDel,movePubScopePkg,moveModPath,moveModPathSep,moveSelf transparent

syn match moveModPath     "\(\w\)*::[^<]"he=e-3,me=e-3
syn match moveModPathSep  "::"

syn match moveFuncCall    "\w\(\w\)*("he=e-1,me=e-1
syn match moveFuncCall    "\w\(\w\)*::<"he=e-3,me=e-3 " foo::<T>();

syn match moveOperator    display "\%(+\|-\|/\|*\|=\|\^\|&\||\|!\|>\|<\|%\)=\?"
syn match moveOperator    display "&&\|||"
syn match moveArrowChar   display "->"

syn match moveMacro       '\w\(\w\)*!' contains=moveAssert
syn match moveMacro       '#\w\(\w\)*' contains=moveAssert
syn match moveLabel       display "\'\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*:"
syn match moveLabel       display "\%(\<\%(break\|continue\)\s*\)\@<=\'\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*"

syn match moveEscapeError display contained /\\./
syn match moveEscape      display contained /\\\([nrt0\\'"]\|x\x\{2}\)/
syn match moveEscape      display contained /\\u{\%(\x_*\)\{1,6}}/ " Unicode
syn match moveStrConcat   display contained /\\\n\s*/

syn match moveAddress     display "@0x[a-fA-F0-9_]"
syn match moveNamedAddr   display "@\w*"
syn match moveDecNumber   display "\<[0-9][0-9_]*\%([u]\%(8\|16\|32\|64\|128\|256\)\)\="

syn region moveString        matchgroup=moveStringDelimiter start=+b"+ skip=+\\\\\|\\"+ end=+"+ contains=moveEscape,moveEscapeError,moveStrConcat
syn region moveString        matchgroup=moveStringDelimiter start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=moveEscape,moveEscapeError,moveStrConcat,@Spell
syn region moveString        matchgroup=moveStringDelimiter start='b\?r\z(#*\)"' end='"\z1' contains=@Spell
syn region moveCommentLine   start="//"  end="$"   contains=moveTodo,@Spell
syn region moveCommentSec    start="// ==="  end="===$"   contains=moveSection
syn region moveCommentBlock  matchgroup=moveCommentBlock start="/\*\%(!\|\*[*/]\@!\)\@!" end="\*/" contains=moveTodo,moveCommentBlockNest,@Spell

syn region    moveAttribute   start="#\[" end="\]" contains=@moveAttributeContents,moveAttributeParenthesizedParens,moveAttributeParenthesizedCurly,moveAttributeParenthesizedBrackets
syn region    moveAttributeParenthesizedParens matchgroup=moveAttribute start="\w\%(\w\)*("rs=e end=")"re=s transparent contained contains=moveAttributeBalancedParens,@moveAttributeContents
syn region    moveAttributeParenthesizedCurly matchgroup=moveAttribute start="\w\%(\w\)*{"rs=e end="}"re=s transparent contained contains=moveAttributeBalancedCurly,@moveAttributeContents
syn region    moveAttributeParenthesizedBrackets matchgroup=moveAttribute start="\w\%(\w\)*\["rs=e end="\]"re=s transparent contained contains=moveAttributeBalancedBrackets,@moveAttributeContents
syn region    moveAttributeBalancedParens matchgroup=moveAttribute start="("rs=e end=")"re=s transparent contained contains=moveAttributeBalancedParens,@moveAttributeContents
syn region    moveAttributeBalancedCurly matchgroup=moveAttribute start="{"rs=e end="}"re=s transparent contained contains=moveAttributeBalancedCurly,@moveAttributeContents
syn region    moveAttributeBalancedBrackets matchgroup=moveAttribute start="\["rs=e end="\]"re=s transparent contained contains=moveAttributeBalancedBrackets,@moveAttributeContents
syn cluster   moveAttributeContents contains=moveString,moveCommentLine,moveCommentBlock

if !exists("b:current_syntax_embed")
    let b:current_syntax_embed = 1
    syntax include @MoveCodeInComment <sfile>:p:h/move.vim
    unlet b:current_syntax_embed
endif

hi def link moveDecNumber               moveNumber
hi def link moveHexNumber               moveNumber
hi def link moveOctNumber               moveNumber
hi def link moveBinNumber               moveNumber
hi def link moveAddress                 moveNumber
hi def link moveNamedAddr               moveNumber
hi def link moveIdentifierPrime         moveIdentifier

hi def link movePrimitive               moveType
hi def link moveAbility                 moveType
hi def link moveCommonType              moveType

hi def link moveSigil                   StorageClass
hi def link moveEscape                  Special
hi def link moveEscapeError             Error
hi def link moveStrConcat               Special
hi def link moveString                  String
hi def link moveStringDelimiter         String
hi def link moveNumber                  Number
hi def link moveBoolean                 Boolean
hi def link moveEnum                    moveType
hi def link moveSelf                    Constant
hi def link moveArrowChar               moveOperator
hi def link moveOperator                Operator
hi def link moveKeyword                 Keyword
hi def link moveStruct                  Keyword
hi def link movePubScopeDel             Delimiter
hi def link movePubScopePkg             moveKeyword
hi def link moveRepeat                  Conditional
hi def link moveConditional             Conditional
hi def link moveIdentifier              Identifier
hi def link moveCapsIdent               moveIdentifier
hi def link moveModPath                 Include
hi def link moveModPathSep              Delimiter
hi def link moveFuncName                Function
hi def link moveFuncCall                Function
hi def link moveCommentLine             Comment
hi def link moveCommentBlock            moveCommentLine
hi def link moveAssert                  PreCondit
hi def link moveMacro                   Macro
hi def link moveMacroVar                Macro
hi def link moveType                    Type
hi def link moveTodo                    Todo
hi def link moveCommentSec              Comment
hi def link moveSection                 Label
hi def link moveAttribute               PreProc
hi def link moveStorage                 StorageClass
hi def link moveObsoleteStorage         Error
hi def link moveLabel                   Label

syn sync minlines=200
syn sync maxlines=500

let b:current_syntax = "sui move"
