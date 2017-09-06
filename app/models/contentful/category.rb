class Contentful::Category < ContentfulModel::Base
   self.content_type_id = "category"

   belongs_to_many :sections, inverse_of: :categories

end