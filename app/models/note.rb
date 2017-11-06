class Note < ActiveRecord::Base

  before_create :add_owner_to_readers

  belongs_to :user
  has_many   :viewers
  has_many   :readers, :through => :viewers, :source =>  :user

  def visible_to=(csreaders) #=> coma seprated strings of readers
    if !csreaders.blank?
      allowed_readers = csreaders.split(',').collect {|reader| reader.strip}

      allowed_readers.each do  |reader_name|
        reader = User.find_or_create_by(:name => reader_name)
        self.readers << reader unless self.readers.include?(reader)
      end

    end
  end

  def visible_to
    self.readers.collect{|u| u.name}.sort.join(', ')
  end

  def add_owner_to_readers
    self.readers << self.user unless  self.readers.include?(self.user)
  end

end
