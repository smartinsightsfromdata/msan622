csvclean redditSubmissions.csv
csvcut -xc number_of_upvotes,number_of_downvotes redditSubmissions.csv | sed -n '1!p' | scatter
csvcut -xc total_votes redditSubmissions.csv | sed -n '1!p' | hist

