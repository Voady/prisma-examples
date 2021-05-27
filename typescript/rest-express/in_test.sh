#/bin/bash

# Since the max_prepared_stmt_count is set to 3, the fourth call here will 
# saturate the cache

curl 'localhost:3000/posts?ids[]=1'
curl  'localhost:3000/posts?ids[]=1&ids[]=2'
curl  'localhost:3000/posts?ids[]=1&ids[]=2&ids[]=3'
curl  'localhost:3000/posts?ids[]=1&ids[]=2&ids[]=3&ids[]=4'
