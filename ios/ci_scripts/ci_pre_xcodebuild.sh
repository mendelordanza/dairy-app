#!/bin/sh

echo "Stage: PRE-Xcode Build is activated .... "

# Move to the place where the scripts are located.
# This is important because the position of the subsequently mentioned files depend of this origin.
cd $CI_PRIMARY_REPOSITORY_PATH/ci_scripts || exit 1

printf "{\n  \"OPENAI_API_KEY\": \"%s\",\n  \"BASE_URL\": \"https://api.openai.com/v1\",\n  \"API_URL\": \"https://umibpwlepdiwpledrlmx.supabase.co\",\n  \"ANON_KEY\": \"%s\",\n  \"APPLE_KEY\": \"%s\",\n  \"FACEBOOK_ID\": \"281988144520542\"\n}" "$OPENAI_API_KEY" "$BASE_URL" "$API_URL" "$ANON_KEY" "$APPLE_KEY" "$FACEBOOK_ID" >> ../config/app_config.json

echo "Wrote Secrets.json file."

echo "Stage: PRE-Xcode Build is DONE .... "

exit 0