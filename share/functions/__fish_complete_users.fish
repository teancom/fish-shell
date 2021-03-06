# This should be used where you want user names with a description. Such as in an argument
# completion. If you just want a list of user names use __fish_print_users.
function __fish_complete_users --description "Print a list of local users, with the real user name as a description"
    if command -sq getent
        command getent passwd | cut -d : -f 1,5 | string replace -r ':' \t
    else if command -sq dscl
        # This is the "Directory Service command line utility" used on macOS in place of getent.
        command dscl . -list /Users RealName | string match -r -v '^_' | string replace -r ' {2,}' \t
    else if test -r /etc/passwd
        string match -v -r '^\s*#' </etc/passwd | cut -d : -f 1,5 | string replace ':' \t
    end
end
