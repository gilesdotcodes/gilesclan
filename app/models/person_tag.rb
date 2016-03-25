class PersonTag < ActiveRecord::Base

  scope :outside_of_clan, ->  { where('name NOT IN (?)',
                                ['Stephen', 'Adrain', 'Carol', 'David',
                                  'Emma', 'Faye', 'James', 'Arthur'])
                              }

end
