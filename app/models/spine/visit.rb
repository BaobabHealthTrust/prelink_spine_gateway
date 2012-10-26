class Spine::Visit < ActiveRecord::Base
  set_table_name :visit
  set_primary_key :visit_id
  include Spine::Openmrs
  # TODO, this needs to account for current visit, which needs to account for possible retrospective entry
  named_scope :current, :conditions => 'visit.end_date IS NULL  AND visit.voided = 0'
  named_scope :active, :conditions => 'visit.voided = 0'
  belongs_to :patient, :class_name => 'Spine::Patient', :foreign_key => :patient_id, :dependent => :destroy
end
