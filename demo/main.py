import functions_framework

@functions_framework.http
def ola(request):
    nome = request.args.get("nome", "turma")
    return f"Olá, {nome}!"
