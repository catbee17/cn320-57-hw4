#5510613259 น.ส.วรินทรเขมชัยวิพุธ
#5510613325 น.ส.ชมพูนิกข์ ประการแก้ว

class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
end
