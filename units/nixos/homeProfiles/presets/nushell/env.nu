$env.PATH = (
    $env.PATH
    | split row (char esep)
    | prepend $"/etc/profiles/per-user/($env.USER)/bin"
    | prepend '/run/current-system/sw/bin/'
    | prepend '/opt/homebrew/bin'
)
