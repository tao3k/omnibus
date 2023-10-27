{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (texlive.combine {
      inherit (texlive)
        collection-plaingeneric
        collection-latexextra
        collection-fontsrecommended
        collection-pictures
        collection-bibtexextra
        collection-mathscience
        collection-langgerman
        scheme-basic
        xetex
        cjk
        ctex
        xecjk
        dvipng
        fontspec
        euenc
        latexmk
        # elegantpaper

        fontawesome5
        roboto
        lato
        sourcesanspro
      ;
    })
  ];
}
