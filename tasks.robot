*** Settings ***
Documentation     Template robot main suite.
Library           RPA.Tables
Library           RPA.Email.ImapSmtp
Library           RPA.Robocloud.Secrets

*** Variables ***
${DataFile}=      DT.csv

*** Keywords ***
Sending Email
    ${Secret}=    Get Secret    credentials
    Authorize    ${secret}[username]    ${secret}[password]    smtp_server=smtp.gmail.com    smtp_port=587
    Send Message    ${secret}[username]    ${secret}[username]    subject=RPA BOT Message    body=RPA BOT Message

*** Tasks ***
Table Keywords Demo
    ${DT}=    Read table from CSV    ${DataFile}    header=True
    FOR    ${row}    IN    @{DT}
        IF    "${row}[Technology]" == "RPA"
            Sending Email
        ELSE
            Log    Email Not send
        END
    END
