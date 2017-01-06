class Applicant < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader
  mount_uploader :attachments3, Attachments3Uploader
  has_secure_token :token
  validates :attachment,  :presence => true
  belongs_to :challenge
end
