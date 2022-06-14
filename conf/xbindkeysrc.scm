;   This configuration is guile based.
;;   http://www.gnu.org/software/guile/guile.html


;; up sidebutton Click
(define (first-binding)
    "First binding"
    (xbindkey-function '("b:9") b9-second-binding)
    (xbindkey '("b:8") "qdbus org.kde.KWin /KWin org.kde.KWin.nextDesktop")
)

(define (reset-first-binding)
    "reset first binding"
    (ungrab-all-keys)
    (remove-all-keys)
)

(define (b9-second-binding)
    "Button Extra Functions"
    (reset-first-binding)

    ;; First Key Down + Second Key = show desktops
    (xbindkey-function '("b:8")
        (lambda ()
            (reset-first-binding)
            (run-command "qdbus org.kde.kglobalaccel /component/kwin invokeShortcut ShowDesktopGrid")
            (run-command "killall xbindkeys; xbindkeys -fg ${HOME}/.dotfiles/conf/xbindkeysrc.scm -n -v")
        )
    )

    ;; First Key Up = Release
    (xbindkey-function '(release "b:9")
        (lambda ()
            (reset-first-binding)
            (run-command "qdbus org.kde.KWin /KWin org.kde.KWin.previousDesktop")
            (run-command "killall xbindkeys; xbindkeys -fg ${HOME}/.dotfiles/conf/xbindkeysrc.scm -n -v")
        )
    )
)

(first-binding)
