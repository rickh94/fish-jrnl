# Always provide completions for command line utilities.
#

set -g __jrnl_tags (jrnl --tags |awk '{print $1}')

function __jrnl_using_output
  set -l cmd (commandline -opc)
  contains -- "--export" $cmd
  and return 0
  return 1
end

# do not complete files
complete -c jrnl -f

# complete tags at all times
complete -c jrnl -a "$__jrnl_tags"

# optional switches
complete -c jrnl -f -s h -l help -d "Show help message and exit"
complete -c jrnl -f -s v -l version -d "Prints version information and exits"
complete -c jrnl -f -o ls -d "Displays accessible journals"
complete -c jrnl -f -s d -l debug -d "execute in debug mode"

# reading switches
complete -c jrnl -o from -x -d "View entries after this date"
complete -c jrnl -o to -o until -x -d "View entries before this date"
complete -c jrnl -o on -x -d "View entries on this date"
complete -c jrnl -o and -d "Filter by tags using AND (default: OR)"
complete -c jrnl -o starred -d "Shows only starred entries"
complete -c jrnl -s n -x -d "Shows the last n entries"


# export / import
complete -c jrnl -l short -d "Show only titles or line containing the search tags"
complete -c jrnl -l tags -d "Returns a list of all tags and number of occurences"
complete -c jrnl -l export -x -d "Export your journal." -a "json markdown text"
complete -c jrnl -n "__jrnl_using_output" -s o -r -d "Specifies file/directory for output when using --export (optional)"
complete -c jrnl -l export -d "Encrypts your existing journal with a new password"
complete -c jrnl -l decrypt -d "Decrypts your journal and stores it in plain text"
complete -c jrnl -l edit -d "Edit selected entries in $VISUAL"
