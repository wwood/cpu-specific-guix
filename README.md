# A CPU-optimised GNU Guix package builder

This code base allows one to build versions of [GNU Guix](https://www.gnu.org/software/guix) packages that have been optimised for a particular CPU architecture.

It works by configuring GCC with the `--with-arch=` flag, so that code compiled with GCC is optimised to the given architecture.

To build an optimised package first download this repository, and then add it to both the `GUILE_LOAD_PATH` and `GUIX_PACKAGE_PATH` environment variables. For instance, in bash:
```bash
export GUILE_LOAD_PATH=/path/to/cpu-specific-guix:$GUILE_LOAD_PATH
export GUIX_PACKAGE_PATH=/path/to/cpu-specific-guix:$GUIX_PACKAGE_PATH
```
and then build the optimised package. Here, the bioinformatics package [DIAMOND](https://github.com/bbuchfink/diamond) is built optimised for the x86_64 sandybridge architecture:
```
guix build -e '(begin (use-modules (cpu-specific-guix) (gnu packages bioinformatics)) (cpu-specific-package diamond "sandybridge"))'
```

# License
This code is released under GPL3+. See LICENSE.txt.
