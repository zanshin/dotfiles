# Solarized Theme
# Attempting to copy: http://ethanschoonover.com/solarized
# Example: http://i.imgur.com/T9BTRG4.png
 
if patched_font_in_use; then
  TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="⮂"
    TMUX_POWERLINE_SEPARATOR_LEFT_THIN="⮃"
    TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="⮀"
    TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="⮁"
else
    TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="◀"
    TMUX_POWERLINE_SEPARATOR_LEFT_THIN="❮"
    TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="▶"
    TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="❯"
fi
 
TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-'235'}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-'255'}
 
TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}
 
#background tones
BASE03="16" #actually closer to 17, but 16 looks better
BASE02="236"
#content tones
BASE01="60"
BASE00="66"
BASE0="102"
BASE1="109"
#background tones
BASE2="224"
BASE3="230"
 
#accent colors
YELLOW="136"
ORANGE="166"
RED="166"
MAGENTA="163"
VIOLET="62"
BLUE="32"
CYAN="36"
GREEN="100"
 
WHITE="255"
GMAIL_RED="196"
 
# Format: segment_name background_color foreground_color [non_default_separator]
 
if [ -z $TMUX_POWERLINE_LEFT_STATUS_SEGMENTS ]; then
    TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
        "tmux_session_info ${BASE03} ${YELLOW}" \
        #"hostname ${BASE03} ${YELLOW}" \
        #"ifstat 30 255" \
        #"ifstat_sys 30 255" \
        "lan_ip ${BASE02} ${GREEN} ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}" \
        "wan_ip ${BASE02} ${BLUE}" \
        #"vcs_branch ${BASE03} ${MAGENTA}" \
        #"vcs_compare 60 255" \
        #"vcs_staged 64 255" \
        #"vcs_modified 9 255" \
        #"vcs_others 245 0" \
    )
fi
 
if [ -z $TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS ]; then
    TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
        #"earthquake 3 0" \
        # "pwd 89 211" \
        #"mailcount ${WHITE} ${GMAIL_RED}" \
        #"now_playing 234 37" \
        #"cpu 240 136" \
        "load ${BASE02} ${BLUE}" \
        #"tmux_mem_cpu_load 234 136" \
        "battery ${BASE02} ${GREEN}" \
        #"weather ${BASE3} ${CYAN}" \
        #"xkb_layout 125 117" \
        "date_day ${BASE03} ${YELLOW}" \
        "date ${BASE03} ${YELLOW} ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
        "time ${BASE03} ${YELLOW} ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
        "utc_time 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
    )
fi

