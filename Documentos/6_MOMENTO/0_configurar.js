// Gerado por gerar_dados.py. Validacao estrita e indices.
(() => {
  const target = db.getSiblingDB("momento");
  const config = EJSON.parse(require("fs").readFileSync("configuracao.json", "utf8"));
  for (const entry of config) {
    const options = {validator: {$jsonSchema: entry.schema}, validationLevel: "strict", validationAction: "error"};
    if (target.getCollectionNames().includes(entry.nome)) {
      assert.commandWorked(target.runCommand({collMod: entry.nome, ...options}));
    } else {
      target.createCollection(entry.nome, options);
    }
    for (const [keys, options] of entry.indices) target.getCollection(entry.nome).createIndex(keys, options);
  }
})();
