# to be continued
# 改成tmux命令?
%if "#{==:#{window_panes}, 1}"
     # Sessions, window and panes are each numbered with a unique ID; session IDs are prefixed with a ‘$’, windows with a ‘@’, and panes with a ‘%’.  These
     # are unique and are unchanged for the life of the session, window or pane in the tmux server.  The pane ID is passed to the child process of the pane
     # in the TMUX_PANE environment variable.
     # pane %1 被kill了, 下一个pane的编号是2, 不会复用1
     # IDs may be displayed using the ‘session_id’, ‘window_id’, or ‘pane_id’ formats (see the FORMATS section) and
     # the display-message, list-sessions, list-windows or list-panes commands.


# tmux -t target-pane
     # target-pane (or src-pane or dst-pane) may be a pane ID or takes a similar form to target-window but with the optional addition of a period followed by
     # a pane index or pane ID, for example: ‘mysession:mywindow.1’.  If the pane index is omitted, the currently active pane in the specified window is
     # used.  The following special tokens are available for the pane index:
     #
     # Token                  Meaning
     # {last}            !    The last (previously active) pane
     # {next}            +    The next pane by number
     # {previous}        -    The previous pane by number
     # {top}                  The top pane
     # {bottom}               The bottom pane
     # {left}                 The leftmost pane
     # {right}                The rightmost pane
     # {top-left}             The top-left pane
     # {top-right}            The top-right pane
     # {bottom-left}          The bottom-left pane
     # {bottom-right}         The bottom-right pane
     # {up-of}                The pane above the active pane
     # {down-of}              The pane below the active pane
     # {left-of}              The pane to the left of the active pane
     # {right-of}             The pane to the right of the active pane
     #
     # The tokens ‘+’ and ‘-’ may be followed by an offset, for example:
     #
     #       select-window -t:+2
