# data modelling

## models

Entity-Relationship Model (E/R)
or
Unified Modeling Language (UML)

The can be translated automatically to relational models (should always be checked
tho)

## classes

Descritor of a set of objects that share the same properties (semantic, attributes
and relationships) or concrete things.  
They are characterized by name, attributes and operations (we omit methods in data
base modeling). The name is usually written in singular form.  
A class can't have 2 attributes with same name. Attributes can be associated with
types:

- not predefined in UML;
- use the ones of the DBMS.

## Associations

**The name is optional**.
Relationships between objects of two classes.  
As an object is an instance of a class, a **link** is an instance of an association.

### association direction

It's optional. Can have an arrow bellow that indicates e.g.: a student applies to
an university.

### multiplicity of associations

- m..n - associated to at least m and at most n
- \* - associated with 0 or more
- 1..\* - associated with at least one (can have more)

The most common are:

- many-to-one: \* - 0..1
- one-to-one: 0..1 - 0..1
- many-to-many: \* - \*

### Complete associations

Every oobject must participate in the association
Example:

- complete many-to-one: 1..\* - 1
- complete one-to-one: 1 - 1
- complete many-to-many: 1..\* - 1--\*
