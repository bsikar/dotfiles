if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

# opam configuration
source /home/ubuntu/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
