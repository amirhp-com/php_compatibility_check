#!/bin/bash
: '
/*
 * @Author: Amirhossein Hosseinpour <https://amirhp.com>
 * @Version: 1.66.0
 * @Date Created: 2025/02/24 12:27:36
 * @Last modified by: amirhp-com <its@amirhp.com>
 * @Last modified time: 2025/02/24 14:21:43
 */
'
#!/bin/bash
export PATH="$HOME/.composer/vendor/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"

# Check if an argument is provided
if [[ $# -eq 0 ]]; then
  osascript -e "display notification \"No folder path provided.\" with title \"PHP Compatibility Check\" subtitle \"\" sound name \"frog\""
  exit 1
fi

# Function to print centered or left-aligned text with optional borders
print_centered() {
    local text="$1"
    local top_border="$2"
    local bottom_border="$3"
    local width=80  # Change this width as needed

    # Print top border if enabled
    if [[ "$top_border" == "true" ]]; then
        echo "+$(printf '%.0s-' $(seq 1 $width))+"
    fi

    # Check if text fits within the width
    if [ ${#text} -gt $((width - 4)) ]; then
        # If too long, print left-aligned
        printf "%-*s\n" $((width - 4)) "$text"
    else
        # Otherwise, center the text
        local padding=$(( (width - ${#text}) / 2 ))
        printf "|%*s%s%*s|\n" $padding "" "$text" $padding ""
    fi

    # Print bottom border if enabled
    if [[ "$bottom_border" == "true" ]]; then
        echo "+$(printf '%.0s-' $(seq 1 $width))+"
    fi
}

for folder in "$@"
do
    # Ensure system uses en_US locale
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8
    parent_folder_name=$(basename "$folder")

    # Prompt for PHP version with focus and default 7.1
    php_version=$(osascript -e '
    tell application "System Events"
        activate
        text returned of (display dialog "Enter PHP version to check compatibility:" default answer "7.1" with title "PHP Compatibility Check" buttons {"OK"} default button "OK")
    end tell')

    # Temporary report file in system temp folder
    # report_file="$(mktemp ~/tmp/PHP_Compatibility_Report.txt 2>/dev/null || echo ~/Documents/PHP_Compatibility_Report_$(date +%s).txt)"
    report_file="$(mktemp ~/tmp/PHP_Compatibility_Report.txt 2>/dev/null || echo ~/Documents/PHP_Compatibility_Report.txt)"
    # Ensure the report file gets overwritten
    : > "$report_file"

    php_command="/opt/homebrew/opt/php@7.3/bin/php"
    phpcs_command="/Users/$(whoami)/.composer/vendor/bin/phpcs"

    # Define base PHPCS command
    base_command="$php_command $phpcs_command --standard=PHPCompatibility --runtime-set testVersion $php_version- --extensions=php"

    # Start notification
    osascript -e "display notification \"Started for: $parent_folder_name\" with title \"⌛️ PHP Compatibility Check\" sound name \"frog\""

    echo "" >> "$report_file"
    # Call the function to print the header with borders
    print_centered "BLACKSWAN.DEV PHP COMPATIBILITY REPORT" true false >> "$report_file"
    print_centered "DEVELOPED BY AMIRHP.COM " false true >> "$report_file"
    print_centered "COMPATIBILITY WITH PHP $php_version" false false >> "$report_file"
    print_centered "FOLDER: $parent_folder_name " false true >> "$report_file"
    echo "" >> "$report_file"
    echo "" >> "$report_file"

    # Run PHPCS (Summary Output - Errors Only)
    print_centered "Summary Output [$(date +"%Y-%m-%d %H:%M:%S")]  " true true >> "$report_file"
    eval "$base_command --warning-severity=0 --error-severity=1 --report=summary \"$folder\"" >> "$report_file" 2>&1

    echo "" >> "$report_file"
    echo "" >> "$report_file"

    # Run PHPCS (Full Output)
    print_centered "Detailed Output [$(date +"%Y-%m-%d %H:%M:%S")] " true true >> "$report_file"
    eval "$base_command \"$folder\"" >> "$report_file" 2>&1

    # Display the final command for manual execution (trimmed)
    echo -e "\n\n🚀 Command Used (Run manually if needed):\n$(echo $base_command \"$folder\" | xargs)\n" >> "$report_file"
    print_centered "All Done: $(date +"%Y-%m-%d %H:%M:%S") " true true >> "$report_file"
    # Open the report
    open "$report_file"

    # Completion notification
    osascript -e "display notification \"PHPCS compatibility check process completed.\" with title \"✅ PHP Compatibility Check\" sound name \"frog\""
done