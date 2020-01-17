class Idea < ApplicationRecord
    validates_presence_of   :name, :message => 'Please Enter Name Of Project.'
    validates_presence_of   :description, :message => 'Please Enter Description of  Project.'
    has_many :comments
    has_many_attached :images
    belongs_to :user
end


