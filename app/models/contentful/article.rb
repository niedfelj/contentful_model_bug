class Contentful::Article < ContentfulModel::Base
   self.content_type_id = "article"

   has_one :author
   has_many :categories
   has_one :section #, class_name: "Contentful::Section", inverse_of: :articles
   has_many :modules
end