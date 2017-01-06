class Applicant < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader
  has_secure_token :token
  belongs_to :challenge
end
