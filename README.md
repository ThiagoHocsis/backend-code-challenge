# Shortest Path code challenge

API utilizada para encontrar o menor caminho entre dois pontos em um grafo e calcular o custo mínimo de envio

## Como baixar o projeto

* No Terminal digite o comando ```git clone https://github.com/ThiagoHocsis/backend-code-challenge.git```

### Pré Requisitos

* Ruby versão 2.4.1

* Rails versão 5.2.3


### Instalação

* Após fazer o clone no projeto navegue até pasta do projeto e digite ```bundle install``` e em seguida ```rails db:create rails db:migrate```


## Como rodar os testes

* Dentro da pasta do projeto digite no terminal ```rspec spec --format documentation```


## Outras informações

* Ferramenta utilizada para realização dos requests na API - POSTMAN, disponivel para download em
https://www.getpostman.com/

* Como rodar o linter de code smells - Acesso o projeto pelo terminal e digite ```rubocop```

* Após rodar os testes é possivel verificar a cobertura de testes, para isso foi utilizada a gem Simplecov

## Considerações

O Objetivo do sistema é criar uma API que recebe dois pontos, que seriam duas cidades e uma distância que as separa, 
por exemplo cidade A e cidade B, distancia 5, esse pontos são armazenados no banco de dados.
Em um segundo momento uma requisição é feita para API com também dois pontos e uma peso, que seria o peso da encomenda a
ser enviada e obtem como retorno caso seja encontrada um valor de envio.
O calculo do menor caminho foi implementado utilizando o Algoritmo de Dijkstra que é um conhecido algoritmo para calcular o caminho mínimo entre dois
pontos em um grafo dirigito, ou não dirigido com arestas de peso não negativo,
criado pelo cientista da computação holandês Edsger Dijkstra em 1856, o algoritmo possui complexidade de O(m + n log n)
onde m é o número de arestas e n é o número de vértices.

## Exemplo de requisições e retorno.

Uma requisição válida.

/api/v1/points

```javascript
{
"point":{ 
   "startpoint":"B",
   "endpoint":"D",
   "distance":5
}	
}
```

Essa requisição cria no banco de dados um objeto do tipo Point com os atributos startpoint = B, endpoint = D e distance = 5


Uma Requisição para:
 
 /api/v1/cost?origin=A&destination=D&weight=2

Obtém como retorno:

Shipping price: R$ 0.30

Que a partir dos pontos dados usando o algoritmo de Dijkstra e a fórmula para cálculo do valor cost = distance * weight * 0.15,
obteve esse resultado.

 

