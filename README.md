PXjodel Package
===============

LaTeX: To help change metrics of the fonts of japanese-otf package

This package changes the setup of the japanese-otf package, so that the
TFMs for direct input are all replaced by new ones with prefixed names;
for exmaple, `nmlminr-h` will be replaced by `foo--nmlminr-h`, where
`foo` is the prefix specified by the user.

This function will assist the users who want to use japamese-otf package
together with tailored TFMs of Japanese fonts.

Note: The name “jodel” stands for “Japanese Otf DELuxe” (and “deluxe”
is a package option of japanese-otf) and is not at all related to yodel
singing (although some sense of word-play is intended).

Note: The “jodel” part of the package name stands for “**j**apanese-**o**tf
**del**uxe”. Here “deluxe” is the name of japanese-otf’s option for
employing multi-weight Japanese font families. This option is probably the
most likely reason for using japanese-otf. So this package is really about
japanese-otf’s “deluxe” option, hence the name. It is not related to
yodel singing, although some sense of word-play is intended.


### System requirement

  * TeX format: LaTeX.
  * TeX engine: pTeX / upTeX (including its derivatives).
  * DVI drivers: Anything that supports JFMs and VFs.
  * Dependent packages:
      - japanese-otf
      - ifptex
      - xkeyval

### Installation

  - `*.sty`     → $TEXMF/tex/platex/pxjodel/
  - `tfm/*.tfm` → $TEXMF/fonts/tfm/public/pxjodel/
  - `vf/*.vf`   → $TEXMF/fonts/vf/public/pxjodel/

### License

This package is distributed under the MIT License.


The pxjodel Package ― main
---------------------------

Note: The manual [pxjodel.pdf] (in Japanese) describes how to utilize this
package to customize the metrics of the fonts of japanese-otf package.

### Package Loading

    \usepackage[<option>,...]{pxjodel}

Available options are:

  * `prefix=<string>`: Specifies the prefix for new TFM names, actually
    the prefix `<string>--` will be prepended to names; `prefix=foo` will
    replace `nmlminr-h` with `foo--nmlminr-h`.
  * All other options are passed to japanese-otf. Note that if you use
    this mechanism, you must not load japanese-otf before this package.

When this package is loaded, japanese-otf will be automatically loaded
unless it is already loaded. Once the package is loaded, the NFSS settings
for the fonts of japanese-otf will be redeclared.

### Usage

For present, this package has no public commands. All the settings are
done through the package option.


Revision History
----------------

  * Version 0.3  〈2020/05/04〉
      - Add VFs of 'jodhminrn' family.
  * Version 0.2a 〈2019/02/12〉
      - Remove unnecessaty files.
  * Version 0.2  〈2019/02/02〉
      - The first public version.

--------------------
Takayuki YATO (aka. "ZR")  
https://github.com/zr-tex8r
