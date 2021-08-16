class Relationship < ApplicationRecord
    #follower_idカラムの値から、end_usersテーブルのレコードを参照できるように
    belongs_to :follower, class_name: "EndUser"
    belongs_to :followed, class_name: "EndUser"
end
