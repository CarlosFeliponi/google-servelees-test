A demo está pronta e segue o slide 9 do seu roteiro. Rodei a função no meu computador e ela respondeu "Olá, Professor!" e "Olá, turma!". A publicação no Google Cloud eu não testei, porque o gcloud não está instalado aqui. Esse passo você faz no ensaio.

O que criei em demo/

┌───────────────────┬───────────────────────────────────────────────────────────────────────────────────────────┐
│      Arquivo      │                                      Para que serve                                       │
├───────────────────┼───────────────────────────────────────────────────────────────────────────────────────────┤
│ main.py           │ A função de 5 linhas do roteiro                                                           │
├───────────────────┼───────────────────────────────────────────────────────────────────────────────────────────┤
│ 1-publicar.sh     │ Liga os serviços necessários do Google, publica a função e mostra a URL                   │
├───────────────────┼───────────────────────────────────────────────────────────────────────────────────────────┤
│ 2-black-friday.sh │ Simula a Black Friday: 50 acessos ao mesmo tempo durante 2 minutos                        │
├───────────────────┼───────────────────────────────────────────────────────────────────────────────────────────┤
│ 3-apagar.sh       │ Apaga a função depois do seminário                                                        │
├───────────────────┼───────────────────────────────────────────────────────────────────────────────────────────┤
│ PASSO-A-PASSO.md  │ O guia completo, com uma tabela "fala do roteiro → o que fazer" e o que fazer se der erro │
└───────────────────┴───────────────────────────────────────────────────────────────────────────────────────────┘

Também criei o demo.zip, para enviar ao Cloud Shell.

Como fazer

Tudo roda no Cloud Shell, o terminal do Google Cloud que abre no navegador. Você não precisa instalar nada.

1. Crie um projeto no console do Google Cloud com o faturamento ativado. O crédito grátis serve, e a demo cust
2. Abra o Cloud Shell, envie o demo.zip e rode:                                                                                                                                                                                                          unzip demo.zip && cd demo
gcloud config set project SEU-PROJETO
./1-publicar.sh
3. Na hora da apresentação, mostre o main.py, abra a URL com ?nome=Professor, rode ./2-black-friday.sh e mostre o gráfico em Cloud Run → ola → Métricas → Contagem de instâncias.
                                                                                                                                                                                                                                                         Atenção ao gráfico

O gráfico de instâncias demora de 1 a 3 minutos para atualizar. Como a demo tem só 2 minutos, ele pode aparecer vazio na hora. Para evitar isso, rode ./2-black-friday.sh uns 5 a 10 minutos antes de começar. O pico já vai estar no gráfico, e na hora você roda de novo só para mostrar a carga acontecendo.

O gráfico deve mostrar bastante instâncias porque, por padrão, cada instância de uma function atende 1 acesso por vez. Com 50 acessos simultâneos, o Google liga dezenas delas, e a subida fica bem visível.

Também recomendo gravar a tela no ensaio, como o próprio roteiro sugere no plano B, para o caso de a internet da sala falhar.
