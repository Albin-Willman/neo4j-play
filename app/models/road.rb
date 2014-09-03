class Road
  include Neo4j::ActiveRel

  from_class City
  to_class   City
  type 'road'


  property :length, type: Integer

end
