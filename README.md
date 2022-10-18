# Yalit

API white label document hosting and testing service. Default configuration is to utilize Heroku for hosting the app and DNS resolution, but easily modifiable to host in any cloud.

## Configuration


### Action Mailer
Action mailer settings for user account administration is set in each respective environment configuration file.


### Hosting
Default configuration is to use Heroku for DNS resolution to white-labeled API documentation. The necessary environment variables that are required are:

- HEROKU_APP_NAME
- HEROKU_API_KEY

