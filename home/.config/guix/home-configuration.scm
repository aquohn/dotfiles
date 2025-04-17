;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
             (gnu home services desktop)
             (gnu home services syncthing)
             (gnu home services sound)
             (gnu home services fontutils))

(home-environment
  (services
    (append (list (service home-syncthing-service-type)
                  (service home-dbus-service-type)
                  (service home-pipewire-service-type)
                  (simple-service 'additional-fonts-service
                                  home-fontconfig-service-type
                                  (list '(alias
                                           (family "monospace")
                                           (prefer
                                             (family "Noto Sans Mono")))
                                        '(alias
                                           (family "sans-serif")
                                           (prefer
                                             (family "Noto Sans")))
                                        '(alias
                                           (family "serif")
                                           (prefer
                                             (family "Noto Sans Mono")))
                                        '(alias
                                           (family "system-ui")
                                           (prefer
                                             (family "Noto Sans")))))
                  (simple-service 'additional-dbus-services home-dbus-service-type (map specification->package (list "xdg-desktop-portal-wlr" "xdg-desktop-portal" "blueman")))
                  ) %base-home-services)))
