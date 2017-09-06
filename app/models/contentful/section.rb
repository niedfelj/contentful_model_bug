class Contentful::Section < ContentfulModel::Base
   self.content_type_id = "section"

   has_many :categories, class_name: "Contentful::Category", inverse_of: :sections

   belongs_to_many :articles, inverse_of: :section

end