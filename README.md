# Pushbullet shell scripts
Send pushes from the command line.

<b>Pushnote</b>: send pushbullet notification to self. Get your pushbullet token from pushbullet.com/account and put it at the indicated place in the file. Then, in a shell, call <code>sh pushnote -t "Title of message" -m "Message contents"</code>

<b>Pushfile</b> send a file through pushbullet to self.<br/> Usage: <code>sh pushfile -f "Path to file" -n "Name of file (title)" -t "Filetype (i.e. "image/jpeg")"</code>
