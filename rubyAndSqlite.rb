require 'sqlite3'

class Chef

  def initialize(first_name:, last_name:, birthday:, email:, phone:)
    @first_name = first_name
    @last_name = last_name
    @birthday = birthday
    @email = email
    @phone = phone
    @created_at = Time.now
    @updated_at = Time.now
  end

  def self.create_table
    Chef.db.execute(
      <<-SQL
        CREATE TABLE chefs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name VARCHAR(64) NOT NULL,
          last_name VARCHAR(64) NOT NULL,
          birthday DATE NOT NULL,
          email VARCHAR(64) NOT NULL,
          phone VARCHAR(64) NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );
      SQL
    )
  end

  def self.seed
    Chef.db.execute(
      <<-SQL
        --INSERT INTO chefs
          --(first_name, last_name, birthday, email, phone, created_at, updated_at)
        --VALUES
          --('Ferran', 'Adriá', '1985-02-09', 'ferran.adria@elbulli.com', '42381093238', DATETIME('now'), DATETIME('now'));
        -- Añade aquí más registros
        INSERT INTO chefs
          (first_name, last_name, birthday, email, phone, created_at, updated_at)
        VALUES
          ('Aldo', 'Marquez', '1997-17-08', 'aldo@chef.com', '123456789', DATETIME('now'), DATETIME('now'));
      SQL
    )
  end
  def self.all
    Chef.db.execute(
      <<-SQL
      SELECT * FROM chefs
      SQL
      )
  end

  def self.where(query, search)
    Chef.db.execute(
      <<-SQL
      SELECT * FROM chefs
      where "#{query}" = "#{search}"
      OR
      "#{query}" = "?, #{search}"
      SQL
      )
  end

  def save
    Chef.db.execute(
      <<-SQL
      INSERT INTO chefs 
      (first_name,last_name,birthday,email,phone,created_at,updated_at)
      VALUES ("#{@first_name}", "#{@last_name}", "#{@birthday}", "#{@email}", "#{@phone}", "#{@created_at}", "#{@updated_at}")
      SQL
      )
  end

  def self.delete(query, search)
    Chef.db.execute(
      <<-SQL
      DELETE FROM chefs
      WHERE "#{query}" = "#{search}"
      SQL
      )
  end

  private

  def self.db
    @@db ||= SQLite3::Database.new("chefs.db")
  end

end

p chefsito = Chef.new(first_name: 'Nacho', last_name:'Betancourt', birthday:'1989-07-20', email:'nacho@chef', phone:987456321)