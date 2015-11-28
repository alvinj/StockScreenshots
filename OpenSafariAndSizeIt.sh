#!/bin/sh

osascript <<EOF
tell application "Safari" to activate
tell application "Safari"
	set bounds of front window to {300, 30, 1600, 1100}
end tell
EOF

