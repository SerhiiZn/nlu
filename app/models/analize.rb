class Analize < ApplicationRecord
  belongs_to :site_data, class_name: 'SiteDatum'
end
