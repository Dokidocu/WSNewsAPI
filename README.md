# WSNewsAPI

iOS Client for newsapi.org for **v2**

## Latest update

| Version | Date       | Details                                                |
| ------- | ---------- | ------------------------------------------------------ |
| 2.0.0   | 15.02.2021 | First iOS version for newsapi.org by using Swagger 3.0 |

## Dependencies

| Framework | Version   |
| --------- | --------- |
| Alamofire | 4.9.0 (=) |

## How to use it ?

1. Get your Client API Key (Go to https://newsapi.org/docs/get-started to get your API key)
2. Link your project with SPM to WSNewsAPI
3. Configure the the client in order to make valid calls to the endpoints

WSNewsSwaggerClientAPI.customHeaders = ["Authorization": "Bearer \($clientAPIKey$)"]

2. Use WSNewsAPI class to make the call to the corresponding endpoints:
   1. sourcesGet(...)
   2. topHeadlinesGet(...)
   3. everythingGet(...)