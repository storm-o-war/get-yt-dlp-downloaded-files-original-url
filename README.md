# Get the YouTube Video ID from a File Title

## AI warning
not an ai slop that u are going to read below, i wrote the texts and formatted them using ai
and also the codes credit goes to AI :/ sorry deepseek.com

## Running

```bash
./getFileNames.sh /path/to/the/folder
```

If you download lots of videos from YouTube, for example, using `yt-dlp`, you might want to re-download them with different options.

If the video ID is included in the file title, you can extract it using this script.

For example:

`video something [12345678910]`

The string inside the [] is the video ID.

The script extracts the file names and saves them to matched_11.txt.

If a file title contains multiple sets of [], the script only selects the one containing 11 characters.

All other extracted strings, including those containing 11 characters, are saved to extracted_texts.txt


## Install / Run

```bash
git clone (this url)              # Clone the repository
cd (repository-folder)            # Enter the repository
chmod +x getFileNames.sh          # Make the script executable
./getFileNames.sh /path/to/folder # Run the script on the target folder
```
