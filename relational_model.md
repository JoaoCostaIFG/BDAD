# Modelo relational

## 1969 Edgar F. Codd - The Relational Model - simple and expressive - query

with high-level languages

## database = ser of named relations (or tables)

(numero atributos de tabela = aridade)

## tuple ou row tem value para cada atributo

numero de tuples e cardinalidade da relacao
cada atributo tem um tipo

## Schema = structura e dexcricao de relacoes na database. Nome, atributos

e tipo de cada atributo
Typicaly set up in advance

## Instance = contents of database at a certain point in time

## NULL value

special vale for unkown or undefined.
Be careful when querying relations with NULL value

## Key (primary key)

set of one or more attributes whose combined values are unique within a relation.

### Foreign key

an attribute (or set of) that always matches a key attibute in another relation.
Like a pointer.

### Composite keys

multi-column primary-key or foreign-key.

## Relational notation

Student(Id, name , GPA, country->Country)
Primary key fica sublinhada
Arrow e chave estrangeira e aponta para a tabela que esta a pontar

Classroom(building, room)
