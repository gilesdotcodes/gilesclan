class PersonTag < ActiveRecord::Base

  scope :outside_of_clan, ->  { where('name NOT IN (?)',
                                ['Stephen', 'Adrian', 'Carol', 'David',
                                  'Emma', 'James', 'Arthur'])
                              }

end
