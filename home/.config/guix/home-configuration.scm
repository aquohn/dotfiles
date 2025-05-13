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
             (gnu home services xdg)
             (gnu home services syncthing)
             (gnu home services sound)
             (gnu home services fontutils))


(define user-config
  (list
    (let* ((fc-alias
             (lambda (family fonts)
               `(alias (@ (binding strong))
                       (family ,family)
                       (prefer ,@fonts))))

           (fc-family-cjk
             (let* ((cjk-map
                      '(("ja" . " JP") ("ko" . " KR") ("zh" . " SC") ("zh-hans" . " SC")
                                       ("zh-hant" . " TC") ("zh-cn" . " SC") ("zh-tw" . " TC")))
                    (cjk-target (lambda (family fontname mapping)
                                  `(match (@ (target pattern))
                                          (test (@ (name lang) (compare contains)) (string ,(car mapping)))
                                          (test (@ (name family) (compare eq)) (string ,family))
                                          (edit (@ (name family) (mode append) (binding strong)) (string ,(string-append fontname " CJK" (cdr mapping))))))))
               (lambda (family fontname)
                 (append `((match (@ (target pattern))
                                  (test (@ (name family) (compare eq)) (string ,family))
                                  (edit (@ (name family) (mode append) (binding strong)) (string ,(string-append fontname " SC")))))
                         (map (lambda (m) (cjk-target family fontname m)) cjk-map))))))
      (simple-service 'additional-fonts-service
                      home-fontconfig-service-type
                      (append
                        (list (fc-alias "serif" '((family "Noto Serif") (family "Latin Modern Roman")))
                              (fc-alias "sans-serif" '((family "Noto Sans") (family "Latin Modern Sans")))
                              (fc-alias "monospace" '((family "Noto Sans Mono") (family "Latin Modern Mono")))
                              (fc-alias "system-ui" '(sans-serif)))

                        (fc-family-cjk "serif" "Noto Serif")
                        (fc-family-cjk "sans-serif" "Noto Sans")
                        (fc-family-cjk "monospace" "Noto Sans Mono"))))

    (let* ((mimetypes-desktop-pairs
             (lambda (desktop mimetypes)
               (map (lambda (mt) `(,(string->symbol mt) . ,desktop)) (delete "" (string-split mimetypes #\;)))))
           (nsxiv-mimetypes "image/bmp;image/gif;image/jpeg;image/jpg;image/png;image/tiff;image/x-bmp;image/x-portable-anymap;image/x-portable-bitmap;image/x-portable-graymap;image/x-tga;image/x-xpixmap;image/webp;image/heic;image/svg+xml;application/postscript;image/jp2;image/jxl;image/avif;image/heif;")
           (zathura-pdf-mimetypes "application/pdf;application/oxps;application/epub+zip;application/x-fictionbook;")
           (nvim-mimetypes "text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;")
           (brave-mimetypes "x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/about;x-scheme-handler/unknown;"))
      (service home-xdg-mime-applications-service-type
               (home-xdg-mime-applications-configuration
                 (default
                   (append
                     (mimetypes-desktop-pairs 'nsxiv.desktop nsxiv-mimetypes)
                     (mimetypes-desktop-pairs 'org.pwmt.zathura-pdf-mupdf.desktop zathura-pdf-mimetypes)
                     (mimetypes-desktop-pairs 'brave-browser.desktop brave-mimetypes)))
                 (desktop-entries
                   (list

                     (xdg-desktop-entry
                       (file "poweroff")
                       (name "Power Off")
                       (type 'application)
                       (config '((exec . "loginctl poweroff"))))
                     (xdg-desktop-entry
                       (file "reboot")
                       (name "Reboot")
                       (type 'application)
                       (config '((exec . "loginctl reboot"))))

                     (xdg-desktop-entry
                       (file "vim-terminal")
                       (name "Open vim in $TERMINAL")
                       (type 'application)
                       (config '((exec . "sh -c \"$TERMINAL -e vim %F\"")
                                 (Terminal . "yes")
                                 (MimeType . ,nvim-mimetypes)
                                 (NoDisplay . "true")))))))))))


(define user-apps
  (list
    (service home-syncthing-service-type)))

(define user-sys
  (list
    (service home-dbus-service-type)
    (service home-pipewire-service-type)
    (simple-service 'additional-dbus-services home-dbus-service-type
                    (map specification->package (list "xdg-desktop-portal-wlr" "xdg-desktop-portal" "blueman")))))

(home-environment
  (services
    (append user-config
            user-apps
            user-sys ;; TODO only if using sway
            %base-home-services)))
