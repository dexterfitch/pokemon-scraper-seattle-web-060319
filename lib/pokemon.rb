class Pokemon
  attr_accessor :id, :name, :type, :hp, :db

  @@class_name = self.to_s.downcase

  def initialize(id:, name:, type:, hp: 60, db:)
    @id = id
    @name = name
    @type = type
    @hp = hp
    @db = db
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO #{@@class_name} (name, type) VALUES (?, ?)", name, type)
  end

  def self.find(given_id, db)
    pokemon = db.execute("SELECT * FROM pokemon WHERE id = ?", given_id).flatten
    Pokemon.new(id: pokemon[0], name: pokemon[1], type: pokemon[2], hp: pokemon[3], db: db)
  end

  def self.all
    db.execute("SELECT * FROM #{@@class_name}")
  end

  def alter_hp(given_hp, db)
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", given_hp, self.id)
  end
end