#!/bin/bash
# Red Web Server startup script

set -e

# Create the web content directory
mkdir -p /var/www/html

# Create a red banner HTML page
cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Red Server</title>
    <style>
        body {
            background-color: #cc0000;
            color: white;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .banner {
            text-align: center;
            padding: 50px;
            border: 5px solid white;
            border-radius: 20px;
        }
        h1 {
            font-size: 4em;
            margin: 0;
        }
        p {
            font-size: 1.5em;
        }
    </style>
</head>
<body>
    <div class="banner">
        <h1>RED SERVER</h1>
        <p>10.1.2.3 - Red Subnet</p>
        <p>You reached this via PAT port 8082</p>
    </div>
</body>
</html>
EOF

# Start a simple Python HTTP server on port 80
cd /var/www/html
nohup python3 -m http.server 80 > /var/log/webserver.log 2>&1 &

echo "Red web server started on port 80"
