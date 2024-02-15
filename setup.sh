export DB_HOST=127.0.0.1
export DB_NAME=$MYDB_NAME
export DB_USERNAME=$MYDB_USERNAME
export DB_PASSWORD=$MYDB_PASSWORD
export DB_PORT=5432
export DB_DIALECT=postgres


export NODE_ENV=development
export OPENAI_API_KEY=$MYOPENAI_API_KEY
export QA_READ_API_KEY=$MYQA_READ_API_KEY
export QA_READ_API_SECRET=$MYQA_READ_API_KEY
export QA_WRITE_API_KEY=$MYQA_READ_API_KEY
export QA_WRITE_API_SECRET=$MYQA_READ_API_KEY


# show all env values above
echo "Environment variables:"
env | grep -E '^(DB_|NODE_ENV|OPENAI_API_KEY|QA_READ_API_KEY|QA_READ_API_SECRET|QA_WRITE_API_KEY|QA_WRITE_API_SECRET)'
echo "======================="


# run the app
