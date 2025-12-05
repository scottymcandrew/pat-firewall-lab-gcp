#!/bin/bash
# Blue Web Server startup script

set -e

# Create the web content directory
mkdir -p /var/www/html

# Create a blue banner HTML page
cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Blue Server</title>
    <style>
        body {
            background-color: #0066cc;
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
        <h1>BLUE SERVER</h1>
        <p>10.1.1.3 - Blue Subnet</p>
        <p>You reached this via PAT port 8081</p>
    </div>
</body>
</html>
EOF

# Start a simple Python HTTP server on port 80
cd /var/www/html
nohup python3 -m http.server 80 > /var/log/webserver.log 2>&1 &

echo "Blue web server started on port 80"
