require "rubygems"
require "ai4r"
data_labels = [ 'city', 'age_range', 'gender', 'marketing_target'  ]

data_items= [  
       ['New York',  '<30',      'M', 'Y'],
       ['Chicago',     '<30',      'M', 'Y'],
       ['Chicago',     '<30',      'F', 'Y'],
       ['New York',  '<30',      'M', 'Y'],
       ['New York',  '<30',      'M', 'Y'],
       ['Chicago',     '[30-50)',  'M', 'Y'],
       ['New York',  '[30-50)',  'F', 'N'],
       ['Chicago',     '[30-50)',  'F', 'Y'],
       ['New York',  '[30-50)',  'F', 'N'],
       ['Chicago',     '[50-80]', 'M', 'N'],
       ['New York',  '[50-80]', 'F', 'N'],
       ['New York',  '[50-80]', 'M', 'N'],
       ['Chicago',     '[50-80]', 'M', 'N'],
       ['New York',  '[50-80]', 'F', 'N'],
       ['Chicago',     '>80',      'F', 'Y']
     ]

data_set = DataSet.new(:data_items=>DATA_SET, :data_labels=>DATA_LABELS)
id3 = Ai4r::Classifiers::ID3.new.build(data_set)

id3.get_rules
         if age_range=='<30' then marketing_target='Y'
        elsif age_range=='[30-50)' and city=='Chicago' then marketing_target='Y'
        elsif age_range=='[30-50)' and city=='New York' then marketing_target='N'
        elsif age_range=='[50-80]' then marketing_target='N'
        elsif age_range=='>80' then marketing_target='Y'
        else raise 'There was not enough information during training to do a proper induction for this data element' end

id3.eval(['New York', '<30', 'M'])
  # =>  'Y'

