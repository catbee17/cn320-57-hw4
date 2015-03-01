#5510613259 น.ส.วรินทรเขมชัยวิพุธ
#5510613325 น.ส.ชมพูนิกข์ ประการแก้ว

# Add a declarative step here for populating the DB with movies.


Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    
    
    m = Movie.create!(movie)
  end
  
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  assert page.body.index(e1) < page.body.index(e2) , "Wrong order"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

Then /I should see (none|all) of the movies/ do |filter|
  db_size = 0
  db_size = Movie.all.size if filter == "all"
  page.find(:xpath, "//table[@id=\"movies\"]/tbody[count(tr) = #{db_size} ]")
end

Then /I should (not )?see movies rated: (.*)/ do |negation, rating_list|
  ratings = rating_list.split(",")
  if(negation)
    ratings.each do |x| 
      page.find(:xpath, "//table[@id=\"movies\"]/tbody[count(tr[td = \"#{x}\"]) = 0]")
    end
  else
    db_size = filtered_movies = Movie.find(:all, :conditions => {:rating => ratings}).size
    page.find(:xpath, "//table[@id=\"movies\"]/tbody[count(tr) = #{db_size} ]")
  end
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(",").each do | rating |
    rating = "ratings_" + rating
    if uncheck
      uncheck(rating)
    else
      check(rating)
    end
  end
end


Then /I should see all the movies/ do
  Movie.all_ratings.each do | rating  |
    rating = "ratings_" + rating
    if uncheck
      uncheck(rating)
    else
      check(rating)
    end
  end
end
