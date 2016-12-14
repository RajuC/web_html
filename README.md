# web_html
basic web hosting of a html using erlang and also works as sample REST API




## Routes and Requests

### Ping the service
curl -i "http://localhost:8081/ping"

### Info about the service
curl -i "http://localhost:8081/info"

### Post Req
curl -H "Content-Type: application/json" -X POST -d '{"question":"what is my name?","authorid":"12345"}' http://localhost:8081/post

### Get by Id request
curl -i "http://localhost:8081/id/123456/?echo=echomeplz"

### Post Req2
curl -H "Content-Type: application/json" -X POST -d '{"question":"what is my name?","authorid":"12345"}' http://localhost:8081/req 