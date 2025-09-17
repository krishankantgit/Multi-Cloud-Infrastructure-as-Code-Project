const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/html' });
  res.end('<h1>Web service is up</h1>');
});

const port = process.env.PORT || 3000;
server.listen(port, () => console.log(`WEB listening on ${port}`));


