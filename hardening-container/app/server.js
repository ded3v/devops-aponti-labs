const http = require('node:http');
const mysql = require('mysql2/promise');

// Sem fallback de senha: a aplicação exige a configuração do ambiente.
for (const key of ['DB_HOST', 'DB_USER', 'DB_PASSWORD', 'DB_NAME']) {
  if (!process.env[key]) throw new Error(`Variável obrigatória ausente: ${key}`);
}
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: 3306,
  connectionLimit: 3,
  connectTimeout: 3000,
  waitForConnections: false
});

// A mensagem original foi mantida; agora também existe um servidor HTTP.
const server = http.createServer(async (req, res) => {
  res.setHeader('Content-Type', 'application/json; charset=utf-8');
  res.setHeader('X-Content-Type-Options', 'nosniff');
  res.setHeader('Cache-Control', 'no-store');
  if (req.method !== 'GET') {
    res.writeHead(405, { Allow: 'GET' });
    return res.end(JSON.stringify({ erro: 'Método não permitido' }));
  }
  if (req.url === '/' || req.url === '/health') {
    return res.end(JSON.stringify(req.url === '/' ? { mensagem: 'Olá mundo!' } : { status: 'ok' }));
  }
  if (req.url === '/ready') {
    try {
      await pool.query({ sql: 'SELECT 1', timeout: 3000 });
      return res.end(JSON.stringify({ status: 'ok', banco: 'conectado' }));
    } catch {
      // Erros de conexão e credenciais não são enviados ao cliente.
      res.writeHead(503);
      return res.end(JSON.stringify({ status: 'indisponível' }));
    }
  }
  res.writeHead(404);
  res.end(JSON.stringify({ erro: 'Rota não encontrada' }));
});
server.requestTimeout = 5000;
server.headersTimeout = 5000;
server.listen(3000, '0.0.0.0', () => console.log('Olá mundo! Servidor ativo na porta 3000.'));
for (const signal of ['SIGTERM', 'SIGINT']) {
  process.once(signal, () => {
    const timeout = setTimeout(() => process.exit(1), 5000);
    timeout.unref();
    server.close(async () => {
      await pool.end();
      clearTimeout(timeout);
      process.exit(0);
    });
  });
}
