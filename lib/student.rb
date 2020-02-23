class Student
  attr_accessor :name, :grade
  attr_reader :id
  
  @@all = []
  
  def initialize(id = nil, name, grade)
    @name = name
    @grade = grade
    @id = id
  end
  
  def self.all
    @all
  end
  
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students(name TEXT, grade INTEGER, id INTEGER PRIMARY KEY)
    SQL

    DB[:conn].execute(sql)
  end
  
   def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL

    DB[:conn].execute(sql)
  end
  
  def save
    sql = <<-SQL 
      INSERT INTO students (name, grade)
      VALUES(?, ?)
    SQL
      
    DB[:conn].execute(sql, self.name, self.grade)
      
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end
  
  def self.create(name, grade)
    student = STUDENT.new(name, grade)
    student.save
    student
  end 

  
  
    
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
end
