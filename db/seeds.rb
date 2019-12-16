carson_user =  User.find_by(email: 'carson@grade.us') || User.create(email: 'carson@grade.us', password: "robert")
project = carson_user.projects.create(name: 'Grade.us API (Version 4)', description: 'This is the API for Grade.us.')

project.generate_default_content!('lib/gradeus_content.yml')

project.servers.create(url: 'https://grade-staging.com/api/v4', description: 'Staging server for Grade.us.')
project.servers.create(url: 'https://grade.us/api/v4', description: 'Production server for Grade.us.')
