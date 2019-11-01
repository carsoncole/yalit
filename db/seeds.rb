carson_user =  User.find_by(email: 'carson@grade.us') || User.create(email: 'carson@grade.us', password: "robert")
project = carson_user.projects.create(name: 'Grade.us API (Version 4)')

chapters = 
  [
  {   
    title: "Introduction",
    content: "The Grade.us API allows for access and management of many Grade.us features through the API. This API is a RESTful API, responding to JSON requests.

This API supplants existing Grade.us API's, but it is recommended that customers use this Version 4 API as prior versions will ultimately be deprecated.", 
    rank: 1
  },
  { 
    title: "Getting started",
    content: "The Grade.us API responds to standard `HTTP`, `GET`, `POST`, `PUT`, `PATCH`, and `DELETE` methods. These methods can be translated into the following activities:

<ul>
<li>GET - Read</li>
<li>POST - Create</li>
<li>PUT/PATCH - Update</li>
<li>DELETE - Destroy</li>
</ul>", 
    rank: 2, 
    sections:
      [
      {
        title: "Base URL", 
        content: "Only Agency and higher Plans have access to our API, which can be found at this root URL:  

<div class='info'>https://grade.us/api/v4</div>"
      }, 
      {
        title: 'API Access Key', 
        content: "The Grade.us API access key can be found in your Grade.us settings under your account profile. These key is necessary for all API requests, and will scope API requests to a specific account and its related resources."
      }
      ]
  },
  {
    title: "Authentication", 
    content: "Grade.us HTTP requests to the REST API are protected with HTTP Basic authentication. All requests should include your API key encoded as the user name.

<div class='request'><div class='title'>CURL</div>
curl -G https://grade.us/api/v4/Users \
    -u '[YOUR API KEY]:
</div>

The ':' is important as it then does not require a separate password to be provided.", 
    rank: 3
  }, 
  {
    title:"Error handling", 
    content: "Error responses that may occur on requests will generally be informative may provide, in addition the a standard HTTP error response code, a custom error code.

<div class='info'>
<h3 class='mt-0'>Standard HTTP Codes</h3>
- Informational responses (100–199)<br />
- Successful responses (200–299)<br />
- Redirects (300–399)<br />
- Client errors (400–499)<br />
- Server errors (500–599)<br />
</div>

<div class='info'>
<h3 class='mt-0'>Custom Grade.us Codes</h3>
- 1001 Invalid authentication key<br />
- 1002 Account suspended<br />
- 1100 Access to that resource is temporarily unavailable<br />
- 1101 Access to that resource is available<br />
- 1102 Access to that resource is currently being rate-limited and is not available<br />",
    rank: 4
  }, 
  {
    title:"Endpoints", 
    rank: 5,
    sections: 
      [
      {
        title: "Users",
        is_resource: true,
        content: "Users provide access to the Grade.us application, and include all types of Users, such as the Master user, Sub-users, and Independent users.",
        sub_sections: 
          [
          {
            title: 'GET',
            is_verb: true,
            content: "To get a list of all users in an account:
<div class='request'><div class='title'>Request</div>
GET /users
</div>

<div class='response'><div class='title'>Response</div>
[

  { user_id: 2456, email: 'john.doe@gmail.com', created_at: '2019-10-01 01:23.123 TZ'},

  { user_id: 3147, email: 'mary.doe@gmail.com', created_at: '2019-10-02 02:41.113 TZ'},

]
</div>

To a specific user with, for example, an 'id' of 2456:
<div class='request'><div class='title'>Request</div>
GET /users/1035
</div>

<div class='response'><div class='title'>Response</div>
{ user_id: 1035, email: 'john.doe@gmail.com', created_at: '2019-10-01 01:23.123 TZ'}
</div>"
          },
          {
            title: 'POST',
            is_verb: true
          },
          {
            title: 'PATCH',
            is_verb: true
          },
          {
            title: 'DELETE',
            is_verb: true
          }
          ]
      }
      ]
  }
  ]

chapters.each do |c|
  chapter = project.chapters.new(title: c[:title])
  chapter.content = c[:content] if c[:content]
  chapter.rank = c[:rank] if c[:rank]
  chapter.save
  if c[:sections]
    c[:sections].each do |s|
      section = chapter.sections.create(title: s[:title], content: s[:content], is_resource: s[:is_resource])
      if s[:sub_sections]
        s[:sub_sections].each do |ss|
          sub_section = section.sub_sections.create(title: ss[:title], content: ss[:content], is_verb: ss[:is_verb])
        end
      end
    end
  end
end