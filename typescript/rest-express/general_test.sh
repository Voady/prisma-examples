#/bin/bash

# Here, the drafts endpoint will trigger to db-queries due to the prisma.findUnique().posts()
# and saturate the prepared statement cache
curl 'localhost:3000/users'
curl 'localhost:3000/user/1/drafts'
curl 'localhost:3000/post/1'
