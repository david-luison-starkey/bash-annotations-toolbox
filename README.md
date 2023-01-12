# bash-annotations-toolbox

# Introduction
Collection of utility annotations using the bash-annotations project.

# Usage
Clone https://github.com/david-luison-starkey/bash-annotations to the desired location and then `source` `bash-annotations.bash`.

An annotation script can then be sourced. `bash-annotations-toolbox` scripts manage their own dependencies (once `bash-annotations.bash` is sourced, as they utilise the `import()` function from that script).