class Student


  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote,
   :bio, :profile_url 

  @@all = []

  #The #new or initialize method takes in an argument of a hash and sets that 
  #new student's attributes using the key/value pairs of that hash.
  #It also adds that new student to the Student class' collection of all 
  #existing students, stored in the `@@all` class variable.
  def initialize(student_hash)
    
    student_hash.each do |key,value|
      self.send("#{key}=", value)
    end

    @@all << self
    
  end
  
  #uses the Scraper class to create new students with the correct name and location. 
  #Notice that it does not specifically make a call on the Scraper class to do this

  def self.create_from_collection(students_array)
    students_array.each do |individual|
     @@all << Student.new(individual)
    end
    
  end

  #uses the Scraper class to get a hash of a given students attributes and uses that
  # hash to set additional attributes for that student.

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key,value|
      self.send("#{key}=", value)
    end
  end

  # returns the class variable @@all
  def self.all
    @@all
  end

end

