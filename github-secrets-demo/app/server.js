const mensagem = process.env.MENSAGEM_SECRETA;

// O valor chega pelo ambiente, sem ficar escrito no código.
if (!mensagem) {
    console.error("MENSAGEM_SECRETA não foi configurada.");
    process.exit(1);
}

// Confirma o recebimento sem mostrar o segredo nem seu tamanho.
console.log("Secret recebido pela aplicação com sucesso.");

