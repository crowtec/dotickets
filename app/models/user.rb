class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :name, type: String
  field :last_name, type: String

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  has_mongoid_attached_file :picture

  has_many :projects

  # scope :current_platforms, -> {platforms.where(retro: false)}
  # scope :retro_platforms, -> {platforms.where(retro: true)}

  has_many :notifications



  scope :admin, ->{ where(role: 'admin') }
  field :role, type: String, default: 'basic'
  field :banned, type: Boolean, default: false

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates_length_of :password, minimum: 8, maximum: 16, on: :create


  def is_admin?
    role == 'admin'
  end

  def self.permitted_params
    [:name, :email, :password, :password_confirmation, :picture, :remember_me,
     :project_ids => []]
  end

end