const express = require('express');
const { exec } = require('child_process');
const app = express();
const port = 3000;

app.get('/gatherData', (req, res) => {
    exec(`osascript -e 'display alert "Alert title" message "Your message text line here."'`, (error, stdout, stderr) => {
        if (error) {
            console.error(`exec error: ${error}`);
            return res.status(500).send('Error executing command');
        }
        res.send('Command executed successfully');
    });
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
});