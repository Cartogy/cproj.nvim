if exists("b:current_syntax")
    finish
endif

" syntax keyword potionKeyword to times
" syntax match potionComment "\v#.*$"
" 
" highlight link potionComment Comment
" highlight link potionKeyword Keyword
" 
syntax match testlogRun "\v\[\ *RUN\ *\]"
syntax match testlogOk "\v\[\ *OK\ *\]"

syntax match testlogPass "\v\[\ *PASSED\ *\] [1-9]+"

syntax match testlogTest "\v[A-Z][a-zA-Z0-9]+\.[A-Z][a-zA-Z]+"

syntax match testlogFail "\v\[\ *FAILED\ *\]"

syntax match testlogBegin "\v\[\=+\]"
syntax match testlogSpace "\v\[-+\]"

highlight link testlogRun Debug
highlight link testlogOk Function
highlight link testlogPass Function
highlight link testlogTest Type
highlight link testlogFail Error
highlight link testlogBegin Define
highlight link testlogSpace Debug

" syntax match potionOperator "\v\*"
" syntax match potionOperator "\v/"
" syntax match potionOperator "\v\+"
" syntax match potionOperator "\v-"
" syntax match potionOperator "\v\?"
" syntax match potionOperator "\v\*\="
" syntax match potionOperator "\v/\="
" syntax match potionOperator "\v\+\="
" syntax match potionOperator "\v-\="
" 
" highlight link potionOperator Operator
" 
" syntax region potionString start=/\v"/ skip=/\v\\./ end=/\v"/
" highlight link potionString String

let b:current_syntax = "testlog"
