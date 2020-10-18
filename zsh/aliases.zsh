alias ca="conda activate"
alias condd="conda deactivate"
alias jn="jupyter notebook"
alias jl="jupyter lab"
alias lc="colorls -lA --sd"

# pacman aliases
alias pac='sudo pacman -S'   # install
alias pacu='sudo pacman -Syu'    # update, add 'a' to the list of letters to update AUR packages if you use yaourt
alias pacr='sudo pacman -Rs'   # remove
alias pacs='pacman -Ss'      # search
alias paci='pacman -Si'      # info
alias paclo='sudo pacman -Qdt'    # list orphans
alias pacro='sudo paclo && sudo pacman -Rns $(pacman -Qtdq)' # remove orphans
alias pacc='pacman -Scc'    # clean cache
alias paclf='pacman -Ql'   # list files

# yay aliases
alias yayy='yay -S'   # install
alias yayu='yay -Syu'    # update, add 'a' to the list of letters to update AUR packages if you use yaourt
alias yayr='yay -Rs'   # remove
alias yays='yay -Ss'      # search
alias yayi='yay -Si'      # info
alias yaylo='yay -Qdt'    # list orphans
alias yayro='yaylo && sudo yay -Rns $(yay -Qtdq)' # remove orphans
alias yayc='yay -Scc'    # clean cache
alias yaylf='yay -Ql'   # list files
