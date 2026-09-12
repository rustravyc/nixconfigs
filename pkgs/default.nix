{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      myDwm = prev.dwm.overrideAttrs (oldAttrs: {
        src = prev.fetchFromGitHub {
          owner = "rustravyc";
          repo = "dwm";
          rev = "main";
          hash = "sha256-sjiwiukygyrgnTDorpIf2+yJjhSJdWp71BYKeT/ZLQs=";
        };
        nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ (with prev; [ pkg-config gnumake gcc ]);
        buildInputs = (oldAttrs.buildInputs or [ ]) ++ (with prev; [ libx11 libxinerama libxft fontconfig ]);
        preBuild = "make clean";
        makeFlags = [ "PREFIX=$(out)" ];
      });

      mySt = prev.st.overrideAttrs (oldAttrs: {
        src = prev.fetchFromGitHub {
          owner = "rustravyc";
          repo = "st";
          rev = "main";
          hash = "sha256-+qTOMIVkjoL05nzjxUFPocRkMknpr3BJ/PQuHwkmlpw=";
        };
        nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ (with prev; [ pkg-config gnumake gcc ncurses ]);
        buildInputs = (oldAttrs.buildInputs or [ ]) ++ (with prev; [ libx11 libxft fontconfig ]);
        preBuild = "make clean";
        makeFlags = [ "PREFIX=$(out)" ];
      });

      mySlstatus = prev.slstatus.overrideAttrs (oldAttrs: {
        src = prev.fetchFromGitHub {
          owner = "rustravyc";
          repo = "slstatus";
          rev = "main";
          hash = "sha256-IMyqSABzo6AxWX1DQGx2QOEi78L0H8qV4E2ImDZ8PQ8=";
        };
        nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ (with prev; [ pkg-config gnumake gcc ]);
        buildInputs = (oldAttrs.buildInputs or [ ]) ++ (with prev; [ libx11 ]);
        preBuild = "make clean";
        makeFlags = [ "PREFIX=$(out)" ];
      });
    })
  ];
}
