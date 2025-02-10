const express = require('express');
const cors = require('cors');
const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');
const app = express();
const port = 3000;

app.use(cors()); // Enable CORS for all routes

app.get('/gatherData', (req, res) => {
    exec(`osascript -e 'display alert "Alert title" message "Your message text line here."'`, (error, stdout, stderr) => {
        if (error) {
            console.error(`exec error: ${error}`);
            return res.status(500).send('Error executing command');
        }
        res.send('Command executed successfully');
    });
});

app.use(express.static('public'));

app.get('/playbooks', (req, res) => {
    const playbooksDir = '/Users/dalescott/ansible-setup/playbooks';
    fs.readdir(playbooksDir, (err, files) => {
        if (err) {
            console.error(`Error reading directory: ${err}`);
            return res.status(500).send('Error reading directory');
        }
        const playbooks = files.map(file => {
            const filePath = path.join(playbooksDir, file);
            const stats = fs.statSync(filePath);
            return {
                name: path.basename(file, path.extname(file)),
                lastModified: stats.mtime,
                filePath: filePath
            };
        });
        res.json(playbooks);
    });
});

app.get('/playbook/:name', (req, res) => {
    const playbooksDir = '/Users/dalescott/ansible-setup/playbooks';
    const filePath = path.join(playbooksDir, req.params.name + '.yml');
    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error(`Error reading file: ${err}`);
            return res.status(500).send('Error reading file');
        }
        res.send(data);
    });
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
});