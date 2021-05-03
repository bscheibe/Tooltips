" Bruce Scheibe
" Presents tooltips when hovering names in source code.
" Requires CTags file(s) to be loaded.


let g:tooltips=1
set balloondelay=300 " Default to 300ms


" Command.
ab tooltips call ToggleTooltips()
ab tooltipdelay call SetTooltipDelay()


if has("gui_running")
        amenu Plugins.Tooltips.Toggle\ Tooltips : call ToggleTooltips()<CR>
        amenu Plugins.Tooltips.Tooltip\ Delay : call SetTooltipDelay()<CR>
endif


function! ToggleTooltips()
        if g:tooltips
                set balloonexpr=BinaryTagSearch()
        else
                set balloonexpr=''
        endif
        set ballooneval " Toggles.
        let g:tooltips=!g:tooltips
endfunction


function! SetTooltipDelay()
        let &balloondelay=str2nr(input('Enter a new tooltip delay (milliseconds): '))
endfunction
        
  
" Initialize
call ToggleTooltips()


function! BinaryTagSearch()
        for file in split(g:tags, " ")
                echo "Scanning ".split(file, "/")[-1]."..."
                let lines=readfile(file)
                let result=s:BinarySearch(lines)
                if ""!=result
                        echo ""
                        return result
                endif
        endfor
endfunction


function! s:BinarySearch(lines)
        let low=0
        let high=len(a:lines)-1
        while low <= high
                let pos=(low+high)/2
                let cur_word=split(a:lines[pos], "      ")[0] " This should be a tab character. ^l
                if v:beval_text ==# cur_word
                        return s:FormatHelper(a:lines[pos])
                else
                        let low=pos+1
                endif
        endwhile
        return ""
endfunction


function! s:FormatHelper(word_list)
        let words=split(a:words_list, " ") " Meant to be tab-separated. ^l
        return v:beval_text."\nFile: ".words[1]."\nContext: ".words[-1]
endfunction
