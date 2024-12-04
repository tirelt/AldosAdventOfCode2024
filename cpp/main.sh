#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <compile|run> <name> <day> <task>"
    exit 1
fi

# Assign arguments to variables
command=$1
name=$2
day=$3
task=$4

# Format the day to have a leading zero if necessary
if [ "$day" -lt 10 ]; then
    day_formatted=$(printf "day%02d" $day)
else
    day_formatted="day$day"
fi

# Construct the file paths
file_path="./${day_formatted}/${name}/${task}.cpp"
output_dir="../build/cpp/${day_formatted}/${name}"
executable_path="${output_dir}/${task}"

case $command in
    compile)
        # Check if the file exists
        if [ ! -f "$file_path" ]; then
            echo "Error: File '$file_path' not found!"
            exit 1
        fi

        # Create the output directory if it doesn't exist
        mkdir -p "$output_dir"

        # Compile the C++ file
        # g++ "$file_path" -o "$executable_path"
        g++ -std=c++11 "$file_path" -o "$executable_path"

        # Check if the compilation was successful
        if [ $? -eq 0 ]; then
            echo "Compilation successful! Executable created: ${executable_path}"
        else
            echo "Compilation failed!"
            exit 1
        fi
        ;;
    run)
        # Check if the executable exists
        if [ ! -f "$executable_path" ]; then
            echo "Error: Executable '$executable_path' not found! Please compile first."
            exit 1
        fi

        # Run the executable
        "$executable_path"
        ;;
    *)
        echo "Invalid command. Use 'compile' or 'run'."
        exit 1
        ;;
esac
