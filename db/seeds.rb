project = Project.create(name: 'Grade.us API (Version 4)')

chapters = [
  { title: "Introduction", content: "The Grade.us API is a RESTful API, responding to JSON requests for intuitive resources used with the Grade.us platform. This API supplants existing Grade.us API's, but it is recommended that customers use this Version 4 API as prior versions will ultimately be deprecated.", rank: 1},
  { title: "Getting started", content: "Only Agency and higher Plans have access to our API, which can be found at this root URL:  ```https://grade.us/api/v4```", rank: 2},
  {title: "Authentication", rank: 3}, 
  {title:"Error handling", rank: 4}, 
  {title:"Endpoints", rank: 5}
]

chapters.each do |c|
  puts c.inspect
  chapter = project.chapters.new(title: c[:title])
  chapter.content = c[:content] if c[:content]
  chapter.rank = c[:rank] if c[:rank]
  chapter.save
end