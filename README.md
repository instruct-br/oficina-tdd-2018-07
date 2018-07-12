# Oficina de TDD

Nesta atividade vamos usar uma variação do [Kata](https://en.wikipedia.org/wiki/Kata_(programming)) da Gilded Rose
para treinar desenvolvimento orientado à testes.

## Descrição do Problema (Parte 1)

Olá e seja bem vindo(a) à equipe Gilded Rose. Como você sabe, somos uma pequena pousada
com uma localização privilegiada em uma cidade proeminente, administrada por um gerente simpático
chamado Allison. Nós compramos e vendemos os melhores produtos.
Infelizmente, nossos produtos perdem a qualidade conforme se aproximam da data de validade. 
Nós precisamos um sistema que atualize o estoque.

O sistema deve atender as seguintes regras: 

- Todo item tem um valor `days_remaining` que representa o número de dias até a data de validade
- Todo item tem um valor `quality` para indicar a qualidade do item
- No final de cada dia, os dois valores devem ser reduzidos em 1

Muito simples, certo? Agora começa a ficar interessante:

  - Quando passar a data de validade (`days_remaining <= 0`) a qualidade do item cai 2 vezes mais rápido (`quality -= 2`)
  - A qualidade de um item nunca é negativa
  - O item de nome "Aged Brie" aumenta de qualidade conforme os dias passam (e sua qualidade sobe duas vezes mais rápido depois da validade!)
  - A qualidade de um item nunca é maior que 50
  - O item de nome "Sulfuras, Hand of Ragnaros" é lendário, então nunca perde qualidade ou se aproxima do vencimento (`days_remaining` constante).
    É também o único item com qualidade maior que 50, fixada em 80
  - O item de nome "Backstage passes to a TAKFAL80ETC concert", assim como o "Aged Brie", aumenta sua qualidade com o tempo.
    Sua qualidade aumenta em 2 quando falta 10 dias ou menos para o vencimento e aumenta em 3 quando falta 5 dias ou menos,
    mas a qualidade cai pra 0 depois do dia do show (`days_remaining <= 0`)

### Regras para a implementação

- Não pode usar variável temporária/auxiliar ou criar outros métodos
- Usar apenas if/else
- Não adicione comentários
- Mantenha todo o código dentro do método `tick`

### Validando a solução

Atualize a imagem do container e rode os testes:

```bash
docker build -t gilded_rose .
docker run gilded_rose
```

## Descrição do Problema (Parte 2)

Recentemente assinamos um contrato com um fornecedor de bolos conjurados.
Isso requer uma atualização do nosso sistema:

- O item de nome "Conjured Mana Cake" perde qualidade duas vezes mais rápido que os outros (note que perde 4 de qualidade após o vencimento)

### Regras pra implementação

- Dessa vez você deve implementar os testes: veja os últimos métodos do arquivo `gilded_rose_test`,
  remova os `skip`s e implemente as validações necessárias para o sistema suportar o novo requisito
- Faça as alterações necessárias no código do método `tick`

## Refatorando (Parte 1)

Vamos agora usar a base de testes para melhorar a legibilidade do código.

Crie uma estrutura de condicionais no início do método `tick` que lista os casos especiais, mas ainda não faz nada:

```ruby
def tick
  case @name
  when 'Aged Brie'
  when 'Sulfuras, Hand of Ragnaros'
  when 'Backstage passes to a TAKFAL80ETC concert'
  when 'Conjured Mana Cake'
  else
  end

  # Restante do método
end
```

Rode os testes para garantir que nada quebrou.

Agora adicione um método `default_tick` que ainda não faz nada, faça com que o `else` do "switch/case" acima retorne o valor de `default_tick`:

```ruby
def tick
  case @name
  when 'Aged Brie'
  when 'Sulfuras, Hand of Ragnaros'
  when 'Backstage passes to a TAKFAL80ETC concert'
  when 'Conjured Mana Cake'
  else
    return default_tick
  end

  # Restante do método
end

def default_tick
end
```

Rode os testes e verifique que pelo menos os testes referentes ao caso comum falham.

Agora implemente o `default_tick` para fazer os testes passarem de novo.

Quando os testes voltarem a passar, sinta-se a vontade para refatorar o `default_tick`, rode os testes a cada passo para garantir que as coisas ainda funcionam.

## Refatorando (Parte 2)

Aplique a mesma técnica para tratar os casos especiais, crie um método para cada caso e retorne o valor deles nos condicionais.

Faça um método de cada vez, dê passos pequenos e rode os testes a cada passo para garantir que você está caminhando na direção correta.

Deixe os métodos isolados, não tente ainda encontrar semelhanças entre eles (mesmo que eles pareçam duplicados).

## Fim

Agora apague o restante do método `tick`, deixando somente o "case/when". Como o retorno em ruby é implícito, você também pode apagar os `return`s espalhados nesses condicionais.


## Referências/ver mais

Repositório com enunciado original em inglês e testes escritos em rspec:

- https://github.com/jimweirich/gilded_rose_kata

Palestra refatorando o kata passo a passo:

- https://www.youtube.com/watch?v=8bZh5LMaSmE

Repositório com implementação + testes (em minitest) com os passos de refatoração da palestra acima separado em pastas:

- https://github.com/simonneutert/gilded_rose_kata
