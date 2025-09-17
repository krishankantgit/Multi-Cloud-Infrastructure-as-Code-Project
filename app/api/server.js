const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({ service: 'api', status: 'ok' }));
});

const port = process.env.PORT || 8080;
server.listen(port, () => console.log(`API listening on ${port}`));


