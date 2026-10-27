// Opcional: execute com um administrador para criar a role da aplicacao.
// Nao atribui roles nem altera usuarios automaticamente.
(() => {
    const target = db.getSiblingDB("momento");
    const role = "momento_auditoria";
    if (target.getRole(role)) {
        print("Role existente: revise suas permissoes antes de atribuir a aplicacao.");
        return;
    }
    target.createRole({
        role,
        privileges: [{resource: {db: "momento", collection: "log"}, actions: ["find", "insert"]}],
        roles: []
    });
})();
