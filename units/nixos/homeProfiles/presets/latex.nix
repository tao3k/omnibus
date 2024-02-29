# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

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

        minted
        fontawesome5
        roboto
        lato
        sourcesanspro
        ;
    })
  ];
}
