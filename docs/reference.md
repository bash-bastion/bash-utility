## Index

* [utility.fprint_error()](#utilityfprint_error)
* [utility.fprint_warn()](#utilityfprint_warn)
* [utility.fprint_info()](#utilityfprint_info)
* [utility.find_parent_file()](#utilityfind_parent_file)
* [utility.find_parent_dir()](#utilityfind_parent_dir)
* [utility.should_print_color_stdout()](#utilityshould_print_color_stdout)
* [utility.should_print_color_stderr()](#utilityshould_print_color_stderr)
* [utility.get_package_info()](#utilityget_package_info)
* [utility.get_semver()](#utilityget_semver)

### utility.fprint_error()

Prints a formatted error message

#### Arguments

* **$1** (name): of package
* **$2** (message):

### utility.fprint_warn()

Prints a formated warning message

#### Arguments

* **$1** (name): of package
* **$2** (message):

### utility.fprint_info()

Prints a formated log message

#### Arguments

* **$1** (name): of package
* **$2** (message):

### utility.find_parent_file()

Finds a parent file

#### Arguments

* **$1** (File): name

### utility.find_parent_dir()

Finds a parent directory

### utility.should_print_color_stdout()

Determine if color should be printed to standard output

_Function has no arguments._

### utility.should_print_color_stderr()

Determine if color should be printed to standard error

_Function has no arguments._

### utility.get_package_info()

Gets information from a particular package. If the key does not exist, then the value
is an empty string

#### Arguments

* **$1** (string): The `$BASALT_PACKAGE_DIR` of the caller

#### Variables set

* **directory** (string): The full path to the directory

### utility.get_semver()

#### Variables set

* **REPLY[major]** (string): Major number
* **REPLY[minor]** (string): Minor number
* **REPLY[patch]** (string): Patch number
* **REPLY[prerelease]** (string): Prerelease number
* **REPLY[buildmetadata]** (string): Build metadata

