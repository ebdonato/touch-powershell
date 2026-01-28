# PowerShell TouchCmd

A PowerShell implementation of the Unix `touch` command for Windows. This module provides the familiar `touch` functionality to PowerShell users who want to create new files or update file timestamps.

## Features

- **Create files**: Quickly create new empty files
- **Update timestamps**: Update the last write time of existing files to the current date and time
- **Pipeline support**: Accept file paths from the pipeline
- **Cross-platform**: Works with PowerShell on Windows, and compatible with PowerShell Core

## Installation

### From PowerShell Gallery

```powershell
Install-Module -Name TouchCmd -Scope CurrentUser
```

### Manual Installation

1. Clone or download this repository
2. Copy the module folder to your PowerShell modules directory:
   - Windows: `$PROFILE\..\Modules\TouchCmd\`
   - Or place in any directory in your `$PSModulePath`
3. Import the module:

   ```powershell
   Import-Module TouchCmd
   ```

## Usage

### Create a new file

```powershell
touch "C:\path\to\newfile.txt"
```

### Update a file's timestamp

```powershell
touch "C:\path\to\existingfile.txt"
```

### Using with the pipeline

```powershell
"file1.txt", "file2.txt", "file3.txt" | touch
```

### Create multiple files at once

```powershell
foreach ($file in @("test1.txt", "test2.txt", "test3.txt")) {
    touch $file
}
```

## Parameters

### Path (Required)

Specifies the path of the file to create or touch. Accepts values from the pipeline.

```powershell
touch -Path "C:\path\to\file.txt"
```

## Requirements

- PowerShell 3.0 or later
- Windows PowerShell or PowerShell Core

## Examples

```powershell
# Create a new file in the current directory
touch "myfile.txt"

# Update the timestamp of an existing file
touch "C:\Users\YourName\Documents\report.docx"

# Create files using pipeline
@("file1.txt", "file2.txt") | touch

# Create a file with a relative path
touch ".\output\results.txt"
```

## How It Works

The `touch` function:

1. Checks if the file exists using `Test-Path`
2. If the file exists, updates its `LastWriteTime` property to the current date and time
3. If the file doesn't exist, creates a new empty file using `New-Item`

## Contributing

Contributions are welcome! Feel free to submit issues or pull requests to improve this module.

## License

This module is based on the Unix `touch` command concept. Original PowerShell implementation adapted from [Cassidy Williams' blog post](https://cassidoo.co/post/touch-on-ps/?ref=dailydev).

## Author

- Eduardo DONATO

## Support

For issues, questions, or suggestions, please open an issue on the project repository.
