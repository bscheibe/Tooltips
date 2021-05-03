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
                
