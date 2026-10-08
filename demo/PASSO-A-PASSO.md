# Demonstração: Cloud Run functions (slide 9)

Tudo roda no **Cloud Shell**, o terminal do Google Cloud no próprio navegador.
Você não precisa instalar nada no seu computador.

## Arquivos

| Arquivo | Para que serve |
|---|---|
| `main.py` | A função de 5 linhas que aparece no slide |
| `requirements.txt` | Diz ao Google qual biblioteca instalar |
| `1-publicar.sh` | Publica a função e mostra a URL |
| `2-black-friday.sh` | Simula a Black Friday (50 acessos ao mesmo tempo por 2 min) |
| `3-apagar.sh` | Apaga a função depois da apresentação |

---

## Parte 1: preparar (faça no dia anterior, leva ~10 min)

1. Entre em <https://console.cloud.google.com> e crie um projeto (ex.: `seminario-serverless`).
   O projeto precisa de **faturamento ativado**. O crédito grátis de US$ 300 serve, e esta demo custa centavos ou nada.
2. Clique no ícone **Ativar o Cloud Shell** (`>_`, no canto superior direito).
3. No Cloud Shell, menu **⋮ → Fazer upload** e envie o `demo.zip`. Depois rode:
   ```bash
   unzip demo.zip && cd demo
   gcloud config set project SEU-ID-DO-PROJETO
   ./1-publicar.sh
   ```
   Se o comando perguntar algo, responda `y`. Em 2 a 4 minutos ele mostra a URL.
4. Abra `URL?nome=Professor` no navegador. Deve aparecer **Olá, Professor!**
5. Faça um ensaio da carga: `./2-black-friday.sh`
6. Veja o gráfico: menu **Cloud Run → serviço `ola` → aba Métricas → "Contagem de instâncias de contêiner"**.
   Você deve ver o número de instâncias subir de 0 para várias dezenas.

## Parte 2: antes de começar a apresentação

Deixe abertas três abas do navegador e uma janela de código:

1. **`main.py`** aberto no editor (pode ser o editor do próprio Cloud Shell).
2. **A URL** da função com `?nome=Professor`.
3. **O Cloud Shell** já dentro da pasta `demo` (`cd demo`).
4. **O painel de Métricas** do serviço `ola`, mostrando a última **1 hora**.

## Parte 3: durante o slide 9 (2 min)

| Fala do roteiro | O que fazer |
|---|---|
| "São cinco linhas..." | Mostrar o `main.py` |
| "Isso está rodando na nuvem do Google agora." | Atualizar a aba da URL. Se quiser, troque o nome por alguém da turma |
| "Agora vou simular a Black Friday." | No Cloud Shell: `./2-black-friday.sh` |
| "Ninguém configurou isso..." | Ir para a aba de Métricas e apontar a subida das instâncias |

### ⚠️ Atenção: o gráfico tem atraso

O painel de métricas do Google demora **de 1 a 3 minutos** para mostrar os dados.
Para o gráfico não ficar vazio na hora H, faça assim:

- **Rode `./2-black-friday.sh` uns 5 a 10 minutos antes da apresentação.** O pico já vai estar no gráfico.
- Na hora, dispare a carga de novo (fica bonito ver o `hey` rodando) e mostre o pico que já está lá:
  *"Esse pico é de um teste que rodamos agora há pouco; o de agora aparece em instantes."*
- No fim, a carga mostra um resumo com o total de requisições por segundo. É um bom número para comentar.

Por que sobem tantas instâncias? Por padrão, cada instância de uma function atende
**1 requisição por vez**. Com 50 acessos simultâneos, o Google liga dezenas de instâncias.

## Plano B (sem internet)

Grave a tela durante o ensaio da Parte 1 (passos 4 a 6), por exemplo com a Barra de Jogos do
Windows (`Win + Alt + R`) ou o OBS. Se a internet falhar, passe o vídeo narrando o mesmo roteiro.

## Depois da apresentação

```bash
./3-apagar.sh
```

## Se der erro

| Erro | Solução |
|---|---|
| `Billing account ... not found` / pede faturamento | Ative o faturamento do projeto no console |
| `Permission denied` ao rodar `./1-publicar.sh` | Rode `chmod +x *.sh` |
| A URL responde `403 Forbidden` | A opção `--allow-unauthenticated` foi bloqueada. Use uma conta pessoal do Gmail, não a da faculdade |
| `go: command not found` no script de carga | Use o loop com curl: `seq 3000 \| xargs -P 50 -I{} curl -s -o /dev/null "$(cat .url)?nome=BlackFriday"` |
