pog.pog {
  # Required
  name = "tool-name"; # Name of your CLI tool
  script = ''
    echo "hello, world!"
  ''; # Bash script or function that uses helpers

  # Optional
  version = "0.0.0"; # Version of your tool
  description = "..."; # Tool description
  flags = [ ]; # List of flag definitions
  arguments = [ ]; # Positional arguments
  argumentCompletion = "files"; # Completion for positional args
  runtimeInputs = [ ]; # Runtime dependencies
  bashBible = false; # Include bash-bible helpers
  beforeExit = ""; # Code to run before exit
  strict = false; # Enable strict bash mode
  flagPadding = 20; # Padding for help text
  showDefaultFlags = false; # Show built-in flags in usage
  shortDefaultFlags = true; # Enable short versions of default flags}
}
