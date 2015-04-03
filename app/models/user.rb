class User < ActiveRecord::Base
  validates_format_of :email, with: /[\w]+[\w\d+]*@[\w]+([._]?[\w\d]+)*(\.[\w\d]{2,3}){1,2}/
end