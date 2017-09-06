class Contentful::Product < ContentfulModel::Base
   self.content_type_id = "product"

   has_many :images
   has_many :categories
   has_many :tags
   
end