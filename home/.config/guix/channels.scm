;; (cons* (channel
(list (channel
        (name 'guix)
        (branch "master")
        (url "https://codeberg.org/guix/guix-mirror.git")
        (introduction
          (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
              "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
      (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix.git")
        (introduction
          (make-channel-introduction
            "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
            (openpgp-fingerprint
              "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
      (channel
        (name 'pantherx)
        (url "https://channels.pantherx.org/git/panther.git")
        (introduction
          (make-channel-introduction
            "54b4056ac571611892c743b65f4c47dc298c49da"
            (openpgp-fingerprint
              "A36A D41E ECC7 A871 1003  5D24 524F EB1A 9D33 C9CB"))))
      (channel
        (name 'guix-science)
        (url "https://codeberg.org/guix-science/guix-science.git")
        (introduction
          (make-channel-introduction
            "b1fe5aaff3ab48e798a4cce02f0212bc91f423dc"
            (openpgp-fingerprint
              "CA4F 8CF4 37D7 478F DA05  5FD4 4213 7701 1A37 8446")))))
;; %default-channels)
