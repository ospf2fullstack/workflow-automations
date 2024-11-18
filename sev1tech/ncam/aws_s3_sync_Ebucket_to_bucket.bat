@echo off
setlocal enabledelayedexpansion

set AWS_ACCESS_KEY_ID=
set AWS_SECRET_ACCESS_KEY=
set AWS_SESSION_TOKEN=

REM user input for aws username
echo | set /p usernamePrompt=Enter your aws username: 
set /p user=

REM User input for MFA Key.
echo | set /p tokenPrompt=Enter your token, from your authenticator app for user: !user!: 
set /p token=

@echo off
setlocal enabledelayedexpansion

REM Initialize session_response to empty, without this, the response is restricted to '}', which obviously won't work... 
set session_response=

REM Capture multi-line output
for /f "delims=" %%i in ('aws sts get-session-token --serial-number arn:aws-us-gov:iam::052330603252:mfa/!user! --token-code !token!') do (
    set session_response=!session_response!%%i
)

echo Full Response: !session_response!

for /f "delims=" %%a in ('echo !session_response! ^| jq -r ".Credentials.AccessKeyId"') do set AWS_ACCESS_KEY_ID=%%a
echo Access Key Successfully

for /f "delims=" %%b in ('echo !session_response! ^| jq -r ".Credentials.SecretAccessKey"') do set AWS_SECRET_ACCESS_KEY=%%b
echo Secret Access Key Successfully

for /f "delims=" %%c in ('echo !session_response! ^| jq -r ".Credentials.SessionToken"') do set AWS_SESSION_TOKEN=%%c
echo Session Token Set Successfully

aws s3 sync "E:/NCAM/cui_pointclouds/" "s3://ncam-cui-pointclouds-bucket/" --exclude "A1-1/*" --delete

endlocal
